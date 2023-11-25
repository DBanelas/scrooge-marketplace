<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

/**
 * Controller class to handle logouta action
 */
class LogoutController extends Controller
{
    /**
     * Controller method to logout the logged in user
     */
    public function logout(Request $request){
        /**
         * Logout the user
         */
        Auth::logout();

        /**
         * Invalidate currect session, regenerate token 
         * and redirect
         */
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect('/');
    }
}
