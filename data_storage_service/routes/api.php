<?php

use App\Http\Controllers\CartController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\ProductController;
use Illuminate\Support\Facades\Route;

Route::controller(ProductController::class)->group(function() {
    Route::get('/user/{user_id}/products', 'showProductsOfUser');
    Route::get('/products', 'index');
    Route::get('/products/{id}', 'show');
    Route::post('/products', 'store');
    Route::patch('/products/{id}', 'update');
    Route::delete('/products/{id}', 'destroy');
});

Route::controller(CartController::class)->group(function() {
    Route::get('/carts', 'index');
    Route::post('carts/{user_id}', 'create');
    Route::get('/carts/{user_id}/priceAndCount', 'getPriceAndCount');
    Route::get('/carts/{user_id}', 'getUserCart');
    Route::post('/carts/{user_id}/product/{product_id}', 'addToCart');
    Route::delete('/carts/{user_id}/product/{product_id}', 'removeFromCart');
    Route::delete('/removeFromAll/carts/product/{product_id}', 'removeFromAllCarts');
    Route::delete('/carts/{user_id}', 'deleteCart');
});

Route::controller(NotificationController::class)->group(function() {
    Route::get('/notifications', 'index');
    Route::get('notifications/{user_id}', 'show');
    Route::put('/notifications/{user_id}', 'store');
    Route::post('/notifications/{user_id}', 'create');
    Route::delete('/notifications/{user_id}/notification/{not_id}', 'destroy');
});




