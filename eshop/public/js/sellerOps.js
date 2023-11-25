/**
 * onclick function for Delete button
 * 
 * Acts as a confirmation prompt for deletion 
 * 
 * Actual deletion takes place after pressing the delete button in the modal
 * 
 * @param {*} id ID of the user to be deleted
 * @param {*} prodName Name of the product to be deleted
 */
function popDeletionModal(id){
    var name = $('#prodRowID' + id).find("td").eq(0).html();
    $('#deleteModalMsg').html('');
    $('#deleteModalMsg').append(document.createTextNode('You are going to permanantly delete product ' + name + '. Are you sure?'));
    $('#deleteModalProductID').attr('value', id);
    $('#productDeletionModal').modal('toggle');
}

/**
 * 
 * @param {*} btn Toggle switch 
 * @param {*} id  Id of the product to become available/not available
 */
function toggleAvailabilitySwitch(btn, id){
    $(btn).is(':checked')? changeProductStatus(id, 'make-available') : changeProductStatus(id, 'make-unavailable');
}

function changeProductStatus(id, action){
    $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('input[name="_token"]').val()
            }   
    });

    $.ajax({
            type: "post",
            url: "/seller/" + action + "/product/" + id,
            success: function (response) {
                
                if(response.status == 200){
                    showSuccessMessage(true, response.message);
                }else{
                    showSuccessMessage(false, response.message);
                }
  
            }
        });   
}

function popUpdateModal(prodId){
    $.ajax({
        type: "get",
        url: "/seller/products/" + prodId,
        success: function (response) {
            if(response.status == 200){
                $('#update_error_list').html('');
                $('#update_error_list').removeClass('alert alert-danger');
                setUpdateFormFields(response.product);
                $('#productUpdateModal').modal('toggle');
            }else{
                showSuccessMessage(false, response.message);
            }
        }
    });
}

function setUpdateFormFields(product){
    $('#update-product-id').val(product._id);
    $('#old-product-code').val(product.product_code);
    $('#update-product-name').val(product.name);
    $('#update-product-code').val(product.product_code);
    $('#update-product-price').val(product.price);
    $('#update-product-category').val(product.category);
}


function updateProduct(){
    var prodId = $('#update-product-id').val();
    var oldCode = $('#old-product-code').val();
    var newCode = $('#update-product-code').val();


    var formData = {
        'name':             $('#update-product-name').val(),
        'product_code':     $('#update-product-code').val(),
        'price':            $('#update-product-price').val(),
        'category':         $('#update-product-category').val(),
    };

    if (oldCode !== newCode){
        formData['check_code'] = true;
    }
    console.log(formData);
    $.ajaxSetup({
       headers: {
           'X-CSRF-TOKEN': $('input[name="_token"]').val()
       }   
    });

    $.ajax({
        type: "post",
        url: "/seller/update/product/" + prodId,
        data: formData,
        success: function (response) {
            if(response.status == 200){
                updateProductTableRow(response.product);
                showSuccessMessage(true, 'Product info updated successfuly!');
                $('#productUpdateModal').modal('toggle');
            }
            showErrorList('update_error_list', response)
        }
    });
}


/**
 * onclick function for modal Delete button
 * 
 * Sends post request that deletes the specified user
 * 
 * Shows success message if successful and error message otherwise 
 */
function deleteProduct(){
    var prodId = $('#deleteModalProductID').attr('value');
    
    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('input[name="_token"]').val()
        }   
    });

    $.ajax({
        type: "post",
        url: "/seller/delete/product/" + prodId,
        success: function (response) {
            if(response.status == 200){
                //remove confirmation modal
                $('#productDeletionModal').modal('toggle');
                //remove row of deleted user
                $('#prodRowID' + prodId).hide('slow');
                setTimeout(() => {
                    $('#prodRowID' + prodId).remove();    
                }, 1000);
                //alert that user deleted successfuly
                showSuccessMessage(true, response.message);
            }else{
                showSuccessMessage(false, 'Oops, could not delete product. Please try again!');
            }   
        } 
    });
}

