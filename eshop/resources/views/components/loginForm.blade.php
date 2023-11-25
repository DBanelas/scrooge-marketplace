
<div class="col-3  rounded-5 shadow-lg" style="background-color: #f1f3f8 !important;">
            <!-- Form -->
            <form class="form-example" action="/login" method="post">
                @csrf
                <p class="display-5 text-center m-2">Enter your credentials!</p>
                @if(session('redirected'))
                    <div class="alert alert-info" role="alert">
                        <span>Notice that your account needs to be confirmed
                            by an administrator before you log in.
                        </span>
                    </div>
                @endif

                @error('email')
                    <div class="alert alert-danger" role="alert">
                        <span>{{$message}}</span>
                    </div>
                @enderror
                
                @error('password')
                    <div class="alert alert-danger" role="alert">
                        <span>{{$message}}</span>
                    </div>
                @enderror
                
                @error('loginError')
                <div class="alert alert-danger" role="alert">
                        <span>{{$message}}</span>
                    </div>
                @enderror

                <div class="form-group mt-3 mb-3">
                    <label for="">Email:</label>
                    <input type="text" class="form-control email" id="email" placeholder="Email..." name="email">
                </div>
                <div class="form-group mt-3 mb-3">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control password" id="password" placeholder="Password..." name="password">
                </div>

                <div class="text-center mb-1">
                    <button type="submit" class="btn btn-primary btn-customized">Login</button>
                </div>
                
            </form>
            <!-- Form end -->
        </div>