
<x-master-layout>
   <div class="container h-100  mt-5 mb-5" style="--bs-border-opacity: .5;">
    <div class="row justify-content-center align-items-center">
        <div class="col-6" style="text-align: center;">
            <img src="{{asset('images/NicePng_scrooge-mcduck-png_2250682.png')}}" alt="">
            <br>
            <caption>Scrooge walks by!</caption>
        </div>
        @component('components.registerForm')
        @endcomponent
    </div>
</div>
</x-master-layout>