
{{-- Footer Section Start --}}
@php
    $footerStyle = getCustomizationSetting('footer_style');
    $appName = setting('app_name');
    $companyName = 'Varchaswaa International Pvt Ltd';
    $currentYear = date('Y');
@endphp
<footer class="footer pr-hide {{ $footerStyle }}">
  <div class="footer-body">
      <div class="text-center">
          <a href="{{ route('backend.home') }}">{{$appName}}</a>
           <span>(v{{ config('app.version') }})</span>
      </div>
      <div class="text-center mt-2">
          <small>&copy; {{ $currentYear }} {{ $companyName }}. All rights reserved.</small>
      </div>
  </div>
</footer>
