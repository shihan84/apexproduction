@php
    $route = 'backend.role.store';
    $method = 'post';
    if(isset($data->id)) {
        $route = ['backend.role.update', $data->id];
        $method = 'put';
    }
@endphp

{{ html()->form($method, route($route))->class('requires-validation')->open() }}
    @csrf
    @method($method)

    <div class="form-group">
        <label class="form-label">{{trans('permission-role.role_label_title')}} <span class="text-danger">*</span></label>
        {{ html()->text('title', old('title', $data->title ?? ''))->class('form-control')->id('role-title')->placeholder('Role Title')->required() }}
    </div>
    {{ html()->submit(__('messages.save'))->class('btn btn-primary') }}
    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">{{ __('messages.close') }}</button>
{{ html()->form()->close() }}
