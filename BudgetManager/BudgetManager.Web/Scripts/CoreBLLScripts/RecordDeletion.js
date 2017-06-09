/// <reference path="~/Scripts/CoreBLLScripts/UserPermission.js" />
var $elementToDelete;
$.fn.deleteSelectedRecord = (function (options) {
    "use strict";
    var actionParameters = $.extend({
        // These are the defaults.
        actionUrl: "",
        tableId: "",
        backgroundColor: "white",
        onSuccess: function () {
            if ($elementToDelete === undefined) {
                throw new Error("$elementToDelete is not defined for this operation");
            }
            else {
                $elementToDelete.remove();
            }
        }
    }, options);

    $(this).click(function () {
        var $firstParentElement = $(this).parent();
        if ($firstParentElement.length == 0) return;
        var actionUrl = actionParameters.actionUrl;
        if ($firstParentElement.prop('tagName').toLowerCase() == "li") {
            $elementToDelete = $firstParentElement.parent().parent().parent().parent().parent();
            var recordId = $elementToDelete.data("record-id");
            var componentType = $elementToDelete.data("component");
            deleteSelectedRecord(recordId, actionUrl, componentType);
        }
        else {
            $elementToDelete = $firstParentElement.parent().parent();
            var recordId = $elementToDelete.data("record-id");
            var componentType = $elementToDelete.data("component");
            deleteSelectedRecord(recordId, actionUrl, componentType);
        }
    });

    function deleteSelectedRecord(recordID, actionUrl, componentType) {
        var jsonData = "{recordId:'" + recordID + "', componentType:'" + componentType + "'}";
        doAjaxAction(actionUrl, jsonData, actionParameters.onSuccess);
    }
});

function SuccessAction() {
    if ($elementToDelete === undefined) {
        throw new Error("$elementToDelete is not defined for this operation");
    }
    else {
        $elementToDelete.remove();
    }
}



