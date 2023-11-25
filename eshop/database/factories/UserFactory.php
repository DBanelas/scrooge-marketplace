<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\User>
 */
class UserFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'name' => fake()->firstName(),
            'surname' => fake()->lastName(),
            'email' => fake()->unique()->safeEmail(),
            'username' => fake()->userName(),
            'password' => Hash::make('password'), // password
            'confirmed' => false
        ];
    }

    /**
     * Indicate that the model's email address should be unverified.
     *
     * @return static
     */
    public function isSeller()
    {
        return $this->state(fn (array $attributes) => [
            'role' => 'PRODUCT_SELLER',
        ]);
    }

    public function isUser()
    {
        return $this->state(fn (array $attributes) => [
            'role' => 'USER',
        ]);
    }
}
