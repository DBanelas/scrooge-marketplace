<?php

namespace App\Services;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class RegistrationService {

    /**
     * Method to register user in Keyrock
     * @param mixed $userInfo: Array containing the user info from registration form
     * @return array $errors: Array containing errors that occured during registration
     */
    public function registerUser($userInfo){

        $errors = [];

        /**
         * Get admin x-subj-token in order to user in subsequent requests
         */
        $xSubjToken = Http::withHeaders([
            'Content-Type' => 'application/json'
        ])->post('http://keyrock:3005/v1/auth/tokens', [
            'name' => 'admin@test.com',
            'password' => '1234'
        ])->header('X-Subject-Token');

        if (!$xSubjToken){
            $errors['missing_x_token'] = 'Could not fetch X-Subject-Token';
            return $errors;
        }

        /**
         * Form the data to be inserted to keyrock db
         * This data will be transform to json in order to be sent
         */
        $data = [
            'user' => [
                'username' => $userInfo['username'],
                'email' => $userInfo['email'],
                'password' => $userInfo['password'],
                'website' => $userInfo['role'],
                'description' => $userInfo['name'] . ' ' . $userInfo['surname'],
                ]
            ];

        /**
         * Send create request with above data to keyrock
         */
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'X-Auth-Token' => $xSubjToken
        ])->withBody(json_encode($data), 'application/json')
          ->post('http://keyrock:3005/v1/users');

        $statusCode = $response->status();

        /**
         * If request failed, check the reason and return the result
         */
        if ($statusCode != 201){
            if ($statusCode == 409){
                $errors['email_exists'] = 'Email already exists';
            }else{
                $errors['fail_user_creation'] = 'Could not create user';
            }
            return $errors;
        }

        /**
         * Manually disable user at registration, because api is not working
         * Interact directly with the db
         */
        $responseBody = json_decode($response->body());
        DB::table('user')->where('email', $responseBody->user->email)
                         ->update(['enabled' => 0]);

        /**
         * Get the registered user id in order to create a cart
         */
        $errors['user_id'] = DB::table('user')->where('email', $responseBody->user->email)->get('id')[0]->id;
        return $errors;

    }
}