/**
 * Function to update the row of the table that corresponds to the 
 * updated user.
 * 
 * All the new data is fetched from the response object
 * 
 * @param {*} response Respose object
 */
function updateProductTableRow(product){
    $('#prodRowID' + product._id).find("td").eq(0).html(product.name);
    $('#prodRowID' + product._id).find("td").eq(1).html(product.product_code);
    $('#prodRowID' + product._id).find("td").eq(2).html(product.price);
    $('#prodRowID' + product._id).find("td").eq(3).html(product.category);
    $('#prodRowID' + product._id).css('background-color', '#ced4da');
    setTimeout(function (){
        $('#prodRowID' + product._id).css('background-color', '');
    }, 1000);
}


function clearCreationModal(){
    $('#product-name').val('');
    $('#product-code').val('');
    $('#product-price').val('');
    $('#product-category').val('');
    $('#create_error_list').html('');
    $('#create_error_list').removeClass('alert alert-danger');
}

function popCreationModal(){
    clearCreationModal();
    $('#productCreationModal').modal('toggle');
}

function addProduct(){
    var formData = {
        'name' :    $('#product-name').val(),
        'product_code' : $('#product-code').val(),
        'price' : $('#product-price').val(),
        'category' : $('#product-category').val(),
    };

    $.ajaxSetup({
        headers: {
            'X-CSRF-TOKEN': $('input[name="_token"]').val()
        }   
    });

    $.ajax({
        type: "post",
        url: "/seller/add-product",
        data: formData,
        success: function (response) {
            if(response.status == 200){
                $('#productCreationModal').modal('toggle');
                showSuccessMessage(true, 'Product added successfully!');
                addTableRow(response.product);
            }else{
                showErrorList('create_error_list', response);
            }  
        }
    });
}


/**
 * Function to show error list inside update modal
 * 
 * @param {*} response Response object
 */
function showErrorList(list, response){
    if(response.status == 400){
        $('#' + list).html('');
        $('#' + list).addClass('alert  alert-danger');
        $.each(response.errors, function (key, err) { 
                $('#' + list).append('<li>' + err + '</li>');
        });            
    }

    if(response.status == 404){
        $('#' + list).html('');
        $('#' + list).addClass('alert  alert-danger');
        $('#' + list).html(response.message);
    }
}


function addTableRow(product){
    tableData = '<td>'+ product.name + '</td>'
              + '<td>'+ product.product_code + '</td>'
              + '<td>'+ product.price + '</td>'
              + '<td>'+ product.category + '</td>'
              + '<td><div class=\"form-check form-switch ms-3\">'
              + '<input onclick=\"toggleAvailabilitySwitch(this,' + '\'' + product._id + '\'' + ')\"'
              + 'class=\"form-check-input\"'
              + 'type=\"checkbox\"'
              + 'role=\"switch\"'
              + 'id=\"activate-toggle\"'
              + '</div>'
              + '</td>'
              + '<td><button onclick="popUpdateModal('+ '\'' + product._id + '\'' +')"  class="btn btn-info me-2" >Edit</button>' + ' '
              +  '<button  onclick="popDeletionModal('+ '\'' + product._id + '\'' +')" class="btn btn-danger">   Delete </button></td>';

    $('#productTable').append('<tr id="prodRowID'+product._id+'">' + tableData + '</tr>');
}

/**
 * Function to show the appropriate success or error message
 * 
 * @param {*} success Boolean value that indicates success or failure
 * @param {*} message Message to be shown
 */
function showSuccessMessage(success, message){
    $('#success_message').html('');
    $('#success_message').css("display", "block");
    var classes = success ? 'alert  alert-success' : 'alert  alert-danger';
    $('#success_message').addClass(classes);
    $('#success_message').html(message);
    setTimeout(function (){
        $('#success_message').fadeOut(1000);
    }, 1000);
}