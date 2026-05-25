<?php

namespace Modules\Shorts\Models;

use App\Models\BaseModel;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class ShortCategory extends BaseModel
{
    use HasFactory, SoftDeletes;

    protected $table = 'shorts_categories';

    protected $fillable = [
        'name',
        'slug',
        'description',
        'icon',
        'status',
        'created_by',
        'updated_by',
        'deleted_by',
    ];

    protected $casts = [
        'status' => 'boolean',
    ];

    // Relationships
    public function shorts()
    {
        return $this->hasMany(Short::class, 'category_id');
    }

    // Scopes
    public function scopeActive($query)
    {
        return $query->where('status', true);
    }
}
