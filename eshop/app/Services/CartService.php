<?php

namespace App\Services;

use Illuminate\Http\Response;
use Illuminate\Support\Facades\Http;

/**
 * Service class that bundles all necessary methods for 
 * making requests about carts to dss
 */
class CartService {
    /**
     * Function to make request to dss to create an empty cart for a user
     * This request cannot go through proxy, since at registration time
     * no oauth token is available
     */
    public function createCart($oauthToken, $userID){
        $info = [];
        $response = Http::post('http://dss:6565/api/v1/carts/' . $userID);
        if ($response->status() == Response::HTTP_OK){
            $info['success'] = true;
        }
        return $info;
    }

    /**
     * Function to make request to dss to delete a user's cart
     */
    public function deleteCart($oauthToken, $userID){
        $info = [];
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->delete('http://dss-pep-proxy:4001/api/v1/carts/' . $userID);
        if ($response->status() == Response::HTTP_OK){
            $info['success'] = true;
        }
        return $info;
    }

    /**
     * Function to make request to dss to fetch the cart of a user
     */
    public function getUserCart($oauthToken, $userID){
        $info = [];

        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->get('http://dss-pep-proxy:4001/api/v1/carts/' . $userID);

        /**
         * If error occured set error flag
         */
        if ($response->status() == Response::HTTP_OK){
            $info['cart'] = json_decode($response->body())->cart;
        } else {
            $info['error'] = 'Cart not found!';
        }
        return $info;
    }

    /**
     * Function to make request to dss to add product
     * with productID to cart of user with userID
     */
    public function addToCart($oauthToken, $userID, $productID){
        $info = [];

        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->post('http://dss-pep-proxy:4001/api/v1/carts/' . $userID . '/product'. '/' . $productID);

        /**
         * If error occured set error flag
         */
        if ($response->status() == Response::HTTP_OK) {
            $info['success'] = true;
        } else {
            $info['error'] = true;
        }
        return $info;
    }

    /**
     * Function to make request to dss to remove product
     * with productID from cart of user with userID
     * 
     * Makes another request to fetch the update number of 
     * products and total price of the cart
     * 
     * Sets error flags if anything failed
     */
    public function removeFromCart($oauthToken, $userID, $productID){
        $info = [];

        /**
         * Request to delete product from cart
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->delete('http://dss-pep-proxy:4001/api/v1/carts/' . $userID . '/product'. '/' . $productID);

        if ($response->status() == Response::HTTP_OK) {
            $response_2 = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->get('http://dss-pep-proxy:4001/api/v1/carts/' . $userID . '/priceAndCount');
            /**
             * If first request was successfull, make request to fetch product count and
             * total price of the cart
             */
            if ($response_2->status() == Response::HTTP_OK){
                $cartInfo = json_decode($response_2->body());
                $info['product_count'] = $cartInfo->product_count;
                $info['total_price'] = $cartInfo->total_price;
            } else {
                $info['error'] = true;
            }
        } else {
            $info['error'] = true;
        }
        return $info;
    }
}