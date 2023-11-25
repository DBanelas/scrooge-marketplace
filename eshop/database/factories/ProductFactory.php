<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition()
    {
        return [
            'name' => fake()->word(),
            'product_code' => fake()->bothify('????-####'),
            'price' => fake()->randomFloat(2, 0, 100),
            'seller_id' => fake()->numberBetween(1, 11),
            'withdrawal_date' => fake()->dateTimeBetween('+0 days', '+2 years'),
            'category' => fake()->randomElement(['food', 'electronics', 'toys'])
        ];
    }
}
