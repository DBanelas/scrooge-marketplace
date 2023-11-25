<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

/**
 * Service class that contains method for login
 */
class LoginService {


    /**
     * Function to login a user to keyrock
     */
    public function login($userCreds){
        $info = [];

        /**
         * Get user x-subj-token in order to user in subsequent requests
         */
        $xSubjToken = Http::withHeaders([
            'Content-Type' => 'application/json'
        ])->post('http://keyrock:3005/v1/auth/tokens', [
            'name' => $userCreds['email'],
            'password' => $userCreds['password']
        ])->header('X-Subject-Token');

        /**
         * If x-subj-token was not fetched, return with errors
         */
        if (!$xSubjToken){
            $info['errors']['login_failed'] = 'Invalid email or password';
            return $info;
        }

        $info['x-subj-token'] = $xSubjToken;

        /**
         * request to get oath-token of user from keyrock
         */
        $response = Http::withHeaders([
            'Authorization' => 'Basic'.' '. env('KEYROCK_APP_ID')
        ])->asForm()
          ->post('http://keyrock:3005/oauth2/token', [
            'grant_type' => 'password',
            'username' => $userCreds['email'],
            'password' => $userCreds['password']
        ]);
        
        /**
         * If request failed return with errors
         */
        if ($response->status() != 200){
            $info['errors']['oauth_failed'] = 'Cannot retrieve oauth2 token';
            return $info;
        }

        /**
         * Return with all necessary info
         */
        $info['oauth-token'] = json_decode($response->body())->access_token;
        return $info; 
    }
}

