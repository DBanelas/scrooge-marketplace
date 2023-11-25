<x-master-layout>
<meta name="csrf-token" content="{{ csrf_token() }}" />
<script defer src="{{ URL::asset('js/shop.js') }}"></script>
<div class="row justify-content-center mt-3 mb-3 ms-3 me-3">
  <div class="col-3">
    <div class="card text-center rounded-3 shadow-lg">
        <div class="card-header">
            <h5 class="card-title">Search in products!</h5>
        </div>
      <div class="card-body rounded-3 shadow-lg" style="background-color: #e4e6eb">
        <form id="searchForm">
            <!-- Input fields -->
                {{-- Product name --}}
                <div class="mt-3 mb-3">
                    <label for="prodName">Name:</label>
                    <input type="text" value='{{old('prodName')}}' class="form-control" id="prodName" name="prodName">
                </div>

                {{-- Category --}}
                <div class="mt-3 mb-3">
                    <label for="category">Category:</label>
                    <input type="text" value="{{old('category')}}" class="form-control" id="category" name="category">
                </div>

                {{-- Seller name --}}
                <div class="mt-3 mb-3">
                    <label for="sellerName">Seller Name:</label>
                    <input type="text" value="{{old('sellerName')}}" class="form-control" id="sellerName" name="sellerName">
                </div>

                <div class="mt-3 mb-3">
                    <label for="role">Availability:</label>
                    <select id="availability" class="form-select">
                        <option> Choose </option>
                        <option value="0">All</option>
                        <option value="1">Available</option>
                        <option value="2">Not available</option>
                    </select>
                </div>

                <div class="row justify-content-center">
                    <div class="col-6 mt-3 mb-3">
                        <label for="minPrice">Min. price:</label>
                        <input type="number" value="{{old('minPrice')}}" step="0.01" class="form-control" id="minPrice" name="minPrice">
                    </div>
    
                    <div class="col-6 mt-3 mb-3">
                        <label for="maxPrice">Max. price:</label>
                        <input type="number" value="{{old('maxPrice')}}" step="0.01" class="form-control" id="maxPrice" name="maxPrice">
                    </div>

                </div>

                <div class="mt-3 mb-3">
                    <button onclick="clearFields(this)" type="button" class="btn btn-info me-3" >Clear fields</button>
                    <button onclick="search()" type="button" class="btn btn-primary">Search!</button>
                </div>
        </form>
      </div>
    </div>
  </div>
  <div class="col-8">
    <div class="card rounded-3 shadow-lg">
      <div class="card-body rounded-3 shadow-lg" style="background-color: #e4e6eb">
        <div id="success_message" style="font-size: 1.5rem"></div>
        <table id="productTable" class="table table-hover" style="font-size: 1.3rem;">
        <tr>
            <th>Name</th>
            <th>Price($)</th>
            <th>Seller username </th>
            <th>Category</th>
            <th>Notifications</th>
        </tr>
        @foreach ($products as $index => $product)
            <tr id="prodRowID{{$product->_id}}">
                @if ($product->available)
                    <input type="hidden" id="table-available" value="true">
                @else
                    <input type="hidden" id="table-available" value="false">  
                @endif
                <td id="table-prodName">{{$product->name}}</td>
                <td id="table-prodPrice">{{$product->price}}</td>
                <td id="table-username">{{$sellerUsernames[$index]}}</td>
                <td id="table-category">{{$product->category}}</td>
                <td>
                    <div class="form-check form-switch ms-4">
                        <input onclick="toggleNotificationSwitch(this, '{{$product->_id}}')"
                        class="form-check-input" 
                        type="checkbox" 
                        role="switch" 
                        id="activate-toggle" 
                        {{-- @if($product->available) disabled @endif --}}
                        @if($notificationsOn[$index]) checked @endif>
                    </div>
                </td>
                <td>
                <button 
                onclick="addToCart('{{$product->_id}}')"
                @if(!$product->available) disabled @endif
                class="btn btn-outline me-2"
                style="background-color: #7AA676ff !important; width: 100%;">
                    <span class="material-symbols-outlined">
                        shopping_cart
                    </span>
                </button>
                </td>
            </tr>
        @endforeach
        
    </table>
      </div>
    </div>
  </div>
</div>
</x-master-layout>