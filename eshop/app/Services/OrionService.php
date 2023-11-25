<?php

namespace App\Services;

use Illuminate\Http\Response;
use Illuminate\Support\Facades\Http;

/**
 * Service class to bundle functions related to orion
 */
class OrionService {

    /**
     * Function to create an entity in orion
     */
    public function createEntity($oauthToken, $prodInfo){
        $info = [];
        /**
         * Create json of entity to be created 
         */
        $data = [
            'id' => $prodInfo->_id,
            'type' => 'Product',
            'available' => [
                'value' => false,
                'type' => 'Boolean'
            ],
            'name' => [
                'value' => $prodInfo->name,
                'type' => 'String'
            ],
            'user_subs' =>[
                'value' => [],
                'type' => 'Array'
            ]
            ];

        /**
         * Make request to orion (through proxy) to create an entity
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->withBody(json_encode($data), 'application/json')
          ->post('http://orion-pep-proxy:4002/v2/entities');

        /**
         * If error occured, return error else return success
         */
        if($response->status() != Response::HTTP_CREATED) $info['error'] = true;
        else $info['success'] = true;
        return $info;
    }

    /**
     * Function to delete entity from orion
     */
    public function deleteEntity($oauthToken, $prodID){
        $info = [];

        /**
         * Make request to orion (through proxy) in order to delete entity
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->delete('http://orion-pep-proxy:4002/v2/entities/' . $prodID);

        /**
         * If error return error, else return success
         */
        if($response->status() != Response::HTTP_NO_CONTENT) $info['error'] = true;
        else $info['success'] = true;
        return $info;
    }

    /**
     * Function to fetch subscribers of product with prodID
     */
    public function getSubsOfProduct($oauthToken, $prodID){
        $info = [];

        /**
         * Make request to orion (through proxy) in order to get subs of product
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->get('http://orion-pep-proxy:4002/v2/entities/' . $prodID . '/attrs/user_subs/value');

        /**
         * If error return error, else return success
         */
        if($response->status() != Response::HTTP_OK) $info['error'] = true;
        else $info['subs'] = json_decode($response->body());
        return $info;
    }

    /**
     * Function to add a user_id to the subs array of product with prodID
     */
    public function addSubToProductEntity($oauthToken, $prodID, $userID){
        /**
         * Construct sub json 
         */
        $data = [
            'user_subs' => [
                'value' => [
                    '$push' => $userID
                ]
            ]
        ];

        /**
         * Make request to orion (through proxy) in order push new sub to sub array
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->patch('http://orion-pep-proxy:4002/v2/entities/' . $prodID . '/attrs', $data);

        /**
         * If error return error, else return success
         */
        if($response->status() != Response::HTTP_NO_CONTENT) $info['error'] = true;
        else $info['success'] = true;
        return $info;
    }


    /**
     * Function to remove a user_id from the subs array of product with prodID
     */
    public function removeSubFromProductEntity($oauthToken, $prodID, $userID){

        /**
         * Create sub json
         */
        $data = [
            'user_subs' => [
                'value' => [
                    '$pull' => $userID
                ]
            ]
        ];

        /**
         * Make request to orion (through proxy) in order pull sub from sub array
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->patch('http://orion-pep-proxy:4002/v2/entities/' . $prodID . '/attrs', $data);

        /**
         * If error return error, else return success
         */
        if($response->status() != Response::HTTP_NO_CONTENT) $info['error'] = true;
        else $info['success'] = true;
        return $info;
    }


    /**
     * Function to update entity in orion
     */
    public function updateEntity($oauthToken, $prodID, $newData){
        $info = [];
        $data = [];

        /**
         * Check if 'available' field is updated and construct data array
         */
        if(isset($newData['available'])){
            $data['available'] = [
                'value' => $newData['available'],
                'type' => 'Boolean'
            ];
        }

        /**
         * Check if product name is updated and construct data array 
         */
        if(isset($newData['name'])){
            $data['name'] = [
                'value' => $newData['name'],
                'type' => 'String'
            ];
        }

        /**
         * Make request to orion (through proxy) in order pull sub from sub arrayto update the entity in orion
         */
        $response = Http::withHeaders([
            'X-Auth-Token' => $oauthToken
        ])->patch('http://orion-pep-proxy:4002/v2/entities/' . $prodID . '/attrs', $data);

        /**
         * If error return error, else return success
         */
        if($response->status() != Response::HTTP_NO_CONTENT) $info['error'] = true;
        else $info['success'] = true;
        return $info;
    }

}