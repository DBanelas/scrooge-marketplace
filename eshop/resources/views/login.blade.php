
<x-master-layout>
   <div class="container mt-5 pt-5" style="--bs-border-opacity: .5; margin-bottom: 10em">
    <div class="row justify-content-center align-items-center" >
        <div class="col-6" style="text-align: center;">
            <img src="{{asset('images/scrooge_login.png')}}" alt="">
            <br>
            <caption>Scrooge says hello!</caption>
        </div>
        @component('components.loginForm')
        @endcomponent

    </div>
</div>
</x-master-layout>