<?php

namespace App\Models;
use Jenssegers\Mongodb\Eloquent\Model;

class Cart extends Model
{
    protected $connection = 'mongodb';

    protected $fillable =[
        'user_id',
        'total_price',
        'product_count',
        'products'
    ];
}
