<?php

namespace App\Http\Controllers;

use App\Models\Cart;
use App\Models\Product;
use Carbon\Carbon;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Http;

class CartController extends Controller
{
    /**
     * Function to return all carts from the db
     */
    public function index(){
        return response()->json([
            'carts' => Cart::all()
        ], Response::HTTP_OK); 
    }

    /**
     * Function to create an empty cart for user with user_id 
     */
    public function create($user_id){
        Cart::create([
            'user_id' => $user_id,
            'products' => []
            ]);
        
        /**
         * Return success json
         */
        return response()->json([
            'result' => 'Cart created successfully'
        ], Response::HTTP_OK);
    }

    /**
     * Function to fetch the products of a user's cart
     */
    public function getUserCart($user_id){
        $cart = Cart::where('user_id', $user_id)->first();
        
        /**
         * Return error if cart does not exist
         */
        if(!$cart){
            return response()->json([
                'result' => 'Cart not found'
            ], Response::HTTP_NOT_FOUND);
        }

        /**
         * Iterate through cart products
         *  - Find product from id
         *  - Gather product info
         *  - add product info to product array
         *  - Compute total number of products 
         *  - Compute total price of products
         */
        $products = [];
        $product_count = 0;
        $total_price = 0;
        foreach($cart->products as $index => $product){
            $prod = Product::find($product['product_id']);
            $quantity = $product['quantity'];
            $product_count += $quantity;
            $total_price = round($total_price + $quantity*$prod->price, 2);
            $products['products'][strval($index)] = [
                'product_id' => $prod->id,
                'product_name' => $prod->name,
                'product_price' => $prod->price,
                'product_date' => $product['product_date'],
                'quantity' => $product['quantity']
            ];
        }

        /**
         * Add num of products and total price to products array
         */
        $products['total_price'] = $total_price;
        $products['product_count'] = $product_count;
        if(!isset($products['products'])){
            $products['products'] = [];
        }

        /**
         * Return products of cart
         */
        return response()->json([
            'cart' => $products
        ], Response::HTTP_OK);
    }

    /**
     * Function to get total price and product count
     * of cart of user with user_id
     */
    public function getPriceAndCount($user_id){
        $cart = Cart::where('user_id', $user_id)->first();
        
        if(!$cart){
            return response()->json([
                'result' => 'Cart not found'
            ], Response::HTTP_NOT_FOUND);
        }

        /**
         * Iterate through the products of the cart 
         * and compute the needed values
         */
        $product_count = 0;
        $total_price = 0;
        foreach($cart->products as $product){
            $prod = Product::find($product['product_id']);
            $quantity = $product['quantity'];
            $product_count += $quantity; 
            $total_price = round($total_price + $quantity*$prod->price, 2);
        }

        /**
         * return total price and product count
         */
        return response()->json([
            'product_count' => $product_count,
            'total_price' => $total_price
        ], Response::HTTP_OK);

    }

    /**
     * Method to remove product with product_id from 
     * cart of user with user_id
     */
    public function removeFromCart($user_id, $product_id){
        /**
         * If cartr does not exists, return error json
         */
        $cart = Cart::where('user_id', $user_id)->first();
        if(!$cart){
            return response()->json([
                'result' => 'Cart does not exist'
            ], Response::HTTP_NOT_FOUND);
        }

        /**
         * If product does not exists return error json
         */
        $prod = Product::find($product_id);
        if(!$prod){
            return response()->json([
                'result' => 'Product does not exist'
            ], Response::HTTP_NOT_FOUND);
        }

        /**
         * Iterate through products and find the info of the correct product
         */
        $multiple = false;
        $quantity = 1;
        $date = null;
        foreach($cart->products as $index => $product){
            if(strcmp($product_id, $product['product_id']) == 0){
                $date = $product['product_date'];
                if($product['quantity'] != 1) {
                    $multiple = true;
                    $quantity = $product['quantity'];
                }
            }
        }

        /**
         * Remove product from cart
         */
        $this->pullFromCart($cart, $prod->id, $quantity, $date);
        
        /**
         * If product quantity is greater than 1, remove quantity by 1
         */
        if($multiple){
            $this->pushToCart($cart, $prod->id, $quantity - 1, $date);
        }
        $cart->save();

        /**
         * Return json success
         */
        return response()->json([
            'result' => 'Product removed from cart successfully!'
        ], Response::HTTP_OK); 

    }


