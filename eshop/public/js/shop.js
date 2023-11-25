function clearFields(btn){
    $(btn).closest('form').find("input[type=text], textarea").val("");
    $(btn).closest('form').find("input[type=number], textarea").val("");
    $(btn).closest('form').find("input[type=date], textarea").val("");
}

function toggleNotificationSwitch(btn, id){
    $(btn).is(':checked')? changeNotificationStatus(id, 'add') : changeNotificationStatus(id, 'remove');
}

function changeNotificationStatus(id, action){
    $.ajaxSetup({
            headers: {
                'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
            }   
    });

    $.ajax({
            type: "post",
            url: "/" + action + "Subscription/" + "product/" + id,
            success: function (response) {
                
                if(response.status == 200){
                    showSuccessMessage(true, response.message);
                }else{
                    showSuccessMessage(false, response.message);
                }
  
            }
        });
}

function addToCart(prodId){

    $.ajaxSetup({
        headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }   
    });

    $.ajax({
        type: "post",
        url: "/addToCart/product/" + prodId,
        success: function (response) {
            console.log(response);
            if(response.status == 200){
                showSuccessMessage(true, 'Product added to cart successfuly!');
            }
        }
    });
}

/**
 * Function to perform filtering on products when search button is pressed
 */
function search(){
    /**
     * Get every filter from search form
     */
    const prodName = $('#prodName').val();
    const category = $('#category').val();
    const sellerName = $('#sellerName').val();
    const minPrice = $('#minPrice').val();
    const maxPrice = $('#maxPrice').val();
    const availability = $('#availability').val();

    /**
     * Hide all table rows
     */
    var rows = $('table tr:not(:first-child)');
    rows.hide();


    /**
     * If product name is given, find the items which match the product name
     */
    if(prodName){
        rows = rows.filter(function() {
            var tableProdName = $(this).find("td[id='table-prodName']").html();
            return tableProdName.indexOf(prodName) >= 0;
        });
    }

    /**
     * If product category is given, find the items which match the product category
     */
    if(category){
        rows = rows.filter(function() {
            var tableCategory = $(this).find("td[id='table-category']").html();
            return category === tableCategory;
        });
    }

    /**
     * If seller username is given, find the items which match the seller username
     */
    if(sellerName){
        rows = rows.filter(function() {
            var tableProdUsername = $(this).find("td[id='table-username']").html();
            return tableProdUsername.indexOf(sellerName) >= 0;
        });
    }

    /**
     * If specific availability is given, find the items which match the availability
     */
    if(availability !== 'Choose') {
        var choice = parseInt(availability);
        console.log(choice);
        if(availability != 0){
            if(availability == 1){
                rows = rows.filter(function() {
                var available = $(this).find("input[id='table-available']").val();
                return available === 'true';
                });
            } else {
                rows = rows.filter(function() {
                var available = $(this).find("input[id='table-available']").val();
                return available === 'false';
                });
            }
        }
    }

    /**
     * If min and/or max price is given, find the items withing this range 
     */
    if(minPrice){
        rows = rows.filter(function() {
            var tablePrice = parseFloat($(this).find("td[id='table-prodPrice']").html());
            return tablePrice >= minPrice;
        });
    }

    if(maxPrice){
        rows = rows.filter(function() {
            var tablePrice = parseFloat($(this).find("td[id='table-prodPrice']").html());
            return tablePrice <= maxPrice;
        });
    }

    /**
     * Show the resulting item set
     */
    rows.show();
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