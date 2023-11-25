<x-master-layout>
<meta name="csrf-token" content="{{ csrf_token() }}" />
<script defer src="{{ URL::asset('js/notifications.js') }}"></script>

    <div class="row">
        <div class="col-7 ms-3">
            <div class="container-fluid mt-5" style="text-align: center;">
                <img class="rounded mx-auto d-block m-3" src="{{asset('images/scrooge_index.png')}}" alt="">
                <caption class="text-center">Scrooge diving in his money!</caption>
            </div>
            <br>
            <p class="h3 text-center">
                 Scrooge is a digital marketplace, developed for the course COMP513 "Cloud and Fog Services".
            </p>
        </div>
        <div class="col-4 mt-4">
            <div class="card text-center rounded-3 shadow-lg">
                <div class="card-header">
                    <h4 class="card-title mt-2">My notification feed!</h4>
                </div>
            </div>

            <div id="notification-card" class="card-body rounded-3 shadow-lg" style="height: 665px; overflow-y: auto; background-color: #e4e6eb">                    
                    @foreach ($notifications as $notification)
                        <div id="{{$notification->not_id}}" class="border rounded ms-2 me-2 alert" style="background-color: #c5e5f3" role="alert">
                            <span style="font-size: 1.2rem">
                                <button 
                                onclick="deleteNotification('{{$notification->not_id}}')"
                                class="btn btn-outline me-2"
                                style="background-color: rgb(246, 81, 81) !important; width: 9%;">
                                <span class="material-symbols-outlined">
                                    close
                                </span>
                                </button>
                                {{\Carbon\Carbon::parse($notification->date)->format('d-m-Y')}}: {{$notification->message}}
                            </span>
                        </div>
                    @endforeach                
            </div>  
        </div>
</x-master-layout>