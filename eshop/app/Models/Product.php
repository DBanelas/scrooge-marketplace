<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Product extends Model {
    use HasFactory;

    protected $fillable = [
        'name',
        'product_code',
        'price',
        'category',
        'seller_id'
    ];

    public function seller(){
        return $this->belongsTo(User::class);
    }

    /**
     * Mutator and accessor for withdrawal_date attr
     */
    protected function withdrawalDate() : Attribute {
        
        return Attribute::make(
            get: fn ($value) => Carbon::parse($value)->format('d-m-Y'),
            set: fn ($value) => Carbon::parse($value)->format('Y-m-d')
        );
    }

}
