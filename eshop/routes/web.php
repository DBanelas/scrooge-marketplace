<?php
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\LoginController;
use App\Http\Controllers\LogoutController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\RegistrationController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\NotificationController;
use App\Http\Controllers\ShopController;
use App\Http\Controllers\SubscriptionController;
use Illuminate\Support\Facades\Http;

Route::get('/', function () {
    return view('index');
});

Route::get('/logout', [LogoutController::class, 'logout']);

/**
 * Registration routes
 */
Route::get('/register', [RegistrationController::class, 'showRegistrationForm']);
Route::post('/register', [RegistrationController::class, 'store']);

/**
 * Login routes
 */
Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
Route::post('/login', [LoginController::class, 'login']);

/**
 * Admin routes
 */
Route::controller(UserController::class)->prefix('/admin')->middleware(['isLoggedIn', 'hasRole:ADMIN'])->group(function() {
    Route::get('/dashboard', 'showDashboard');
    Route::post('/activate/user/{id}', 'activate');
    Route::post('/deactivate/user/{id}', 'deactivate');
    Route::post('/delete/user/{id}', 'destroy');
    Route::post('/update/user/{id}','update'); 
    Route::get('/users/{id}', 'show');
});

/**
 * Seller routes
 */
Route::controller(ProductController::class)->prefix('/seller')->middleware(['isLoggedIn', 'hasRole:PRODUCT_SELLER'])->group(function(){
    Route::get('/products', 'index');
    Route::get('/products/{id}', 'show');
    Route::post('/delete/product/{id}', 'destroy');
    Route::post('/add-product', 'store');
    Route::post('/update/product/{id}', 'update');
    Route::post('/make-available/product/{id}', 'makeAvailable');
    Route::post('/make-unavailable/product/{id}', 'makeUnavailable');
});

/**
 * User routes
 */
Route::middleware(['isLoggedIn', 'hasRole:USER'])->group(function(){
    Route::get('/shop', [ShopController::class, 'paginatedIndex']);
    Route::get('/search', [ShopController::class, 'search']);
    Route::post('/addToCart/product/{id}', [CartController::class, 'addToCart']);
    Route::post('/removeFromCart/product/{id}', [CartController::class, 'removeFromCart']);
    Route::get('/myCart', [CartController::class, 'index']);
    Route::post('/addSubscription/product/{id}',[SubscriptionController::class, 'store']);
    Route::post('/removeSubscription/product/{id}', [SubscriptionController::class, 'destroy']);

    Route::get('/notifications/fetch', [NotificationController::class, 'getUserNotifications']);
    Route::get('/userHome', [NotificationController::class, 'showUserNotifications']);
    Route::post('/notifications/delete/{not_id}', [NotificationController::class, 'deleteNotificationOfUser']);
});
