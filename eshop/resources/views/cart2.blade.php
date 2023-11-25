<x-master-layout>
<script defer src="{{ URL::asset('js/cart.js') }}"></script>


<div class="row justify-content-center">
    <div class="col-3 me-5">
        <div class="container-fluid mt-5" style="text-align: center;">
            <img class="rounded mx-auto d-block m-3" src="{{asset('images/scrooge_cart.png')}}"
            style="height:85%; width:85%"
            alt="">
            
        </div>
    </div>
    <div class="col-5 rounded-5 shadow-lg p-3 mt-3 mb-3">
        <div id="success_message" style="font-size: 1.5rem"></div>
        @csrf
        <div class="text-center">
            <a class="navbar-brand fw-bolder fst-italic cursive text-center" style="font-size: 1.5rem">
                    My Cart!
            </a>
        </div>
        <table class="table table-hover mt-2" style="font-size: 1.3rem;">
            @if (empty($products))
    
            @else    
            <tr>
                <th>Name</th>
                <th>Price ($)</th>
                <th>Quantity</th>
                <th>Inserted at</th>
            </tr>
            @endif
            
            @foreach ($products as $product)
            <tr id="rowID{{$product->product_id}}">
                <td>{{$product->product_name}}</td>
                <td>{{$product->product_price}}</td>
                <td id="quantity">{{$product->quantity}}</td>
                <td>{{\Carbon\Carbon::parse($product->product_date)->format('d-m-Y')}}</td>
                <td><button onclick="popDeletionModal('{{$product->product_id}}', '{{$product->product_name}}')" class="btn btn-danger">Remove</button></td>
            </tr>
            @endforeach
        </table>
        <div class="text-center">
            <a class="navbar-brand fw-bolder fst-italic cursive text-center" style="font-size: 1.5rem">
                    You have <span id="itemCount">{{$itemCount}}</span> items for a total of <span id="totalPrice">{{$totalPrice}}</span> $.
            </a>
        </div>
    </div>
</div>

    <!-- Product deletion modal -->
<div class="modal fade" id="productDeletionModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Warning!</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>

      <div id="deleteModalMsg" class="modal-body">
      </div>
    
      <input type="hidden" id="deleteModalProductID" value="">
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button onclick="removeFromCart()" type="button" class="btn btn-primary">Delete</button>
      </div>
    </div>  
  </div>
</div>
</x-master-layout>