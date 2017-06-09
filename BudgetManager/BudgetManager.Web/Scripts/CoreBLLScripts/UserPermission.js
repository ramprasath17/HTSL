/// <reference path="~/Scripts/CoreBLLScripts/RecordDeletion.js" />
function updateScreenData(paramValue, currentObject, actionUrl) {
    var screenId = $(currentObject).attr("data-screen-id");
    var sessionUserId = $('#userList :selected').val();
    var actionType = $(currentObject).attr("data-action-type");
    var screenData = "{screenId:" + screenId + ", screenParameter:'" + paramValue + "', sessionUserId : '" + sessionUserId + "', type:'" + actionType + "'}";
    doAjaxAction(actionUrl, screenData, function () { });
}

function doAjaxAction(actionUrl, jsonUpdateData, onSuccessCallBackFunction) {
    var ajaxResponseResult = false;
    $.ajax({
        url: actionUrl,
        type: "POST",
        data: jsonUpdateData,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: onSuccessCallBackFunction,      
        error: function (xhr) {
            console.error(xhr.responseText);
            return false;
        }
    });
}
