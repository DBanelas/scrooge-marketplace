
/**
 * jQuery directive to fetch notifications every 5 seconds
 */
$(document).ready(function () {
    setInterval(showNotifications, 5000);
});

/**
 * Function to send request to fetch notifications
 * and print them to notification card
 */
function showNotifications(){
    $.ajaxSetup({
        headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }   
    });

    $.ajax({
        type: "get",
        url: "/notifications/fetch",
        success: function (response) {
            if(response.status == 200){
                $('#notification-card').empty();
                notificationArr = response.notifications;
                notDates = response.notDates;
                notificationArr.forEach((notification , i) => printDiv(notification, notDates[i]));
            }
        }
    });

}

/**
 * Function to append a div to notification card
 * @param {*} notification Notification obj
 * @param {*} notDate Notification date
 */
function printDiv(notification, notDate){
    divData = '<div id=\"' + notification.not_id + '\"'
            + 'class=\"border rounded ms-2 me-2 alert\"'
            + 'style=\"background-color: #c5e5f3\" role=\"alert\">'
            + '<span style=\"font-size: 1.2rem\">'
            + '<button '
            + 'onclick=\"deleteNotification(\'' + notification.not_id + '\')\" '
            + 'class=\"btn btn-outline me-2\" '
            + 'style=\"background-color: rgb(246, 81, 81) !important; width: 9%;\"> '
            + '<span class=\"material-symbols-outlined\">close</span> '
            + '</button>'
            + notDate + ': ' + notification.message
            + '</span>'
            + '</div>'
    $('#notification-card').append(divData);
}


/**
 * Function to send request to delete a notification
 * @param {*} notificationID ID of the notification
 */
function deleteNotification(notificationID){
    $.ajaxSetup({
        headers: { 'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content') }   
    });

    $.ajax({
        type: "post",
        url: "/notifications/delete/" + notificationID,
        success: function (response) {
            console.log(response);
            if(response.status == 200){
                $('#'+ notificationID).hide('slow');
                setTimeout(() => {
                    $('#' + notificationID).remove();    
                }, 1000);
            }
        }
    });
}