    /**
     * Function to add product with product_id to cart of user
     * user_id
     */
    public function addToCart($user_id, $product_id){
        /**
         * If product was not found , return error
         */
        $prod = Product::find($product_id);
        if(!$prod){
            return response()->json([
                'result' => 'Product does not exist'
            ], Response::HTTP_NOT_FOUND);
        }
        /**
         * If cart was not found create a cart for the user
         */
        $cart = Cart::where('user_id', $user_id)->first();
        if(!$cart){
            Cart::create([
            'user_id' => $user_id,
            'products' => []
            ]);
        }
        $cart = Cart::where('user_id', $user_id)->first();

        /**
         * Iterate through products and find info of the correct product
         */
        $found = false;
        $quantity = 1;
        $date = null;
        foreach($cart->products as $index => $product){
            if(strcmp($product_id, $product['product_id']) == 0){
                $found = true;
                $quantity = $product['quantity'];
                $date = $product['product_date'];
            }
        }

        /**
         * if product was not present in the cart, add it with quantity=1
         * else increase the quantity by 1
         */
        if(!$found){ 
            $this->pushToCart($cart, $prod->id, $quantity, Carbon::now()->toISOString()); 
        } else {
            $this->pullFromCart($cart, $prod->id, $quantity, $date);
            $this->pushToCart($cart, $prod->id, $quantity + 1, Carbon::now()->toISOString());  
        }
        $cart->save();

        /**
         * Return success json
         */
        return response()->json([
            'result' => 'Product added to cart successfully!'
        ], Response::HTTP_OK); 
    }

    /**
     * Mongodb specific functions to push and pull a product to and from a cart
     */
    private function pushToCart($cart, $prod_id, $quantity, $date){
        $cart->push('products',[ 
                [
                    'product_id' => $prod_id,
                    'product_date' => $date,
                    'quantity' => $quantity
                ]
            ]);
    }

    private function pullFromCart($cart, $prod_id, $quantity, $date){
        $cart->pull('products',[ 
                [
                    'product_id' => $prod_id,
                    'product_date' => $date,
                    'quantity' => $quantity
                ]
            ]);
    }


    /**
     * Function to delete cart of user with user_id
     */
    public function deleteCart($user_id){
        Cart::where('user_id', $user_id)->delete();
        return response()->json([
            'result' => 'Cart deleted successfully!'
        ], Response::HTTP_OK);
    }

    /**
     * Function to remove a product from all carts
     * This method is used when a product is deleted by its seller
     */
    public function removeFromAllCarts($product_id) {
        $prod = Product::find($product_id);
        if(!$prod){
            return response()->json([
                'result' => 'Product does not exist'
            ], Response::HTTP_NOT_FOUND);
        }

        //Iterate over all carts
        $carts = Cart::all();
        foreach($carts as $cart){
            //Get cart model, so as to be able to save it in db
            $userCart = Cart::where('user_id', $cart->user_id)->first();
            $found = false;
            $quantity = 1;
            $date = null;
            //Iterate over products and check if product_id is present
            foreach($userCart->products as $product){
                if (strcmp($product_id, $product['product_id']) == 0){
                    $found = true;
                    $quantity = $product['quantity'];
                    $date = $product['product_date'];
                }
            }

            if($found){
                $this->pullFromCart($userCart, $prod->id, $quantity, $date);
                $cart->save();
            }
        }

        return response()->json([
            'result' => 'Product deleted from all carts successfully'
        ], Response::HTTP_OK);
    }
}
