//Learn from MSDN

$.validator.addMethod("stringRange", function (value, element, params) {
    var stringLength = $(value).val().length;
    if (stringLength < 8) {
        return false;
    }
    return true;
});

$.validator.unobtrusive.adapters.add("stringRange", function (options) {
    options.rule["stringRange"] 
});