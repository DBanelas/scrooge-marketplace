<?php

namespace App\Http\Controllers;

use App\Services\LoginService;
use App\Services\UserService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;


/**
 * Controller class to handle login action
 */
class LoginController extends Controller {

    /**
     * Services that are going to be used to login a user
     */
    protected $loginService;
    protected $userService;

    public function __construct(LoginService $loginService, UserService $userService) {
        $this->loginService = $loginService;
        $this->userService = $userService;
    }
    /**
     * Controller method to show login screen
     */
    public function showLoginForm(){
        return view('login');
    }

    /**
     * Controller method to login 
     * @param request is type hinted and automatically injected by laravel
     */
    public function login(Request $request){
        /**
         * Get username and password from request.
         * 
         * Both are required and this method will produce an error if 
         * one of them is not provided.
         * 
         * The error will be shown to user in the login form.
         */
        $validatedCreds = $request->validate([
            'email' => ['required', 'email'],
            'password' => 'required',
        ]);

        /**
         * Ask loginService to authenticate user with given credentials
         * against KeyrockIDM and return their tokens (x-subj and oauth)
         */
        $loginInfo = $this->loginService->login($validatedCreds);

        /**
         * If any errors occured during the auth, show them in login form
         */
        if (isset($loginInfo['errors']['login_failed'])){
            return back()->withErrors(['loginError' => $loginInfo['errors']['login_failed']]); 
        }
        if (isset($loginInfo['errors']['oauth_failed'])){
            return back()->withErrors(['loginError' => $loginInfo['errors']['oauth_failed']]); 
        } 
        
        /**
         * Get user info from userService
         */
        $userInfo = $this->userService->getLoggedInUser($loginInfo['x-subj-token']);

        /**
         * If any errors occured during the info fetching, show them to login form
         */
        if(isset($userInfo['errors'])){
            return back()->withErrors(['loginError' => $userInfo['errors']]);    
        }

        /**
         * If code reached this point, user was succsessuly authenticated
         */
        $loggedInUser = $userInfo['user'];
        $request->session()->regenerate();
        $request->session()->put('isLoggedIn', true);
        $request->session()->put('x-subj-token', $loginInfo['x-subj-token']);
        $request->session()->put('oauth-token', $loginInfo['oauth-token']);
        $request->session()->put('id', $loggedInUser->keyrock_id);
        $request->session()->put('username', $loggedInUser->username);
        $request->session()->put('role', $loggedInUser->role);
        
        if (strcmp($loggedInUser->role, 'USER') == 0){
            return redirect('/userHome');
        }

        return redirect('/');

        
    }
}
