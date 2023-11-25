<?php

namespace App\Http\Controllers;

use App\Services\OrionService;
use App\Services\UserService;
use App\Services\ProductService;
use Illuminate\Support\Facades\Session;

/**
 * Controller class to handle shop actions
 */
class ShopController extends Controller
{
    /**
     * Necessary services in order to fetch the products
     */
    protected $productService;
    protected $userService;
    protected $orionService;

    public function __construct(
        ProductService $productService,
        UserService $userService,
        OrionService $orionService
        ) {
        $this->productService = $productService;
        $this->userService = $userService;
        $this->orionService = $orionService;
    }

    /**
     * Controller method to list all products and shoe them in shop page
     */
    public function paginatedIndex(){   

        /**
         * Fetching all products using productService
         */
        $userID = Session::get('id');
        $oauthToken = Session::get('oauth-token');
        $prodInfo = $this->productService->fetchAllProducts($oauthToken);

        /**
         * If an error has occured, abort
         */
        if (isset($prodInfo['error'])){
            abort(500);
        }

        /**
         * Get products from productService
         */
        $products = $prodInfo['products'];
        $sellerUsernames = [];
        $notificationsOn = [];

        /**
         * Iterate through products and see if the currect logged in user
         * 
         */
        foreach($products as $index=>$product){

            /**
             * Get subscribers of every product from orion, abort on error
             */
            $info = $this->orionService->getSubsOfProduct($oauthToken, $product->_id);
            if(isset($info['error'])){
                abort(500);
            }

            /**
             * If logged in user is in sub list of product, mark product as subscribed
             */
            if (in_array($userID, $info['subs'])) $notificationsOn[$index] = true;
            else $notificationsOn[$index] = false;

            /**
             * Use userService to fetch seller username in order
             * to diplay it in shop page 
             */
            $seller = $this->userService->getUserByID($product->seller_id)['user'];
            $sellerUsernames[$index] = $seller->username;
        }

        /**
         * Return shop page view with all necessary info
         */
        return view('shop', [
            'products' => $products,
            'notificationsOn' => $notificationsOn,
            'sellerUsernames' => $sellerUsernames
        ]);
    }
}
