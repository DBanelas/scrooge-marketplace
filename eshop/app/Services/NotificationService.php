<?php

namespace App\Services;

use Carbon\Carbon;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Http;

/**
 * Service class to bundle functions for notification actions
 */
class NotificationService {

    /**
     * Function to add a notification to user in the db
     * This function is called as soon as orion send a notifications
     */
    public function addNotificationToSubs($notInfo){
        $info = [];

        /**
         * Get subscribers array of the product
         */
        $subs = $notInfo['subscribers'];

        /**
         * Construct notification message
         */
        $notificationMessage = $notInfo['available'] ? 'Product ' . $notInfo['product_name'] . ' is now available!'
                                                     : 'Product ' . $notInfo['product_name'] . ' is no longer available!';
        
        /**
         * Construct notification array
         */
        $notification = [
            'product_id' => $notInfo['product_id'],
            'message' => $notificationMessage,
            'date' => Carbon::now()->toIso8601String()
        ];

        /**
         * Add a notification to every sub of the product 
         */
        foreach($subs as $userID){
            $response = Http::put('http://dss:6565/api/v1/notifications/'. $userID, $notification);
            if ($response->status() != Response::HTTP_OK){
                $info['error'] = true;
                break;
            }
        }
        return $info;
    }

    /**
     * Function to delete a notification with notID from user with userID
     */
    public function deleteNotificationOfUser($oauthToken, $userID, $notID) {
        $info = [];

        /**
         * Make request to dss (through proxy) to delete the notification
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->delete('http://dss-pep-proxy:4001/api/v1/notifications/'. $userID . '/'. 'notification/' . $notID);

        if($response->status() != Response::HTTP_OK){
            $info['error'] = true;
        }

        return $info;
    }

    /**
     * Function to fetch notifications of user from dss
     */
    public function getNotificationsOfUser($oauthToken, $userID){
        $info = [];

        /**
         * Make request to dss (through proxy) to fetch the notifications of the user
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->get('http://dss-pep-proxy:4001/api/v1/notifications/'. $userID);

        if($response->status() != Response::HTTP_OK){
            $info['error'] = true;
            return $info;
        }

        $info['notifications'] = json_decode($response->body())->notifications; 
        return $info;
    }

    public function createNotificationDocument($userID){
        $info = [];
        $response = Http::post('http://dss:6565/api/v1/notifications/'. $userID);
        if ($response->status() != Response::HTTP_OK){
            $info['error'] = true;
        }
        return $info;
    }
}