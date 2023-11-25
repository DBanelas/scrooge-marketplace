<?php

namespace App\Models;

use Jenssegers\Mongodb\Eloquent\Model;

class Product extends Model
{
    protected $connection = 'mongodb';

    protected $fillable = [
        'name',
        'product_code',
        'price',
        'category',
        'seller_id',
        'available'
    ];
}
