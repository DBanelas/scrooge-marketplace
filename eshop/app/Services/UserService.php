<?php

namespace App\Services;

use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class UserService {
    
    /**
     * Private method to get admin token for subsequent requests
     */
    private function getAdminToken(){
        $adminToken = Http::withHeaders([
            'Content-Type' => 'application/json'
        ])->post('http://keyrock:3005/v1/auth/tokens', [
            'name' => 'admin@test.com',
            'password' => '1234'
        ])->header('X-Subject-Token');

        return $adminToken;
    }


    /**
     * Method to fetch info of user specified by xSubjToken
     * @param string $xSubjToken: Token acquired at login
     * @return array $info: Array containing errors or user info  
     */
    public function getLoggedInUser($xSubjToken){
        $info = [];

        /**
         * Keyrock request to return the specified user's id
         * Set error and return if this request fails
         */
        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'X-Auth-token' => $xSubjToken,
            'X-Subject-token' => $xSubjToken,
        ])->acceptJson()
          ->get('http://keyrock:3005/v1/auth/tokens');

        if ($response->status() != 200){
            $info['errors'] = 'Cannot retrieve user ID';
            return $info;
        }

        /**
         * Get user id from the above request's response
         */
        $userID = json_decode($response->body())->User->id;

        /**
         * Keyrock request to get info of user specified by userID
         * Set error and return if request fails
         */
        $response = Http::withHeaders([
            'X-Auth-token' => $xSubjToken
        ])->get('http://keyrock:3005/v1/users/' . $userID);
        
        if($response->status() != 200){
            $info['errors'] = 'Cannot retrieve user information';
            return $info;
        }

        /**
         * Get user info from the above request's response
         * Create a new user object for convinience and return
         */
        $userInfo = json_decode($response->body())->user;
        $user= new User([
            'keyrock_id' => $userInfo->id,
            'username' => $userInfo->username,
            'name' => explode(' ', $userInfo->description)[0],
            'surname' => explode(' ', $userInfo->description)[1],
            'email' => $userInfo->email,
            'role' => $userInfo->website,
            'confirmed' => $userInfo->enabled
        ]);

        $info['user'] = $user;
        return $info;
    }


    /**
     * Method to fetch all users from keyrock
     * and return them to the calling controller
     */
    public function listAllUsers(){
        $info = [];

        /**
         * Log is with admin credentials in order to 
         * get the admin token
         * 
         * Set error and return if tokens was not found
         */
        $adminToken = $this->getAdminToken();
        
        if (!$adminToken){
            $info['missing_x_token'] = 'Could not fetch X-Subject-Token';
            return $info;
        }

        /**
         * Request to fetch all users
         * Set error and return if request fails
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $adminToken
        ])->get('http://keyrock:3005/v1/users');

        if ($response->status() != 200){
            $info['fail_user_retrival'] = 'Cannot retrive user list';
            return $info;
        }

        /**
         * Get all users into an array and filter the admin default user
         * Return the final array with the user models
         */
        $usersInfo = json_decode($response->body())->users;
        foreach($usersInfo as $keyrockUser){
            if (strcmp($keyrockUser->id, 'admin') != 0){
                $user= new User([
                    'keyrock_id' => $keyrockUser->id,
                    'username' => $keyrockUser->username,
                    'name' => explode(' ', $keyrockUser->description)[0],
                    'surname' => explode(' ', $keyrockUser->description)[1],
                    'email' => $keyrockUser->email,
                    'role' => $keyrockUser->website,
                    'confirmed' => $keyrockUser->enabled
                ]);
            $info['users'][] = $user;
            }
        }
        return $info;
    }

    public function getUserByID($idToFetch){
        $info = [];

        /**
         * Log is with admin credentials in order to 
         * get the admin token
         * 
         * Set error and return if tokens was not found
         */
        $adminToken = $this->getAdminToken();

        if (!$adminToken){
            $info['missing_x_token'] = 'Could not fetch X-Subject-Token';
            return $info;
        }

        /**
         * Keyrock request to get info of user specified by userID
         * Set error and return if request fails
         */
        $response = Http::withHeaders([
            'X-Auth-token' => $adminToken
        ])->get('http://keyrock:3005/v1/users/' . $idToFetch);
        
        if($response->status() != 200){
            $info['errors'] = 'Cannot retrieve user information';
            return $info;
        }

        /**
         * Get user info from the above request's response
         * Create a new user object for convinience and return
         */
        $userInfo = json_decode($response->body())->user;
        $user= new User([
            'keyrock_id' => $userInfo->id,
            'username' => $userInfo->username,
            'name' => explode(' ', $userInfo->description)[0],
            'surname' => explode(' ', $userInfo->description)[1],
            'email' => $userInfo->email,
            'role' => $userInfo->website,
            'confirmed' => $userInfo->enabled
        ]);

        $info['user'] = $user;
        return $info;
    }

    /**
     * Method to activate or deactivete user
     * 
     * @param $id: ID of the user to be enabled or disabled
     * @param $enable: 1 for activation and 0 for deactivation
     * 
     * @return: true if query was successful
     */
    public function activateUser($id, $enable){
        $affected = DB::table('user')
                        ->where('id', $id)
                        ->update(['enabled' => $enable]);

        return $affected > 0;
    }

    /**
     * Method to delete a user given their id
     * 
     * @param $id: ID of the user to be deleted
     * @return boolean: true if user was deleted, false otherwise 
     */
    public function deleteUser($id){

        $adminToken = $this->getAdminToken();
        $response = Http::withHeaders([
            'X-Auth-token' => $adminToken 
        ])->delete('http://keyrock:3005/v1/users/'. $id);

        return $response->status() == 204;
    }

    /**
     * Method to update user with $id using the keyrock api
     * 
     * @param string $id: ID of user to be edited
     * @param array $newData: Array containing the new info of the user
     * @return array $info: Array containing errors or success flag
     */
    public function updateUser($id, $newData){
        $info = [];

        $adminToken = $this->getAdminToken();
        if (!$adminToken){
            $info['missing_x_token'] = 'Could not fetch X-Subject-Token';
            return $info;
        }

        $response = Http::withHeaders([
            'X-Auth-token' => $adminToken
        ])->patch('http://keyrock:3005/v1/users/' . $id, [
            'user' => [
                'username' => $newData['username'],
                'email' => $newData['email'],
                'website' => $newData['role'],
                'description' => $newData['name'] . ' ' . $newData['surname'] 
            ]
        ]);

        if ($response->status() == 409){
            $info['used_email'] = 'Email is already used';
            return $info;
        }

        $info['update_success'] = true;
        return $info;
    }
}