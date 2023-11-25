<x-master-layout>
<script defer src="{{ URL::asset('js/adminOps.js') }}"></script>

<div class="container col-10">
    <div class="row justify-content-center m-4" style="font-size: 1.5rem;">
        <a class="navbar-brand fw-bolder fst-italic cursive text-center" style="font-size: 2rem">
            Admin Dashboard!
        </a>
    </div>

    <div id="success_message" style="font-size: 1.5rem"></div>

    <div class="row justify-content-center rounded-5 shadow-lg p-3">
        <table class="table table-hover ms-5 me-5 mt-2 mb-2" style="font-size: 1.3rem;">
            <tr>
                <th>First name</th>
                <th>Last name</th>
                <th>Username</th>
                <th>Email</th>
                <th>Role</th>
                <th>Activated </th>
            </tr>
        @foreach ($users as $user)
            <tr id={{'rowID'. $user->keyrock_id}}>
                <td>{{$user->name}}</td>
                <td>{{$user->surname}}</td>
                <td>{{$user->username}}</td>
                <td>{{$user->email}}</td>
                <td>{{$user->role}}</td>
                <td> 
                    <div class="form-check form-switch ms-4">
                        <input onclick="toggleSwitch(this, '{{$user->keyrock_id}}')"
                        class="form-check-input" 
                        type="checkbox" 
                        role="switch" 
                        id="activate-toggle" 
                        @if($user->confirmed) checked @endif>
                    </div>
                </td>
                <td><button onclick="showEditUser('{{$user->keyrock_id}}')" class="btn btn-info">Edit</button></td>
                <td><button onclick="showDeleteConfirm('{{$user->keyrock_id}}', '{{$user->username}}')" value="{{$user->keyrock_id}}" class="btn btn-danger">Delete</button></td>
            </tr>
        @endforeach
        
    </table>
    </div>
</div>

<!-- Delete confirm Modal -->
<div class="modal fade" id="confirmDeletion" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="staticBackdropLabel">Warning!</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div id="modalMsg" class="modal-body">

      </div>
      <input type="hidden" id="deleteModalUserID" value="">
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button onclick="deleteUser()" type="button" class="btn btn-primary">Delete</button>
      </div>
    </div>
  </div>
</div>


    <!-- UpdateUserInfo modal -->
<div class="modal fade" id="updateUserInfo" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-2" id="staticBackdropLabel" >Update info!</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      
      <ul id="error_list"></ul>

      <div class="modal-body">
        @csrf
        <input type="hidden" id="updateModalUserID" value="">

        <label for="">First name</label>
        <input type="text" id="update-name" class="firstName form-control">

        <label for="">Last name</label>
        <input type="text" id="update-surname" class="lastName form-control">

        <label for="">Username</label>
        <input type="text" id="update-username" class="Username form-control">

        <label for="">Email</label>
        <input type="text" id="update-email" class="Email form-control">
        <br>
        <label for="role">Role:</label>
        <select id="update-role" name="role" >
            <option value="" selected disabled> New role </option>
            <option value="USER">USER</option>
            <option value="ADMIN">ADMIN</option>
            <option value="PRODUCT_SELLER">PRODUCT SELLER</option>
        </select>


      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button onclick="updateUser()" type="button" class="btn btn-primary">Update</button>
      </div>
    </div>
  </div>
</div> 
</x-master-layout>