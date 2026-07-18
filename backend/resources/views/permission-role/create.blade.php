@extends('backend.layouts.app')

@section('title')
    {{ __('permission-role.title') }}
@endsection

@section('content')
    <x-back-button-component route="backend.permission-role.list" />

    <div class="card">
        <div class="card-body">
            @include('permission-role.form-'.$type, ['data' => $data])
        </div>
    </div>
@endsection
