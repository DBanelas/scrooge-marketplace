<?php

namespace Database\Seeders;

// use Illuminate\Database\Console\Seeds\WithoutModelEvents;

use App\Models\Cart;
use App\Models\Product;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {

        User::factory()->count(10)->isSeller()->create();
        Product::factory(40)->create();
        User::factory()->count(5)->isUser()->create();



        $user = new User;
        $user->name = 'Aimilios';
        $user->surname = 'Tzavaras';
        $user->username = 'atzavaras';
        $user->role = 'ADMIN';
        $user->email = 'atzavaras@test.com';
        $user->confirmed = 1;
        $user->password = Hash::make('password');
        $user->save();

        
        
        for($i = 1; $i<17; $i++){
            Cart::create([
                'user_id' => $i
            ]);
        }
        

        // \App\Models\User::factory()->create([
        //     'name' => 'Test User',
        //     'email' => 'test@example.com',
        // ]);
    }
}
