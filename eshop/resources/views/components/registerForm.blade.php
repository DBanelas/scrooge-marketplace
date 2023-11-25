<div class="col-6 col-md-8 col-lg-6 rounded-5 shadow-lg" style="background-color: #f1f3f8 !important;">
            
            <!-- Form -->
            <form class="form-example" action="/register" method="post" id="formid">
                @csrf
                <p class="display-5 text-center mt-2 ">Fill the registration form below!</p>
                @if ($errors->any())
                <div class="alert alert-danger pb-0">
                    <ul>
                        @foreach ($errors->all() as $error)
                            <li style="font-size:1.5em;">{{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
                @endif
                <!-- Input fields -->
                {{-- First name --}}
                <div class="form-group mt-3 mb-3">
                    <label for="firstName">First name:</label>
                    <input type="text" value="{{old('name')}}" class="form-control firstName" id="firstName" placeholder="First name..." name="name">
                </div>

                {{-- Last name --}}
                <div class="form-group mt-3 mb-3">
                    <label for="lastName">Last name:</label>
                    <input type="text"  value="{{old('surname')}}" class="form-control lastName" id="lastName" placeholder="Last name..." name="surname">
                </div>

                {{-- Email --}}
                <div class="form-group mt-3 mb-3">
                    <label for="">Email:</label>
                    <input type="text" value="{{old('email')}}" class="form-control" id="email" placeholder="Email..." name="email">
                </div>

                {{-- Username --}}
                <div class="form-group mt-3 mb-3">
                    <label for="username">Username:</label>
                    <input type="text" value="{{old('username')}}" class="form-control username" id="username" placeholder="Username..." name="username">
                </div>
                <div class="form-group mt-3 mb-3">
                    <label for="password">Password:</label>
                    <input type="password" class="form-control password" id="password" placeholder="Password..." name="password">
                </div>

                <div class="form-group mt-4 mb-4">
                    <label for="role">Role:</label>
                    <select name="role" >
                        <option value="{{old('role')}}" selected disabled> Choose your role </option>
                        <option value="USER">USER</option>
                        <option value="ADMIN">ADMIN</option>
                        <option value="PRODUCT_SELLER">PRODUCT SELLER</option>
                    </select>
                </div>

                <div class="text-center mb-1">
                    <button type="submit" class="btn btn-primary btn-customized">Register</button>
                </div>
                
            </form>
            <!-- Form end -->
        </div>