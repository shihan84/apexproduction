<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class PermissionRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    protected function prepareForValidation(): void
    {
        if ($this->has('title')) {
            $name = strtolower(str_replace(' ', '_', preg_replace('/[^a-zA-Z0-9_.]/', '', $this->title)));
            $this->merge(['name' => $name]);
        }
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, mixed>
     */
    public function rules()
    {
        $method = strtolower($this->method());
        $permission_id = $this->route()->permission;

        $rules = [];
        switch ($method) {
            case 'post':
                $rules = [
                    'title' => 'required|max:20',
                    'name' => 'required|max:20|unique:permissions,name',
                ];
                break;
            case 'patch':
            case 'put':
                $rules = [
                    'title' => 'required|max:20',
                    'name' => 'required|max:20|unique:permissions,name,'.$permission_id,
                ];
                break;
        }

        return $rules;
    }
}
