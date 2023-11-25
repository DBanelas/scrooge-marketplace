<?php

namespace App\Services;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class ProductService {
    protected $orionService;

    public function __construct(OrionService $orionService) {
        $this->orionService = $orionService;
    }

    /**
     * Function to fetch all products from dss
     */
    public function fetchAllProducts($oauthToken){
        $info = [];

        /**
         * Make request to dss (through proxy) in order to fetch all products from db
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->get('http://dss-pep-proxy:4001/api/v1/products');

        /**
         * If error return error, else return product array
         */
        if ($response->status() == Response::HTTP_OK){
            $info['products'] = json_decode($response->body())->products;
        } else {
            $info['error'] = true;
        }
        return $info;
    }

    /**
     * Function to add a product in all needed databases
     * First adds the product to data storage service database
     * Then adds the product to orion-cb service using OrionService
     */
    public function addProduct($oauthToken, $prodInfo, $sellerID){
        $prodInfo['seller_id'] = $sellerID;
        $prodInfo['available'] = false;
        $info = [];

        /**
         * Add product to data storage service
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->post('http://dss-pep-proxy:4001/api/v1/products', $prodInfo);

        if ($response->status() == Response::HTTP_CREATED){
            $product = json_decode($response->body())->product;
            $info['product'] = $product;
            /**
             * If product was added to dss successfully
             * Add product to orion service
             */
            $orionInfo = $this->orionService->createEntity($oauthToken, $product);
            if(isset($orionInfo['error'])) $info['error'] = true;
            return $info;
        }
        
        /**
         * Propagete errors to controller
         */
        if ($response->status() == Response::HTTP_CONFLICT) $info['error_conflict'] = true;
        else $info['error'] = true; 
        return $info;
    }

    /**
     * Function to fetch products of user with userID
     */
    public function fetchProductsOfUser($oauthToken, $userID){
        $info = [];

        /**
         * Make request to dss (through proxy) in order to fetch all products of user
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->get('http://dss-pep-proxy:4001/api/v1/user/'.$userID.'/products');

        /**
         * If error return error, else return product array
         */
        if ($response->status() == Response::HTTP_OK) $info['products'] = json_decode($response->body())->products;
        else $info['error'] = true;
        return $info;
    }

    /**
     * function to get product from its id
     */
    public function getProductByID($oauthToken, $id){
        $info = [];
        
        /**
         * Make request to dss (through proxy) in order to get the product 
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->get('http://dss-pep-proxy:4001/api/v1/products/'. $id);
        
        /**
         * If error return error, else return product
         */
        if ($response->status() == Response::HTTP_OK) $info['product'] = json_decode($response->body())->product;
        else $info['error'] = 'Product not found';
        return $info;
    }


    /**
     * Function to update a product in all needed databases
     * First updates the product in data storage service db
     * Then updates the product entity in orion service
     */
    public function updateProduct($oauthToken, $id, $newData){

        $info = [];
        /**
         * Update the product in dss
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->patch('http://dss-pep-proxy:4001/api/v1/products/'.$id, $newData);
        
        /**
         * If successfull, update the product in orion or return the errors
         */
        if($response->status() == Response::HTTP_OK){
            $orionInfo = $this->orionService->updateEntity($oauthToken, $id, $newData);
            if(isset($orionInfo['error'])) $info['error'] = true;
            else $info['success'] = true;
            return $info;  
        }
        
        /**
         * Propagate errors to controller
         */
        if ($response->status() == Response::HTTP_CONFLICT) $info['error_conflict'] = true;
        else $info['error'] = true;
        return $info;
    }

    /**
     * Function to delete a product from all needed databases
     * First dremoves the product from all carts
     * Then deletes the product from dss
     * Then deletes the product from orion db
     */
    public function deleteProduct($oauthToken, $prodID){
        $info = [];
        /**
         * Make request to remove product from all carts
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->delete('http://dss-pep-proxy:4001/api/v1/removeFromAll/carts/product/'. $prodID);


        if ($response->status() == Response::HTTP_OK){
            /**
             * If successful, delete product from dss
             */
            $response2 = Http::delete('http://dss:6565/api/v1/products/'. $prodID);
            if ($response2->status() == Response::HTTP_OK){
                /**
                 * If successful, delete product entity from orion
                 */
                $orionInfo = $this->orionService->deleteEntity($oauthToken, $prodID);
                if(isset($orionInfo['error'])) $info['error'] = true;
                else $info['success'] = true;
            } else
                $info['error'] = true;    
        } else
            $info['error'] = true;

        return $info;
    }

    /**
     * Functions to make product available or unavailable using the updateProduct() method
     */
    public function enableProduct($oauthToken, $id){
        return $this->updateProduct($oauthToken, $id, ['available' => true]);
    }

    public function disableProduct($oauthToken, $id){
        return $this->updateProduct($oauthToken, $id, ['available' => false]);
    }
}