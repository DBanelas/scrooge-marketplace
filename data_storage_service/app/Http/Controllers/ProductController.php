<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class ProductController extends Controller
{

    public function index(){
        $products = Product::all();
        return response()->json([
            'products' => $products
        ], Response::HTTP_OK);
    }

    public function store(Request $request){

        $productCode = $request->product_code;
        $prod = Product::where('product_code', $productCode)->get();

        if(!$prod->isEmpty()){
            return response()->json([
            'result' => 'Product with provided code already exists!',
        ], Response::HTTP_CONFLICT);
        }

        $prod = Product::create($request->all());
        return response()->json([
            'result' => 'Product created successfuly!',
            'product' => $prod
        ], Response::HTTP_CREATED);
    }

    public function update(Request $request, $id){

        if ($request->has('check_code')){
            $productCode = $request->product_code;
            $prod = Product::where('product_code', $productCode)->get();
            if(!$prod->isEmpty()){
                return response()->json([
                'result' => 'Product with provided code already exists!',
            ], Response::HTTP_CONFLICT);
        }
        }

        //Check return value of update
        Product::where('_id', $id)
               ->update($request->all());
        return response()->json([
            "result" => "Product updated successfully"
        ], Response::HTTP_OK);
        
    }

    public function show(Request $request, $id){
        $product = Product::find($id);
        return response()->json([
            "product" => $product
        ], Response::HTTP_OK);
    }

    public function destroy(Request $request, $id){
        Product::destroy($id);
        return response()->json([
            "result" => "Product deleted successfully"
        ], Response::HTTP_OK);
    }

    public function showProductsOfUser($id){
        $products = Product::where('seller_id', $id)->get();
        return response()->json([
            "products" => $products
        ], Response::HTTP_OK);
    }
}
