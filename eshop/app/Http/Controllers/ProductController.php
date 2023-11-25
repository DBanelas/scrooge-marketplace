<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use App\Models\Product;
use Illuminate\Http\Request;
use App\Services\OrionService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;
use App\Services\ProductService;
use Illuminate\Support\Facades\Session;

/**
 * Controller class to handle product related actions
 */
class ProductController extends Controller {
   
    protected $productService;

    public function __construct(ProductService $productService) {
        $this->productService = $productService;
    }

    /**
     * Controller method to list all products of the logged in user
     */
    public function index(){
        $prodInfo = $this->productService->fetchProductsOfUser(Session::get('oauth-token'), Session::get('id'));
        if (isset($prodInfo['error'])){
            abort(500);
        }
        $products = $prodInfo['products'];
        return view('products', compact('products'));
    }

    /**
     * Controller method to update a product
     */
    public function update(Request $request, $id){
        /**
         * Validate the new product info
         * Witdrawal date must be in the future
         */
        $validation_reqs = [
            'name' => ['bail', 'required'],
            'product_code' => ['bail', 'required'],
            'price' => ['bail', 'required'],
            'category' =>['bail', 'required']
        ];
        $validator = Validator::make($request->all(), $validation_reqs);

        /**
         * If validation fails, return response with the errors
         */
        if($validator->fails()){
            return response()->json([
                'status' => 400,
                'errors' => $validator->errors()
            ]);
        }

        /**
         * If new info is validated, update the product
         */
        $prodInfo = $this->productService->updateProduct(Session::get('oauth-token'), $id, $request->all());

        if(isset($prodInfo['error'])){
            return response()->json([
            'status' => 404,
            'message' => 'Unknown error has occured, please try again.'
        ]);
        }

        if(isset($prodInfo['error_conflict'])){
            return response()->json([
            'status' => 404,
            'message' => 'Product with given code already exists'
        ]);
        }

        /**
         * Return success code along with the new user info
         */
        $product = $this->productService->getProductByID(Session::get('oauth-token'), $id)['product'];
        return response()->json([
            'status' => 200,
            'product' => $product
        ]);
    }

    /**
     * Controller method to return info of specific product
     */
    public function show($id){
        /**
         * Find product and change date format in order for html to parse it correctly
         */
        
        $prodInfo = $this->productService->getProductByID(Session::get('oauth-token'), $id);

        if (isset($prodInfo['error'])){
            return response()->json([
            'status' => 404,
            'message' => 'Product not found.'
        ]);
        }

        /**
         * Return product info and date
         */
        return response()->json([
                'status' => 200,
                'product' => $prodInfo['product'],
        ]);   
    }

    /**
     * Function to create a new product 
     * 
     * Validate the product's info
     * Special validation rule for the withdrawal date; Must be in the future
     * Creates new product and updates the db
     * 
     * Returns success or error with messages
     */
    public function store(Request $request){

       /**
        * Validate product new product info
        * Withdrawal date must be in the future
        */
        $validation_reqs = [
            'name' => ['bail', 'required'],
            'product_code' => ['bail', 'required'],
            'price' => ['bail', 'required'],
            'category' =>['bail', 'required'],
        ];
        $validator = Validator::make($request->all(), $validation_reqs);

        /**
         * If validation fails, return response with errors
         */
        if($validator->fails()){
            return response()->json([
                'status' => 400,
                'errors' => $validator->messages()
            ]);
        }

        /**
         * If info is validated, create new product and insert it into db
         */
        $prodInfo = $this->productService->addProduct(Session::get('oauth-token'), $request->all(), Session::get('id'));

        if (isset($prodInfo['error'])){
            return response()->json([
                'status' => 404,
                'message' => 'Unknown error has occured, please try again.'
            ]);
        }

        if (isset($prodInfo['error_conflict'])){
            return response()->json([
                'status' => 404,
                'message' => 'Product with given code already exists.'
            ]);
        }

        /**
         * Return success response with product info
         */
        return response()->json([
            'status' => 200,
            'product' => $prodInfo['product'],
        ]);
    }

    /**
     * Function to delete product with the given id
     */
    public function destroy($id){
        $prodInfo = $this->productService->deleteProduct(Session::get('oauth-token'), $id);
        if(isset($prodInfo['success'])){
            return response()->json(['status' => 200,
                                     'message' => 'Product deleted succesfully!'                        
            ]);    
        }
        return response()->json(['status' => 400]);
    }
    
    /**
     * Controller method to make product available
     */
    public function makeAvailable($id){

        /**
         * Use productService to contact db
         */
        $prodInfo = $this->productService->enableProduct(Session::get('oauth-token'), $id);

        if(isset($prodInfo['error'])){
            return response()->json([
            'status' => 404,
            'message' => 'Unknown error has occured, please try again.'
        ]);
        }

        if(isset($prodInfo['error_conflict'])){
            return response()->json([
            'status' => 404,
            'message' => 'Product with given code already exists'
        ]);
        }

        return response()->json([
            'status' => 200,
            'message' => 'Product status changed successfully'
        ]);

    }

    public function makeUnavailable($id){
        $prodInfo = $this->productService->disableProduct(Session::get('oauth-token'), $id);

        if(isset($prodInfo['error'])){
            return response()->json([
            'status' => 404,
            'message' => 'Unknown error has occured, please try again.'
        ]);
        }

        if(isset($prodInfo['error_conflict'])){
            return response()->json([
            'status' => 404,
            'message' => 'Product with given code already exists'
        ]);
        }

        return response()->json([
            'status' => 200,
            'message' => 'Product status changed successfuly'
        ]);
        
    }
}
