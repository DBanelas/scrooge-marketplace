<?php
namespace App\Http\Controllers;
use App\Models\Cart;
use App\Models\User;
use App\Models\Product;
use App\Services\CartService;
use App\Services\NotificationService;
use App\Services\ProductService;
use Illuminate\Http\Request;
use App\Services\UserService;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;

/**
 * This controller is used only by admins since only 
 * they are able to see and edit users.
 * 
 * Will change if app functionality expands
 */
class UserController extends Controller
{

    /**
     * Necessary services injected to UserController product
     */
    protected $userService;
    protected $cartService;
    protected $productService;
    protected $notificationService;


    public function __construct(
        UserService $userService,
        CartService $cartService,
        ProductService $productService,
        NotificationService $notificationService
        ) {   
        $this->userService = $userService;
        $this->cartService = $cartService;
        $this->productService = $productService;
        $this->notificationService = $notificationService;
    }   

    /**
     * Private helper function to delete products of user 
     * with user_id == id
     */
    private function deleteProductsOfUser($id){
        $productInfo = $this->productService->fetchProductsOfUser(Session::get('oauth-token'), $id);
        if (isset($productInfo['error'])){
            abort(500);
        }
        $products = $productInfo['products'];
        foreach($products as $product){
            $this->productService->deleteProduct(Session::get('oauth-token'), $product->_id);
        }
    }

    /**
     * Show all users 
     */
    public function showDashboard(){

        $info = $this->userService->listAllUsers();
        /**
         * If any errors occured during the auth, show them in login form
         */
        if (isset($info['missing_x_token'])){
            return back()->withErrors(['loginError' => $info['missing_x_token']]); 
        }
        if (isset($info['fail_user_retrival'])){
            return back()->withErrors(['loginError' => $info['fail_user_retrival']]); 
        }
        return view('dashboard', ['users' => $info['users']]);
    }

    /**
     * Update user info
     * 
     * Validates the the new fields from request
     * Returns error if validation fails
     * Updates user with new info if validation is succsessful
     */
    public function update(Request $request, $id){
        $initialRole = $this->userService->getUserByID($id)['user']->role;

        /**
         * Validation rules for new user info
         */
        $validation_reqs = [
            'name' => ['bail', 'required', 'alpha', 'max:255'],
            'surname' => ['bail', 'required', 'alpha', 'max:255'],
            'email' => ['required', 'email'],
            'username' =>['required'],
            'role' => 'required'
        ];
        
        /**
         * Validate new user info
         */
        $validator = Validator::make($request->all(), $validation_reqs);

        /**
         * If validation fails, return with errors
         */
        if($validator->fails()){
            return response()->json([
                'status' => 400,
                'errors' => $validator->messages()
            ]);
        }

        /**
         * Try and update user using userService
         */
        $updateInfo = $this->userService->updateUser($id, $request->all());

        /**
         * If email already exists, return with error
         */
        if (isset($updateInfo['used_email'])){
            return response()->json([
                'status' => 404,
                'message' => $updateInfo['used_email']
            ]);
        }

        /**
         * If x-token could not be retrived, return with error
         */
        if (isset($updateInfo['missing_x_token'])){
            return response()->json([
                'status' => 404,
                'message' => $updateInfo['missing_x_token']
            ]);
        }

        /**
         * At this point user information has been updated in keyrock
         */
        $updatedUser = $this->userService->getUserByID($id)['user'];
        $resultingRole = $updatedUser->role;

        /**
         * If person used to be USER but now isn't, delete their cart
         */
        if(strcmp($initialRole, 'USER') == 0){
            if(strcmp($resultingRole, 'USER') != 0){
                $this->cartService->deleteCart(Session::get('oauth-token'), $id);
            }
        }

        /**
         * If person wasn't a USER but is now, create a cart for them
         */
        if(strcmp($initialRole, 'USER') != 0){
            if(strcmp($resultingRole, 'USER') == 0){
                $this->cartService->createCart(Session::get('oauth-token'), $id);
                $this->notificationService->createNotificationDocument($id);
            }
        }

        /**
         * If person used to be a PRODUCT_SELLER but now isn't, delete their products 
         */
        if(strcmp($initialRole, 'PRODUCT_SELLER') == 0){
            if(strcmp($resultingRole, 'PRODUCT_SELLER') != 0){
                $this->deleteProductsOfUser($id);
            }
        }

        /**
         * Return success response with new user info
         */
        return response()->json([
            'status' => 200,
            'user' => $updatedUser
        ]);
    }


    /**
     * Return json data for user with id 
     * If user does not exist return 404
     * @param string $id: ID of the wanted user
     */
    public function show($id){
        /**
         * Find user from id using userService
         */
        $userInfo = $this->userService->getUserByID($id);

        /**
         * If user exists, return success response with user info
         */
        if(isset($userInfo['user'])){
            return response()->json([
                'status' => 200,
                'user' => $userInfo['user']
            ]);
        }

        /**
         * If user does not exists, return 404 response
         */
        return response()->json([
            'status' => 404,
            'message' => 'User not found.'
        ]);
    }


    /**
     * Activate user with id
     * @param string $id: ID of the user to be activated
     */
    public function activate($id){
        $success = $this->userService->activateUser($id, 1);

        if ($success){
            $status = 200;
            $message = 'User status changed succesfully!'; 
        }else{
            $status = 404;
            $message = 'An error occured!'; 
        }

        return response()->json(['status' => $status,
                                 'message' => $message                        
        ]);
    }

    /**
     * Deactivate user with id
     * @param string $id: ID of the user to be deactivated
     */
    public function deactivate($id){
        $success = $this->userService->activateUser($id, 0);

        if ($success){
            $status = 200;
            $message = 'User status changed succesfully!'; 
        }else{
            $status = 404;
            $message = 'An error occured!'; 
        }

        return response()->json(['status' => $status,
                                 'message' => $message                        
        ]);
    }


    /**
     * Delete user
     * Along with the user the following items must be deleted
     * 
     * All the products that this user sells
     * The cart of the user
     * All the products that this user sells from the carts of other users
     * 
     * @param string $id: ID of the user to be deleted
     */
    public function destroy($id){

        /**
         * Fetch user using userService
         */
        $userInfo = $this->userService->getUserByID($id);

        /**
         * If error occured abort
         */
        if(isset($userInfo['error'])){
            abort(500);
        }

        /**
         * If deleted user was USER, delete their cart
         */
        if(strcmp($userInfo['user']->role, 'USER') == 0){
            $this->cartService->deleteCart(Session::get('oauth-token'), $id);
        }

        /**
         * If deleted user was PRODUCT_SELLER, delete their products
         */
        if(strcmp($userInfo['user']->role, 'PRODUCT_SELLER') == 0){
            $this->deleteProductsOfUser($id);
        }
        
        /**
         * delete user using userService
         */
        $success = $this->userService->deleteUser($id);
        $status = $success ? 200 : 400;

        /**
         * return error or success json
         */
        return response()->json(['status' => $status]);       
    }
}
