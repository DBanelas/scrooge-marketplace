/**
 * 
 * @param {*} btn Toggle switch 
 * @param {*} id  Id of the user to be activated
 */
function toggleSwitch(btn, id ){
    $(btn).is(':checked')? changeUserStatus(id, 'activate') : changeUserStatus(id, 'deactivate');
}


/**
 * onclick function for Activate button
 * 
 * Sends post request to make user confirmed
 * 
 * Shows success message if successful and error message otherwise 
 * 
 * @param {*} id ID of the user to be activated
 * @param {*} action 'activate' or 'deactivate' 
 */
function changeUserStatus(id, action){
    $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('input[name="_token"]').val()
            }   
    });

    $.ajax({
            type: "post",
            url: "/admin/" + action + "/user/" + id,
            success: function (response) {
                
                if(response.status == 200){
                    showSuccessMessage(true, response.message);
                }else{
                    showSuccessMessage(false, response.message);
                }
  
            }
        });   
}


/**
 * onclick function for Delete button
 * 
 * Acts as a confirmation prompt for deletion 
 * 
 * Actual deletion takes place after pressing the delete button in the modal
 * 
 * @param {*} id ID of the user to be deleted
 */
function showDeleteConfirm(id){
    var username = $('#rowID' + id).find("td").eq(2).html();
    $('#modalMsg').html('');
    $('#modalMsg').append(document.createTextNode('You are going to permanantly delete user ' + username + '. Are you sure?'));
    $('#deleteModalUserID').attr('value', id);
    $('#confirmDeletion').modal('toggle');
}


/**
 * onclick function for modal Delete button
 * 
 * Sends post request that deletes the specified user
 * 
 * Shows success message if successful and error message otherwise 
 */
function deleteUser(){
    var userId = $('#deleteModalUserID').attr('value');

    $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('input[name="_token"]').val()
            }   
    });

    $.ajax({
        type: "post",
        url: "/admin/delete/user/" + userId,
        success: function (response) {
            if(response.status == 200){
                //remove confirmation modal
                $('#confirmDeletion').modal('toggle');
                //remove row of deleted user
                $('#rowID' + userId).hide('slow');
                setTimeout(function(){
                    $('#rowID' + userId).remove();
                }, 1000);
                //alert that user deleted successfuly
                showSuccessMessage(true, 'User deleted successfully!');
            }else{
                showSuccessMessage(false, 'Oops, could not delete user. Please try again!');
            }   
        } 
    });
}

/**
 * onclick function for Edit button
 * 
 * Brings up the modal with the form for the new info
 * 
 * Error message is shown if user is not found
 * 
 * @param {*} id ID of the user to be edited
 */
function showEditUser(id){
    $.ajax({
            type: "get",
            url: "/admin/users/" + id,
            success: function (response) {
                if(response.status == 200){
                    $('#updateUserInfo').modal('toggle');
                    $('#error_list').html('');
                    $('#error_list').removeClass('alert alert-danger');
                    $('#update-name').val(response.user.name);
                    $('#update-surname').val(response.user.surname);
                    $('#update-username').val(response.user.username);
                    $('#update-email').val(response.user.email);
                    $('#update-role').val(response.user.role);
                    $('#updateModalUserID').val(id);
                }else{
                    showSuccessMessage(false, response.message);
                    $('#updateUserInfo').modal('toggle');
                }
            }
        });
}

/**
 * onclick function for modal update button 
 * 
 * Sends a post request that updates the user
 * 
 * Shows success message if successful
 * 
 * Shows a list of errors inside the modal if user info 
 * cannot be validated
 */
function updateUser(){
    var userId = $('#updateModalUserID').val();

    var formData = {
        'name':     $('#update-name').val(),
        'surname':  $('#update-surname').val(),
        'username': $('#update-username').val(),
        'email':    $('#update-email').val(),
        'role':     $('#update-role').val()
    };

    $.ajaxSetup({
        headers: { 'X-CSRF-TOKEN': $('input[name="_token"]').val() }   
    });

    $.ajax({
        method: "post",
        url: "/admin/update/user/" + userId,
        data: formData,
        success: function (response) {
            if(response.status == 200){
                updateUserTableRow(response);
                showSuccessMessage(true, 'User info updated successfully!');
                $('#updateUserInfo').modal('toggle');
            }
            showErrorListAdmin(response);
        }
    });
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
 * Function to show error list inside update modal
 * 
 * @param {*} response Response object
 */
function showErrorListAdmin(response){
    console.log(response);
    if(response.status == 400){
        $('#error_list').html('');
        $('#error_list').addClass('alert  alert-danger');
        $.each(response.errors, function (key, err) { 
                $('#error_list').append('<li>' + err + '</li>');
        });            
    }

    if(response.status == 404){
        $('#error_list').html('');
        $('#error_list').addClass('alert  alert-danger');
        $('#error_list').html(response.message);
    }
}

/**
 * Function to update the row of the table that corresponds to the 
 * updated user.
 * 
 * All the new data is fetched from the response object
 * 
 * @param {*} response Respose object
 */
function updateUserTableRow(response){
    $('#rowID' + response.user.keyrock_id).find("td").eq(0).html(response.user.name);
    $('#rowID' + response.user.keyrock_id).find("td").eq(1).html(response.user.surname);
    $('#rowID' + response.user.keyrock_id).find("td").eq(2).html(response.user.username);
    $('#rowID' + response.user.keyrock_id).find("td").eq(3).html(response.user.email);
    $('#rowID' + response.user.keyrock_id).find("td").eq(4).html(response.user.role);
    $('#rowID' + response.user.keyrock_id).css('background-color', '#ced4da');
    setTimeout(function (){
        $('#rowID' + response.user.keyrock_id).css('background-color', '');
    }, 1000);
}