$(document).ready(function () {
    var urlParams = new URLSearchParams(window.location.search);
    $("#suggestionsdiv").innerHTML = "Hi";
    $.ajax({
        type: "POST",
        data: '{userid: "' + urlParams.get('UserID') + '" }',
        url: "Suggestions.aspx/PopulateData",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (response) {
            $("#suggestionsdiv").html(response.d);
        },
        failure: function (response) {
            alert(response.d);
        }
    });
    
    
});