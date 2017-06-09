using System.Web;
using System.Web.Optimization;

namespace BudgetManager.Web
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
                        "~/Scripts/jquery-{version}.js"));

            bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
                        "~/Scripts/jquery-ui-{version}.js"
                //"~/Scripts/EditorAndDisplayTemplateScripts.js"
                        ));

            bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
                        "~/Scripts/jquery.validate*",
                        "~/Scripts/jquery.validate.unobtrusive.js*",
                        "~/Scripts/bootstrap.js",
                        "~/Scripts/jquery.unobtrusive-ajax.js"
                        ));

            // Use the development version of Modernizr to develop with and learn from. Then, when you're
            // ready for production, use the build tool at http://modernizr.com to pick only the tests you need.
            bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
                        "~/Scripts/modernizr-*"));

            bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
                        "~/Content/themes/base/jquery.ui.core.css",
                        "~/Content/themes/base/jquery.ui.resizable.css",
                        "~/Content/themes/base/jquery.ui.selectable.css",
                        "~/Content/themes/base/jquery.ui.accordion.css",
                        "~/Content/themes/base/jquery.ui.autocomplete.css",
                        "~/Content/themes/base/jquery.ui.button.css",
                        "~/Content/themes/base/jquery.ui.dialog.css",
                        "~/Content/themes/base/jquery.ui.slider.css",
                        "~/Content/themes/base/jquery.ui.tabs.css",
                        "~/Content/themes/base/jquery.ui.datepicker.css",
                        "~/Content/themes/base/jquery.ui.progressbar.css",
                        "~/Content/themes/base/jquery.ui.theme.css"));

            bundles.Add(new StyleBundle("~/Content/AdminTheme/css").Include(
                        "~/Content/AdminTheme/css/bootstrap.less.css",
                        "~/Content/AdminTheme/css/bootstrap-responsive.less.css",
                        "~/Content/AdminTheme/css/font-awesome.less.css",
                        "~/Content/AdminTheme/css/chosen.css",
                        "~/Content/Site.css",
                        "~/Content/jquery.gritter.css",
                        "~/Content/AdminTheme/css/select2.css",
                        "~/Content/AdminTheme/css/bootstrap-editable.css",
                        "~/Content/AdminTheme/css/jquery-ui-1.10.3.custom.less.css"));

            bundles.Add(new StyleBundle("~/content/css").Include(
                "~/Content/bootstrap.css",
                "~/Content/body.css",
                "~/Content/bootstrap-responsive.css",
                "~/Content/bootstrap-mvc-validation.css"));

            bundles.Add(new ScriptBundle("~/bundle/scripts").Include(
            "~/Scripts/jquery.validate.less.js",
            "~/Scripts/jquery.validate.unobtrusive.less.js",
            "~/Scripts/jquery.unobtrusive-ajax.less.js",
            "~/Scripts/bootstrap.less.js"));


            bundles.Add(new StyleBundle("~/Content/LoggedInStyles").Include(
                "~/Content/Custom Styles/AdminCSS/bootstrap.less.css",
                "~/Content/Custom Styles/AdminCSS/bootstrap-responsive.less.css",
                "~/Content/Custom Styles/AdminCSS/font-awesome.less.css"
                ));

            bundles.Add(new StyleBundle("~/LogInBundle/Content/css").Include(
                "~/Content/bootstrap_login.css",
                "~/Content/animate-custom_login.css",
                "~/Content/login.css"
                ));

            bundles.Add(new ScriptBundle("~/LogInBundle/Scripts/js").Include(
                "~/Scripts/CoreBLLScripts/UserPermission.js",
                "~/Scripts/CoreBLLScripts/RecordDeletion.js",
                "~/Scripts/CoreBLLScripts/RecordEditing.js"));

            bundles.Add(new ScriptBundle("~/bundles/controls").Include(
                "~/Scripts/DataTable/jquery.dataTables.less.js",
                "~/Scripts/DataTable/jquery.dataTables.bootstrap.js",
                "~/Scripts/DatePicker/bootstrap.datepicker.js",
                "~/Scripts/DatePicker/moment.js",
                "~/Scripts/DataGrid/DataGrid.js",
                "~/Scripts/DatePicker/daterangepicker.less.js",
                "~/Scripts/jquery-ui-1.10.4.custom.js",
                "~/Scripts/ChosenDropDown/chosen.jquery.less.js",
                "~/Scripts/DataTable/fuelux.spinner.less.js",
                "~/Scripts/jquery.gritter.less.js",
                "~/Scripts/Elements/jquery.hotkeys.less.js",
                "~/Scripts/Elements/jquery.inputlimiter.1.3.1.less.js",
                "~/Scripts/Elements/jquery.maskedinput.less.js",
                "~/Scripts/Elements/bootbox.less.js",
                "~/Scripts/Elements/bootstrap-wysiwyg.less.js"));

            bundles.Add(new StyleBundle("~/bundles/homeTheme").Include(
                "~/Content/HomeTheme/css/style10.css",
                "~/Content/HomeTheme/css/demo.css",
                "~/Content/HomeTheme/css/reset.css"));

            BundleTable.EnableOptimizations = false;
        }
    }
}