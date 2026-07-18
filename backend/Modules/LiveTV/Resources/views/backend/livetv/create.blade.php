@extends('backend.layouts.app')

@section('title')
    {{ __('live_tv.title') }}
@endsection

@section('content')
    <x-back-button-component route="backend.livetvs.index" />

    {{ html()->form('POST', route('backend.livetvs.store'))->attribute('data-toggle', 'validator')->class('requires-validation')->attribute('novalidate', 'novalidate')->open() }}
    @csrf
    <div class="card">
        <div class="card-body">
            <div class="row gy-3">
                <div class="col-md-6">
                    {{ html()->label(__('live_tv.lbl_name') . '<span class="text-danger">*</span>', 'name')->class('form-label') }}
                    {{ html()->text('name')->class('form-control')->placeholder(__('placeholder.lbl_name'))->attribute('required', 'required') }}
                    @error('name')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
            </div>
        </div>
    </div>
    <div class="d-grid d-sm-flex justify-content-sm-end gap-3">
        {{ html()->submit(__('messages.save'))->class('btn btn-md btn-primary') }}
    </div>
    {{ html()->form()->close() }}
@endsection
