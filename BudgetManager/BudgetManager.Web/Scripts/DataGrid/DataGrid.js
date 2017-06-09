function applyGridProperties(tableIdentifier) {
    var oTable = $(tableIdentifier).dataTable({
        "aLengthMenu": [[5, 10, 15, 20, -1], [5, 10, 15, 20, "All"]],
        "iDisplayLength": 5
    });
}