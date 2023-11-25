<?php

namespace App\Providers;

use Illuminate\Support\Facades\DB;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Blade;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        Paginator::useBootstrap();

        Blade::if('admin', function () {            
            if(strcmp(Session::get('role'), 'ADMIN') == 0){
                return 1;
            }
            return 0;
        });

        Blade::if('user', function () {            
            if(strcmp(Session::get('role'), 'USER') == 0){
                return 1;
            }
            return 0;
        });

        Blade::if('seller', function () {            
            if(strcmp(Session::get('role'), 'PRODUCT_SELLER') == 0){
                return 1;
            }
            return 0;
        });

        Blade::if('isLoggedIn', function() {
            if(Session::has('isLoggedIn')){
                return 1;
            }
            return 0;
        });

        Blade::if('isNotLoggedIn', function() {
            if(!Session::has('isLoggedIn')){
                return 1;
            }
            return 0;
        });
    }
}
