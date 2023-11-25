<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use App\Services\CartService;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Session;

/**
 * Controller class to handle cart related actions
 */
class CartController extends Controller
{
    protected $cartService;

    public function __construct(CartService $cartService) {
        $this->cartService = $cartService;
    }
    /**
     * Controller method to show all items of logged in user's cart
     */
    public function index(){
        /**
         * Fetch logged in user's cart
         */
        $cartInfo = $this->cartService->getUserCart(Session::get('oauth-token'), Session::get('id'));

        if (isset($cartInfo['error'])){
            abort(500);
        }
        /**
         * Fetch cart's products
         */
        $cart = $cartInfo['cart'];
        $products = $cart->products;

        /**
         * Get procucts' count and sum and return the info to cart view
         */
        $itemCount = $cart->product_count;
        $totalPrice = $cart->total_price;

        return view('cart2', ['products' => $products, 'itemCount' => $itemCount, 'totalPrice' => $totalPrice]);
    }  

    /**
     * Controller method to add to cart product with id
     */
    public function addToCart($id){

        $info = $this->cartService->addToCart(Session::get('oauth-token'), Session::get('id'), $id);
        if(isset($info['error'])){
            abort(500);
        }

        return response()->json([
            'status' => 200
        ]);
    }
    
    /**
     * Controller method to remove prodct with id from cart
     */
    public function removeFromCart($id){
        /**
         * Get logged in user's cart
         */
        $info = $this->cartService->removeFromCart(Session::get('oauth-token'), Session::get('id'), $id);

        if(isset($info['error'])){
            abort(500);
        }

        /**
         * Return success response along with cart info
         */
        return response()->json([
            'status' => 200,
            'item_count' => $info['product_count'],
            'total_price' => $info['total_price']
        ]);

    }
}
