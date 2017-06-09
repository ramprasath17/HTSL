var $elementToUpdate;
$.fn.updateSelectedRecord = (function (options) {
    "use strict";
    var actionParameters = $.extend({
        // These are the defaults.
        componentType: undefined,
        actionUrl: "",
        tableId: "",
        title: "Edit",
        currencyType: "inr",
        lookupData: undefined,
        onSuccess: function (xhr, status) {
            //alert(status + "\n" + xhr);
        }
    }, options);
    var currencyIcon = ' <i class="icon-' + actionParameters.currencyType + '"></i> ';
    $("#popup-title").html(actionParameters.title);
    var conditionalValues = new Object();
    $(this).click(function () {
        var $firstParentElement = $(this).parent();
        if ($firstParentElement.length == 0) return;
        if ($firstParentElement.prop('tagName').toLowerCase() == "li") {
            $elementToUpdate = $firstParentElement.parent().parent().parent().parent().parent();
        }
        else {
            $elementToUpdate = $firstParentElement.parent().parent();
        }
        var editData = new Array();
        var loopCount = 0;
        var editObj = new Object();
        getConditionalValues($elementToUpdate);

        $elementToUpdate.find("td[data-editable=true]").each(function () {
            var dataColumn = $(this).data("column");
            var dataControlType = $(this).data("control-type");
            if (dataColumn === "" || dataColumn === undefined) {
                dataColumn = loopCount;
                throw new Error("data-column attribute cannot be null or empty")
            }
            if (dataControlType === "" || dataControlType === undefined) {
                dataControlType = "text";
            }
            var tableEditField = new Object();
            var fieldDataType = new Object();
            var lookUp = new Object();
            lookUp[$(this).data("lookup")] = $(this).text().trim();
            fieldDataType[$(this).data("type")] = lookUp;
            tableEditField[dataControlType] = fieldDataType;
            editObj[dataColumn] = tableEditField;
            loopCount++;
        });

        editData.push(editObj);
        var jsonEditText = JSON.stringify(editData);
        dataTable(jsonEditText);
        $(".modal").removeClass("hide");
        $(".chzn-select").chosen();
    });

    // Get the conditional values to update
    function getConditionalValues(elementToUpdate) {
        var loopCount = 1;
        var keySuffix = "";
        conditionalValues["condition" + loopCount] = elementToUpdate.data("record-id");
        if (elementToUpdate.find("td[data-conditional=true]").length === 0 && conditionalValues["condition" + loopCount] === "" && conditionalValues["condition" + loopCount] === undefined) {
            throw new Error("Atleast a single conditional value is required for update. Verify whether the record-id exists.");
        }
        elementToUpdate.find("td[data-conditional=true]").each(function () {
            loopCount++;
            keySuffix = $(this).data("column") === undefined ? loopCount : $(this).data("column");
            conditionalValues["condition" + keySuffix] = $(this).text().trim();
        });
    }

    // Create a editable table in modal pop up
    function dataTable(jsonEditText) {
        var editObj = $.parseJSON(jsonEditText);        
        var i = 0;
        $.each(editObj, function (key, value) {
            var innerElement = $(this)[i];
            var col = "";
            var dataColumnName = "";
            var dataType = "";
            var controlType = "";
            var j = 0;
            //Label
            $.each(innerElement, function (key, value) {
                dataColumnName = key;
                col = col + "<tr><td>" + dataColumnName + "</td>";
                var k = 0;
                //Field type and value
                $.each(value, function (key, value) {
                    controlType = key;
                    var l = 0;
                    $.each(value, function (key, value) {
                        dataType = key;
                        var m = 0;
                        $.each(value, function (key, value) {
                            col = col + "<td data-column='column_" + dataColumnName + "' data-type='" + dataType + "' data-lookup='" + key + "'>" + GetDefinedControlForEdit(controlType, dataColumnName, value, dataType, key) + "</td></tr>";
                            m++;
                        });
                        l++;
                    });
                    k++;
                });
                j++;
            });
            i++;
            $("#modalBody").html(col);            
        });
    }

    // Create the controls based on the type
    function GetDefinedControlForEdit(type, key, value, dataType, lookup) {
        switch (type) {
            case "text":
                return "<input type='text' value='" + value + "' id='" + key + "' class='' data-type='" + dataType + "'/>";
            case "date":
                return "<input type='text' value='" + value + "' id='" + key + "' class='calendar' data-type='" + dataType + "'/>";
            case "currency":
                return "<span class='input-icon'><input type='text' value='" + value + "' id='" + key + "' class='' data-type='" + dataType + "'/>" + currencyIcon + "</span>";
            case "checkbox":
                var $checked = ($elementToUpdate).find("td[data-column='" + key + "'] > input[type='checkbox']").data("is-checked");
                if ($checked !== undefined && $checked.toString().toLowerCase() === "true") {
                    return '<input name="switch-field-1" class="ace-switch ace-switch-6 checkBox" type="checkbox" value="' + value + '" checked="checked" id="' + key + '" data-type="' + dataType + '"/> <span class="lbl"></span>';
                }
                return '<input name="switch-field-1" class="ace-switch ace-switch-6 checkBox" type="checkbox" value="' + value + '"  id="' + key + '" data-type="' + dataType + '"/> <span class="lbl"></span>';
            case "select":                
                if (lookup === undefined || actionParameters.lookupData === undefined) {                    
                    return "";
                }
                //alert(actionParameters.lookupData);                
                var fieldValue = value;
                var lookUpObject = $.parseJSON(actionParameters.lookupData)                
                var selectObj = "<select id='" + key + "' class='chzn-select'>";
                var optionObj = "";
                $.each(lookUpObject, function (key, value) {                    
                    if (key.toLowerCase() === lookup.toLowerCase()) {                        
                        $.each(value, function (key, optionValue) {
                            var selected = "";
                            if (optionValue.toLowerCase() === fieldValue.toLowerCase()) {
                                selected = "selected";                                
                            }
                            optionObj += "<option value='" + key + "'" + selected + ">" + optionValue + "</option>";
                        });                        
                    }
                });
                selectObj = selectObj + optionObj + "</select>";               
                return selectObj;
            default:
                return "<input type='text' value='" + value + "' id='" + key + "' class='' data-type='" + dataType + "'/>"
        }
    }

    $("button[data-dismiss=savemodal]").click(function () {
        var editableElement;
        var editData = new Array();
        var wrapper = new Array();
        var editObj = new Object();
        if (actionParameters.componentType === undefined) {
            console.error("Component is not defined for this {0} update process.", actionParameters.tableId);
        }
        $("#modalBody>tbody>tr").find("td[data-column*='column_']").each(function () {
            var elementValue = "";
            var columnId = $(this).data("column");
            columnId = columnId.replace("column_", "");
            elementValue = GetElementValue(columnId);
            editObj[columnId] = elementValue;
        });
        $.each(conditionalValues, function (key, value) {
            editObj[key] = value;
        });
        editData.push(JSON.stringify(editObj));
        saveEditData(editData, actionParameters.componentType);
        $(".modal").addClass("hide");
    });

    function GetElementValue(elementID) {
        //elementID = elementID.toLowerCase();
        var editableElement = $("#" + elementID)
        var type = "";
        var elementValue = "";        
        if (editableElement.is("input")) {
            type = editableElement.attr("type");
        }        
        else if (editableElement.is("select")) {
            type = "select";
        }

        switch (type) {
            case "text":
                elementValue = editableElement.val();
                elementValue !== undefined ? elementValue : "";
                break;
            case "checkbox":
                elementValue = 0;
                if (editableElement.attr("checked") !== undefined) {
                    elementValue = 1;
                }
                elementValue !== undefined ? elementValue : 0;
                break;
            case "select":
                elementValue = $("#" + elementID + " :selected").val();
                elementValue !== undefined ? elementValue : "";
                break;
            default:
                elementValue = "";
                break;
        }

        if (editableElement.parent().data("type") !== undefined) {
            var dataType = editableElement.parent().data("type");
            var tempEditableElement = "";
            switch (dataType) {
                case "numeric":
                    tempEditableElement = parseFloat(editableElement.val());
                    if (!isNaN(tempEditableElement)) {
                        elementValue = tempEditableElement;
                    }
            }
        }
        return elementValue;
    }

    $(document).on("click", ".checkBox", function () {
        var $isChecked = $(this).attr("checked");
        if ($isChecked === null || $isChecked === undefined) {
            $(this).attr("checked", "checked");
        }
        else {
            $(this).removeAttr("checked");
        }
    });

    function saveEditData(saveData, componentType) {
        var jsonData = "{'saveData':'" + saveData + "', 'componentType': '" + componentType + "'}";
        doAjaxAction(actionParameters.actionUrl, jsonData, actionParameters.onSuccess);
        $("#" + actionParameters.tableId + "-edit-table").removeClass("hide");
        updateModifiedDataToMainTable(saveData);
    }

    function updateModifiedDataToMainTable(saveData) {
        var modifiedData = $.parseJSON(saveData);
        $.each(modifiedData, function (key, value) {
            $elementToUpdate.find("td[data-editable=true]").each(function () {
                if ($(this).data("column") === key) {
                    if ($(this).data("control-type") === "checkbox") {
                        var checked = "";
                        var dataIsChecked = "false";
                        if (value == 1) {
                            checked = "checked = 'checked'";
                            dataIsChecked = "true";
                        }

                        var checkboxControl = '<input name="' + key + '_Field" class="ace-switch ace-switch-6 checkBox" type="checkbox" disabled value="' + value + '"  id="' + key + '_Field" ' + checked + ' data-is-checked = "' + dataIsChecked + '"/> <span class="lbl"></span>';
                        $(this).html(checkboxControl)
                    }
                    else if ($(this).data("control-type") === "select") {                                                
                        $(this).html($("#" + key + " :selected").text())
                    }
                    else {
                        $(this).text(value);
                        if ($(this).data("control-type") === "currency") {
                            $(this).html(currencyIcon + value);
                        }
                    }
                }
            });
        });
    }
});
