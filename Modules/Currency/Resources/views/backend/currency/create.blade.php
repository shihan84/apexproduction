@extends('backend.layouts.app')

@section('content')
<div class="card">
    <div class="card-body">
        {{ html()->form('POST', route('backend.currencies.store'))->attribute('enctype', 'multipart/form-data')->attribute('data-toggle', 'validator')->open() }}
            @csrf
            <div class="row">
                <div class="col-sm-6 mb-3">
                    {{ html()->label(__('Currency Name') . ' <span class="text-danger">*</span>', 'currency_name')->class('form-control-label') }}
                    {{ html()->text('currency_name')->attribute('value', old('currency_name'))->placeholder(__('Enter currency name'))->class('form-control') }}
                    @error('currency_name')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-sm-6 mb-3">
                    {{ html()->label(__('Currency Symbol') . ' <span class="text-danger">*</span>', 'currency_symbol')->class('form-control-label') }}
                    {{ html()->text('currency_symbol')->attribute('value', old('currency_symbol'))->placeholder(__('$'))->class('form-control') }}
                    @error('currency_symbol')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-sm-6 mb-3">
                    {{ html()->label(__('Currency Code') . ' <span class="text-danger">*</span>', 'currency_code')->class('form-control-label') }}
                    {{ html()->text('currency_code')->attribute('value', old('currency_code'))->placeholder(__('USD'))->class('form-control') }}
                    @error('currency_code')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-sm-6 mb-3">
                    {{ html()->label(__('Currency Position') . ' <span class="text-danger">*</span>', 'currency_position')->class('form-control-label') }}
                    {{ html()->select('currency_position', ['left' => 'Left', 'right' => 'Right', 'left_with_space' => 'Left with Space', 'right_with_space' => 'Right with Space'])->value(old('currency_position', 'left'))->class('form-control') }}
                    @error('currency_position')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-sm-6 mb-3">
                    {{ html()->label(__('No of Decimal') . ' <span class="text-danger">*</span>', 'no_of_decimal')->class('form-control-label') }}
                    {{ html()->input('number', 'no_of_decimal', old('no_of_decimal', 2))->placeholder(__('2'))->class('form-control') }}
                    @error('no_of_decimal')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-sm-6 mb-3">
                    {{ html()->label(__('Thousand Separator'), 'thousand_separator')->class('form-control-label') }}
                    {{ html()->text('thousand_separator')->attribute('value', old('thousand_separator', ','))->placeholder(',')->class('form-control') }}
                    @error('thousand_separator')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-sm-6 mb-3">
                    {{ html()->label(__('Decimal Separator'), 'decimal_separator')->class('form-control-label') }}
                    {{ html()->text('decimal_separator')->attribute('value', old('decimal_separator', '.'))->placeholder('.')->class('form-control') }}
                    @error('decimal_separator')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
                <div class="col-sm-6 mb-3">
                    <div class="form-check form-switch">
                        {{ html()->hidden('is_primary', 0) }}
                        {{ html()->checkbox('is_primary', old('is_primary', false) == '1', '1')->class('form-check-input')->id('is_primary') }}
                        {{ html()->label(__('Primary Currency'), 'is_primary')->class('form-check-label') }}
                    </div>
                    @error('is_primary')
                        <span class="text-danger">{{ $message }}</span>
                    @enderror
                </div>
            </div>
            <a href="{{ route('backend.currencies.index') }}" class="btn btn-secondary">Close</a>
            {{ html()->submit(trans('messages.save'))->class('btn btn-md btn-primary float-right') }}
        {{ html()->form()->close() }}
    </div>
</div>
@endsection
