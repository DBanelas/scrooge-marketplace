<nav class="navbar navbar-expand-xl navbar-dark" style="background-color: #404040;">
  <div class="container-fluid">
    <a class="navbar-brand fw-bolder fst-italic cursive"
     @user
     href="/userHome"
     @else
     href="/"
     @enduser
     style="font-family: 'Kavoon' , sans-serif; font-size:2.5em;">
     Scrooge Marketplace
    </a>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
            @isLoggedIn
            <div class="dropdown">
                <button class="dropbtn">Availabe actions</button>
                <div class="dropdown-content">
                    @admin
                    <a href="/admin/dashboard">Dashboard</a>
                    @endadmin
                   
                    @seller
                    <a href="/seller/products">My products</a>
                    @endseller
                    
                    @user
                    <a href="/shop">Shop</a>
                    @enduser
                </div>
            </div>
            @endisLoggedIn
        </li>
      </ul>
    </div>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        @isLoggedIn
            <div class="dropdown ms-auto me-5">
                <button class="btn btn-secondary dropdown-toggle" type="button" 
                data-bs-toggle="dropdown" aria-expanded="false" style="font-size:1.5em;">
                    {{Session::get('username') ." "."(". Session::get('role') .")"}} 
                </button>
                <ul class="dropdown-menu" style="background-color:#f1f1f1">
                    <li><a class="dropdown-item" href="/logout" style="font-size:1.5em;">Logout</a></li>
                    @user
                    <li><a class="dropdown-item" href="/myCart"style="font-size:1.5em;">My cart</a></li>
                    @enduser
                 </ul>
            </div>
        @else
            <ul class="navbar-nav ms-auto me-5 mb-2 mb-lg-0">
                <li class="nav-item">
                <a class="nav-link" aria-current="page" href="/login" style="font-size:1.5em;">Login</a>
                </li>
                <li class="nav-item">
                <a class="nav-link" href="/register" style="font-size:1.5em;">Register</a>
                </li>
                </ul>
        @endisLoggedIn
    </div>
  </div>
</nav>