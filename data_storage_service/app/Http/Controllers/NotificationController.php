<?php

namespace App\Http\Controllers;

use Carbon\Carbon;
use Illuminate\Support\Str;
use App\Models\Notification;
use Illuminate\Http\Request;
use Illuminate\Http\Response;

class NotificationController extends Controller
{

    /**
     * Function to return all notifications
     */
    public function index(){
        $notifications = Notification::all();
        return response()->json([
            'notifications' => $notifications
        ], Response::HTTP_OK);
    }

    /**
     * Functions to return notifications of user with user_id
     */
    public function show($user_id){
        $userNot = Notification::where('user_id', $user_id)->first();
        return response()->json([
            'notifications' => $userNot->notifications_info
        ], Response::HTTP_OK);
    }

    /**
     * Functiont to store notification from request to user with user_id
     */
    public function store(Request $request, $user_id){
        $userNotifications = Notification::where('user_id', $user_id)->first();
        if(!$userNotifications){
            return response()->json([
                'result' => 'Cannot find notifications of user with user_id' . $user_id
            ], Response::HTTP_NOT_FOUND);
        }

        $notInfo = $request->all();
        $notInfo['not_id'] = Str::random(10);
        $userNotifications->push('notifications_info', $notInfo);

        return response()->json([
            'result' => 'Notification added successfully'
        ], Response::HTTP_OK);
    }

    /**
     * Function to delete a notification with notID from user with user_id
     */
    public function destroy($user_id, $notID){
        $userNotifications = Notification::where('user_id', $user_id)->first();
        if(!$userNotifications){
            return response()->json([
                'result' => 'Cannot find notifications of user with user_id ' . $user_id
            ], Response::HTTP_NOT_FOUND);
        }

        /**
         * Iterate through notifications of user, and delete pull the right one from the array
         */
        foreach($userNotifications->notifications_info as $notification){
            if(strcmp($notification['not_id'], $notID) == 0){
                $userNotifications->pull('notifications_info',[
                    [
                        'product_id' => $notification['product_id'],
                        'message' => $notification['message'],
                        'date' => $notification['date'],
                        'not_id' => $notID
                    ]
                    ]);
                break;
            }
        }

        /**
         * Return success json
         */
        return response()->json([
            'result' => 'Notification deleted successfully'
        ], Response::HTTP_OK); 
    }

    /**
     * Function to create empty notification field in notifications document
     */
    public function create($user_id){
        Notification::create([
            'user_id' => $user_id,
            'notifications_info' => []
            ]);
        
        return response()->json([
            'result' => 'Notification document created successfully'
        ], Response::HTTP_OK);
    }

}
