<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use App\Services\NotificationService;
use Carbon\Carbon;
use Illuminate\Support\Facades\Session;


/**
 * Controller class to handle notification actions
 */
class NotificationController extends Controller
{
    protected $notificationService;

    public function __construct(NotificationService $notificationService) {
        $this->notificationService = $notificationService;
    }

    /**
     * Controller method to fetch and show notifications of logged in user
     */
    public function showUserNotifications(){
        $oauthToken = Session::get('oauth-token');
        $user_id = Session::get('id');
        
        /**
         * Using notificationService to get notifications of logged in user
         */
        $info = $this->notificationService->getNotificationsOfUser($oauthToken, $user_id);
        
        if(isset($info['error'])){
            abort(500);
        }

        return view('userIndex', ['notifications' => $info['notifications']]);
    }

    /**
     * Controller method to fetch notifications of logged in user
     * Returns json with notification in response
     */
    public function getUserNotifications(){
        $oauthToken = Session::get('oauth-token');
        $user_id = Session::get('id');
        $info = $this->notificationService->getNotificationsOfUser($oauthToken, $user_id);
        
        /**
         * If an error occured return error response
         */
        if(isset($info['error'])){
            return response()->json([
                'status' => 400
            ]);
        }

        /**
         * Formatting date of each notification 
         */
        $notDates = [];
        foreach($info['notifications'] as $notification){
            $notDates[] = Carbon::parse($notification->date)->format('d-m-Y');
        }

        /**
         * Return success json with notifications and dates
         */
        return response()->json([
            'status' => 200,
            'notifications' => $info['notifications'],
            'notDates' => $notDates
        ]);
    }

    /**
     * Controller method to delete a notification of the logged in user
     */
    public function deleteNotificationOfUser($not_id){
        $oauthToken = Session::get('oauth-token');
        $userID = Session::get('id');
        
        /**
         * Using notificationService to delete the notificatin 
         */
        $info = $this->notificationService->deleteNotificationOfUser($oauthToken, $userID, $not_id);

        /**
         * If an error occured return error json
         */
        if(isset($info['error'])){
            return response()->json([
            'status' => 400,
            'message' => 'Something went wrong!'
        ]);
        }

        /**
         * Return success json 
         */
        return response()->json([
            'status' => 200,
            'message' => 'Notification deleted successfully!'
        ]);
    }

    /**
     * Function to handle notification sent from orion
     * Orion service hits this endpoint
     */
    public function receiveNotification(Request $request){
        
        /**
         * Parse json request from orion
         */
        $subID = $request->input('subscriptionId');
        $data = $request->input('data');
        $prodID = $data[0]['id'];
        $prodName = $data[0]['name']['value'];
        $available = $data[0]['available']['value'];
        $subscribers = $data[0]['user_subs']['value'];

        /**
         * Create notification info array to store in db
         */
        $notInfo = [
            'product_id' => $prodID,
            'product_name' => $prodName,
            'available' => $available,
            'subscribers' => $subscribers
        ];

        /**
         * User notificationService to add notification to user in db
         */
        $info = $this->notificationService->addNotificationToSubs($notInfo);
        if(isset($info['error'])){
            abort(500);
        }
    }
}
