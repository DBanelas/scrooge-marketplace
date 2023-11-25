<?php

namespace App\Http\Controllers;

use App\Services\OrionService;
use Illuminate\Http\Request;
use App\Services\SubscriptionService;
use Illuminate\Support\Facades\Session;

/**
 * Controller class to handle subscription actions
 */
class SubscriptionController extends Controller
{
    protected $orionService;

    public function __construct(OrionService $orionService){
        $this->orionService = $orionService;
    }

    /**
     * Controller method to store a subscription in orion
     */
    public function store($id){
        $oauthToken = Session::get('oauth-token');
        $userID = Session::get('id'); 

        /**
         * Using orionService to add logged in user's id to product entity
         */
        $info = $this->orionService->addSubToProductEntity($oauthToken, $id, $userID);

        /**
         * If an error occured, return error json
         */
        if(isset($prodInfo['error'])){
            return response()->json([
            'status' => 404,
            'message' => 'Unknown error has occured, please try again.'
        ]);
        }

        /**
         * Return success json
         */
        return response()->json([
            'status' => 200,
            'message' => 'Notifications turned on successfully!'
        ]); 
    }

    /**
     * Controller method to remove a subscription from a product
     */
    public function destroy($id){
        $oauthToken = Session::get('oauth-token');
        $userID = Session::get('id'); 

        /**
         * Using orionService to remove logged in user's id from product entity
         */
        $info = $this->orionService->removeSubFromProductEntity($oauthToken, $id, $userID);

        /**
         * If error occured return error json
         */
        if(isset($prodInfo['error'])){
            return response()->json([
            'status' => 404,
            'message' => 'Unknown error has occured, please try again.'
        ]);
        }

        /**
         * Return success json
         */
        return response()->json([
            'status' => 200,
            'message' => 'Notifications turned off successfully!'
        ]); 
    }
}
