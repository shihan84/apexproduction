@extends('backend.layouts.app')

@section('title')
    {{ __('settings.title') }}
@endsection

@section('content')
    <x-back-button-component route="backend.setting.index" />

    {{ html()->form('POST', route('backend.setting.update', $data->id))->attribute('data-toggle', 'validator')->class('requires-validation')->attribute('novalidate', 'novalidate')->open() }}
    @csrf
    @method('PUT')
    <div class="card">
        <div class="card-body">
            <div class="row gy-3">
                <div class="col-md-6">
                    {{ html()->label(__('setting.lbl_name') . '<span class="text-danger">*</span>', 'name')->class('form-label') }}
                    {{ html()->text('name', $data->name)->class('form-control')->placeholder(__('placeholder.lbl_name'))->attribute('required', 'required') }}
                    @error('name')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-md-6">
                    {{ html()->label(__('setting.lbl_value'), 'val')->class('form-label') }}
                    {{ html()->text('val', $data->val)->class('form-control')->placeholder(__('placeholder.lbl_value')) }}
                </div>
            </div>
        </div>
    </div>
    <div class="d-grid d-sm-flex justify-content-sm-end gap-3">
        {{ html()->submit(__('messages.save'))->class('btn btn-md btn-primary') }}
    </div>
    {{ html()->form()->close() }}
@endsection
