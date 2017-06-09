$('.expenses').change(function () {
    var selectedExpenseID = $(this).val();
    if (selectedExpenseID != null && selectedExpenseID != '') {
        $.getJSON($("#userLookupUrl").val(), { lookupType: 'u', lookupCondition: selectedExpenseID },
                    function (data) {
                        loadData('.amountReturnedBy', data);
                        loadData('.amountReceivedBy', data);
                    });
    }
});

function loadData(selectlistname, data) {
    var $siteSelect = $(selectlistname);
    empty($siteSelect);
    $siteSelect.removeClass("chzn-select");
    $.each(data, function (index, site) {    
        $siteSelect.append($('<option/>', {
            value: site.Value,
            text: site.Text
        }));
    });
    // to reinitialize the chozen dropdown to show the newly added elements
    $(selectlistname).trigger("liszt:updated");
}

function empty(selectObj) {
    selectObj
    .find('option')
    .remove()
    .end()
    .append("<option value=''>Select</option>");
}