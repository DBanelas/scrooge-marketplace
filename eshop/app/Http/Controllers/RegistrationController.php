<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\CartService;
use App\Services\NotificationService;
use App\Services\RegistrationService;
use Illuminate\Support\Facades\Session;
/**
 * Controller class to handle registration
 */
class RegistrationController extends Controller {

    /**
     * Service class to handle the registration process with keyrock
     */
    protected $registrationService;
    protected $cartService;
    protected $notificationService;

    public function __construct(
        RegistrationService $registrationService,
        CartService $cartService,
        NotificationService $notificationService)
        {
        $this->registrationService = $registrationService;
        $this->cartService = $cartService;
        $this->notificationService = $notificationService;
    }

    /**
     * Controller method to show registration form to the guest
     */
    public function showRegistrationForm(){
        return view('register');
    }

    /**
     * Controller method to create and store a new user
     */
    public function store(Request $request){

        /**
         * Validate the new user's info
         */
        $validatedInfo = $request->validate([
            'name' => ['bail', 'required', 'alpha', 'max:255'],
            'surname' => ['bail', 'required', 'alpha', 'max:255'],
            'email' => ['required', 'email'],
            'username' =>['required'],
            'password' =>['required', 'min:6'],
            'role' => 'required'
        ]);

        /**
         * Call registerUser() method from Registration service and
         * return the errors that have occured
         */
        $errors = $this->registrationService->registerUser($validatedInfo);
        
        /**
         * If no errors have occured, redirect to login page
         * with 'redirected' session field set.
         * 
         * If thid field is set a message will be displayed.
         */
        if(isset($errors['user_id'])){
            if(strcmp($validatedInfo['role'], 'USER') == 0){
                $this->cartService->createCart(Session::get('oauth-token'), $errors['user_id']);
                $this->notificationService->createNotificationDocument($errors['user_id']);
            }
            return redirect('/login')->with('redirected', true);
        }

        /**
         * If there were any errors during the registration process,
         * flash the current session in order to keep the fields filled
         * and display the errors that have occured
         */
        $request->flash();
        return redirect('/register')->withErrors($errors);
    }
}
