<?php

namespace App\Models;
use Jenssegers\Mongodb\Eloquent\Model;

class Notification extends Model
{
    protected $connection = 'mongodb';

    protected $fillable =[
        'user_id',
        'notifications_info'
    ];
}
