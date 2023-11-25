<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'keyrock_id',
        'name',
        'surname',
        'email',
        'username',
        'password',
        'role',
        'confirmed'
    ];

    protected $attributes = [
        'confirmed' => false
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password'
    ];

    public function products(){
        return $this->hasMany(Product::class, 'seller_id');
    }

    public function cart(){
        return $this->hasOne(Cart::class);
    }
}
