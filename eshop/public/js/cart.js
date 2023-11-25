
/**
 * Function to make request to delete item from cart
 * using ajax
 */
function removeFromCart(){

    var prodId = $('#deleteModalProductID').attr('value');

    $.ajaxSetup({
        headers: { 'X-CSRF-TOKEN': $('input[name="_token"]').val() }   
    });

    $.ajax({
        type: "post",
        url: "/removeFromCart/product/" + prodId,
        success: function (response) {
            if(response.status == 200){
                //remove row of deleted user
                removeOrReduceQuantity(prodId);
                //alert that user deleted successfuly
                showSuccessMessage(true, 'Product removed from cart successfully!');
                $('#itemCount').html(response.item_count);
                $('#totalPrice').html(response.total_price);
                $('#productDeletionModal').modal('toggle');
            }
        }
    });
}

/**
 * Function to reduce quantity or remove item if deleted
 */
function removeOrReduceQuantity(prodId){
    quantity = parseInt($('#rowID' + prodId).find("td[id='quantity']").html());
    if (quantity == 1){
        $('#rowID' + prodId).hide('slow');
        setTimeout(function(){
            $('#rowID' + prodId).remove();
        }, 1000);
    } else {
        $('#rowID' + prodId).find("td[id='quantity']").html(quantity - 1);
    }
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
function popDeletionModal(id, prodName){

    $('#deleteModalMsg').html('');
    $('#deleteModalMsg').append(document.createTextNode('You are going remove product ' + prodName + ' from your cart. Are you sure?'));
    $('#deleteModalProductID').attr('value', id);
    $('#productDeletionModal').modal('toggle');
}