<x-master-layout>
<script defer src="{{ URL::asset('js/sellerOps.js') }}"></script>

<div class="container col-10">
    <div class="row justify-content-center m-4" style="font-size: 1.5rem;">
    
        <a class="navbar-brand fw-bolder fst-italic cursive text-center" style="font-size: 2rem">
            My Products Dashboard!
        </a>
    </div>

    <div id="success_message" style="font-size: 1.5rem"></div>
    <div class="row justify-content-center rounded-5 shadow-lg p-3">
        <table id="productTable" class="table table-hover ms-5 me-5 mt-2 mb-2" style="font-size: 1.3rem;">
        <tr>
            <th>Name</th>
            <th>Product code</th>
            <th>Price($)</th>
            <th>Category</th>
            <th>Available</th>
            <th><button onclick="popCreationModal()" class="btn btn-success" style="width:90%">Add product</button></th>
        </tr>
        @foreach ($products as $product)
            <tr id="prodRowID{{$product->_id}}">
                <td>{{$product->name}}</td>
                <td>{{$product->product_code}}</td>
                <td>{{$product->price}}</td>
                <td>{{$product->category}}</td>
                <td> 
                    <div class="form-check form-switch ms-3">
                        <input onclick="toggleAvailabilitySwitch(this, '{{$product->_id}}')"
                        class="form-check-input" 
                        type="checkbox" 
                        role="switch" 
                        id="activate-toggle" 
                        @if($product->available) checked @endif>
                    </div>
                </td>
                <td>
                    <button  onclick="popUpdateModal('{{$product->_id}}')" class="btn btn-info me-2" >Edit</button>
                    <button  onclick="popDeletionModal('{{$product->_id}}')" class="btn btn-danger">
                        Delete
                    </button>
                </td>
            </tr>
        @endforeach
        
    </table>
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
        <button onclick="deleteProduct()" type="button" class="btn btn-primary">Delete</button>
      </div>
    </div>  
  </div>
</div>



    <!-- Product creation modal -->
<div class="modal fade" id="productCreationModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-2" id="staticBackdropLabel" >Add a new product!</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <ul id="create_error_list" me-2 ms-2></ul>

      <div class="modal-body">
        @csrf
        <label for="">Name</label>
        <input type="text" id="product-name" class="form-control">

        <label for="">Code</label>
        <input type="text" id="product-code" class="form-control">

        <label for="">Price</label>
        <input type="number" step="0.01" id="product-price" class="form-control">

        <label for="">Category</label>
        <input type="text" id="product-category" class="form-control">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button onclick="addProduct()" type="button" class="btn btn-primary">Add product</button>  
      </div>
    </div>
  </div>
</div>



<div class="modal fade" id="productUpdateModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-2" id="staticBackdropLabel" >Add a new product!</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <ul id="update_error_list" me-2 ms-2></ul>

      <div class="modal-body">
        @csrf
        <input type="hidden" id="update-product-id">
        <input type="hidden" id="old-product-code">

        <label for="">Name</label>
        <input type="text" id="update-product-name" class="form-control">

        <label for="">Code</label>
        <input type="text" id="update-product-code" class="form-control">

        <label for="">Price</label>
        <input type="number" step="0.01" id="update-product-price" class="form-control">

        <label for="">Category</label>
        <input type="text" id="update-product-category" class="form-control">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button onclick="updateProduct()" type="button" class="btn btn-primary">Update</button>  
      </div>
    </div>
  </div>
</div>
</x-master-layout>