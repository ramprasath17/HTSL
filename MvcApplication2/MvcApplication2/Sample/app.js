var routerApp = angular.module('routerApp', ['ui.router','datatables']);

routerApp.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/about1');
    $stateProvider

        // HOME STATES AND NESTED VIEWS ========================================
        .state('home', {
            url: '/home',
            templateUrl: 'PHPOC.html'
        })
        .state('SeriesCtrl1href', {
            url: '/SeriesCtrl1href',
            templateUrl: 'SeriesC.html'
        })
         .state('SMCtrl1href', {
             url: '/SMCtrl1href',
             templateUrl: 'SafetyManager.html'
         })
           .state('about1', {
               url: '/about1',
               views: {
                   '': {
                       templateUrl: 'dcsFrontRear.html'
                   }
              
               }

           })
        .state('DCShref', {
            url: '/DCShref',
            views: {
                '': {
                    template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull1 " ng-app="routerApp" ng-controller="DCSCtrlPageView" "><div class="svglabel">Series-C</div><div class="Front"></div></div>'
                }
            }
        })

        .state('SMhref', {
            url: '/SMhref',
            views: {
                '': {
                    template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull1 " ng-app="routerApp" ng-controller="SMCtrlPageView" "><div class="svglabel">Safety Manager</div><div class="SM24"></div></div>'
                }
            }
        })

        .state('dcsFronthref', {
            url: '/dcsFronthref',
            views: {
                '': {
                    template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull " ng-app="routerApp" ng-controller="FrontCtrlPageView"><div class="svglabel">Series-C Front Side</div><div class="Front"></div></div>'
                }
            }
        })

        .state('dcsRearhref', {
            url: '/dcsRearhref',
            views: {
                '': { template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull " ng-app="routerApp" ng-controller="RearCtrlPageView"><div class="svglabel">Series-C Rear Side</div><div class="Rear"></div></div>' }
            }
        })

        .state('SM24href', {
            url: '/SM24href',
            views: {
                '': { template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull " ng-app="routerApp" ng-controller="SM24CtrlPageView"><div class="svglabel">Safety Manager 24VDC</div> <div class="SM24"></div></div>' }
            }
        })

        .state('SM48href', {
            url: '/SM48href',
            views: {
                '': { template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull " ng-app="routerApp" ng-controller="SM48CtrlPageView" "><div class="svglabel">Safety Manager 48VDC</div> <div class="SM48"></div></div>' }
            }
        })
        //.state('SM48href', {
        //    url: '/SM48href',
        //    views: {
        //        '': { template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull " ng-app="routerApp" ng-controller="SM48CtrlPageView"><div class="svglabel">Safety Manager 48VDC</div> <svg class="SM48"></svg></div>' }
        //    }
        //})

        .state('SM60href', {
            url: '/SM60href',
            views: {
                '': { template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull " ng-app="routerApp" ng-controller="SM60CtrlPageView" "><div class="svglabel">Safety Manager 60VDC</div> <div class="SM60"></div></div>' }
            }
        })

        .state('SM110href', {
            url: '/SM110href',
            views: {
                '': { template: '<div class="col-xs-12 col-sm-12 col-lg-12 hgtfull " ng-app="routerApp" ng-controller="SM110CtrlPageView" "><div class="svglabel">Safety Manager 110VDC</div> <div class="SM110"></div></div>' }
            }
        })
        // ABOUT PAGE AND MULTIPLE NAMED VIEWS =================================
        .state('about', {
            url: '/about',
            views: {
                '': { templateUrl: 'PHPOC.html' }
                //'dcsFront@about': { template: 'Look I am a column!' },
                //'dcsRear@about': {
                //    template: 'Look I am a column2!'
                //},
                //'SM24@about': { template: 'Look I am a column24!' },
                //'SM48@about': { template: 'Look I am a column48!' },
                //'SM60@about': { template: 'Look I am a column60!' },
                //'SM110@about': { template: 'Look I am a column110!' }
            }

        });

});


routerApp.controller('DCSCtrlPageView', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 2 } })
   .then(function (response) { ChartBarline('.Front', response.data,2); });
}]);

routerApp.controller('FrontCtrlPageView', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName,ModelView:1 } })
   .then(function (response) { ChartBarline('.Front', response.data,1); });
}]);

routerApp.controller('RearCtrlPageView', ['$scope', '$location', '$http', function ($scope, $location, $http) {
    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/Rear", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
   .then(function (response) { ChartBarline('.Rear', response.data,1); });
}]);


routerApp.controller('SMCtrlPageView', ['$scope', '$location', '$http', function ($scope, $location, $http) {
    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 2 } })
   .then(function (response) { ChartBarline('.SM24', response.data,2); });
}]);


routerApp.controller('SM24CtrlPageView', ['$scope', '$location', '$http', function ($scope, $location, $http) {
    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
   .then(function (response) { ChartBarline('.SM24', response.data,1); });
}]);

routerApp.controller('SM48CtrlPageView',['$scope', '$location', '$http', function ($scope, $location, $http) {
    
    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height 
    
    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM48", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
   .then(function (response) { ChartBarline('.SM48', response.data,1); });
}]);

routerApp.controller('SM60CtrlPageView', ['$scope', '$location', '$http', function ($scope, $location, $http) {
    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height 
    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM60", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
   .then(function (response) { ChartBarline('.SM60', response.data,1); });
}]);

routerApp.controller('SM110CtrlPageView', ['$scope', '$location', '$http', function ($scope, $location, $http)  {
    $scope.svgWidth = 1200;//svg Width
    $scope.svgHeight = 500;//svg Height  
    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM110", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
   .then(function (response) { ChartBarline('.SM110', response.data,1); });
}]);

routerApp.controller('SeriesCtrl1', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 525;//svg Width
    $scope.svgHeight = 240;//svg Height 
    var ProjectName = "";
        if ($scope.drpProject != undefined)
            ProjectName = $scope.drpProject;
        var CabinetName = "";
        if ($scope.drpCabinet != undefined)
            CabinetName = $scope.drpCabinet;
        var Area = "";
        if ($scope.drpArea != undefined)
            Area = $scope.drpArea;

        var Location = "";
        if ($scope.drpLocation != undefined)
            Location = $scope.drpLocation;
        
        var CabinetTypeName = "";
        if ($scope.drpCabType != undefined)
            CabinetTypeName = $scope.drpCabType;
        var data = [];
        $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, "ModelView": -1 } })
       .then(function (response) {
           ChartBarline('.Front', response.data,-1);
       });

}]);

routerApp.controller('FrontCtrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 525;//svg Width
    $scope.svgHeight = 240;//svg Height 
    var ProjectName = "";
        if ($scope.drpProject != undefined)
            ProjectName = $scope.drpProject;
        var CabinetName = "";
        if ($scope.drpCabinet != undefined)
            CabinetName = $scope.drpCabinet;
        var Area = "";
        if ($scope.drpArea != undefined)
            Area = $scope.drpArea;

        var Location = "";
        if ($scope.drpLocation != undefined)
            Location = $scope.drpLocation;
        
        var CabinetTypeName = "";
        if ($scope.drpCabType != undefined)
            CabinetTypeName = $scope.drpCabType;
        var data = [];
        $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
       .then(function (response) {
           ChartBarline('.Front', response.data,0);
       });

}]);

routerApp.controller('RearCtrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 520;//svg Width
    $scope.svgHeight = 240;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
   var Area = "";
        if ($scope.drpArea != undefined)
            Area = $scope.drpArea;

        var Location = "";
        if ($scope.drpLocation != undefined)
            Location = $scope.drpLocation;
        
        var CabinetTypeName = "";
        if ($scope.drpCabType != undefined)
            CabinetTypeName = $scope.drpCabType;
        var data = [];
    $http.get("/api/Rear", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName,ModelView:0 } })
   .then(function (response) {
       ChartBarline('.Rear', response.data,0);
       
   });
}]);

routerApp.controller('myCtrl', ['$scope', '$location', '$http','DTOptionsBuilder', function ($scope, $location, $http,DTOptionsBuilder) { //function ($scope, $location,$http) {

    $scope.users = {};

    // DataTables configurable options
    $scope.dtOptions = DTOptionsBuilder.newOptions()
        .withDisplayLength(10)
        .withOption('bLengthChange', false);
    $scope.showModal = false;
    $scope.buttonClicked = "";
    $scope.toggleModal = function (btnClicked) {
        
        $scope.showModal = !$scope.showModal;
        var ProjectName = "";
        if ($scope.drpProject != undefined)
            ProjectName = $scope.drpProject;
        var CabinetName = "";
        if ($scope.drpCabinet != undefined)
            CabinetName = $scope.drpCabinet;
        var Area = "";
        if ($scope.drpArea != undefined)
            Area = $scope.drpArea;

        var Location = "";
        if ($scope.drpLocation != undefined)
            Location = $scope.drpLocation;

        var CabinetTypeName = "";
        if ($scope.drpCabType != undefined)
            CabinetTypeName = $scope.drpCabType;
        var data = [];
        if (btnClicked == "dcsFronthref") {
            $scope.buttonClicked = "Front side";
            $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
        else if(btnClicked == "dcsRearhref")
        {
            $scope.buttonClicked = "Rear side";
            $http.get("/api/Rear", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
        else if (btnClicked == "SM24href")
        {
            $scope.buttonClicked = "Safety Manager 24VDC";
            $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
        else if (btnClicked == "SM48href") {
            $scope.buttonClicked = "Safety Manager 48VDC";
            $http.get("/api/SM48", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
        else if (btnClicked == "SM60href") {
            $scope.buttonClicked = "Safety Manager 60VDC";
            $http.get("/api/SM60", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
        else if (btnClicked == "SM110href") {
            $scope.buttonClicked = "Safety Manager 110VDC";
            $http.get("/api/SM110", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
        else if (btnClicked == "DCShref") {
            $scope.buttonClicked = "Series-C";
            $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 2 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
        else if (btnClicked == "SMhref") {
            $scope.buttonClicked = "Safety Manager";
            $http.get("/api/SM48", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 2 } })
           .then(function (response) {
               $scope.users = response.data;
           })
        }
    };
    $scope.changeView = function (view) {
        $location.path(view); // path not hash
    }
    $scope.changeFilter = function () {
        if ($location.path() == "/SeriesCtrl1href") {
            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: -1 } })
           .then(function (response) {
               ChartBarline('.Front', response.data, -1);
           });

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width

            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: -1 } })
           .then(function (response) {
               ChartBarline('.SM24', response.data, -1);
           });

        }
       else if ($location.path() == "/SeriesCtrl1href") {
            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response) {
               ChartBarline('.Front', response.data,0);
           });

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/Rear", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
               .then(function (response) {
                   ChartBarline('.Rear', response.data,0);
               });
        }
        else if ($location.path() == "/SMCtrl1href") {
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width

            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response){ChartBarline('.SM24', response.data,0);
           });

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/SM48", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response){ChartBarline('.SM48', response.data,0);});

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/SM60", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response){ChartBarline('.SM60', response.data,0);});

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height  
            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var data = [];
            $http.get("/api/SM110", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
           .then(function (response){ChartBarline('.SM110', response.data,0);});
        }

        else if ($location.path() == "/DCShref") {

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 2 } })
           .then(function (response){ChartBarline('.Front', response.data,2);});

        }
        else if ($location.path() == "/dcsFronthref") {

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/Front", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
           .then(function (response) { ChartBarline('.Front', response.data,1); });

        }
        else if ($location.path() == "/dcsRearhref") {
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/Rear", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
           .then(function (response) { ChartBarline('.Rear', response.data,1); });
        }

        else if ($location.path() == "/SMhref") {

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 2 } })
           .then(function (response) { ChartBarline('.SM24', response.data,2); });
        }
        else if ($location.path() == "/SM24href") {
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
           .then(function (response) { ChartBarline('.SM24', response.data,1); });
        }

        else if ($location.path() == "/SM48href") {
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 

            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/SM48", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
           .then(function (response) { ChartBarline('.SM48', response.data,1); });
        }

        else if ($location.path() == "/SM60href") {

            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height 
            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/SM60", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
           .then(function (response) { ChartBarline('.SM60', response.data,1); });
        }

        else if ($location.path() == "/SM110href") {
            $scope.svgWidth = 1200;//svg Width
            $scope.svgHeight = 500;//svg Height  
            var ProjectName = "";
            if ($scope.drpProject != undefined)
                ProjectName = $scope.drpProject;
            var CabinetName = "";
            if ($scope.drpCabinet != undefined)
                CabinetName = $scope.drpCabinet;
            var Area = "";
            if ($scope.drpArea != undefined)
                Area = $scope.drpArea;

            var Location = "";
            if ($scope.drpLocation != undefined)
                Location = $scope.drpLocation;

            var CabinetTypeName = "";
            if ($scope.drpCabType != undefined)
                CabinetTypeName = $scope.drpCabType;
            var data = [];
            $http.get("/api/SM110", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 1 } })
           .then(function (response) { ChartBarline('.SM110', response.data,1); });
        }
    }
    $scope.changeProject = function (drpProject) {
        var ProjectName = "";
        if ($scope.drpProject != undefined)
            ProjectName = $scope.drpProject;

        $http.get("/api/values", { params: { "ProjectName": ProjectName } })
    .then(function (response) { $scope.CabinetVals = response.data; })
    }

    $scope.changeCabinet = function (drpProject, drpCabinet) {
        var ProjectName = "";
        if ($scope.drpProject != undefined)
            ProjectName = $scope.drpProject;

        var CabinetName = "";
        if ($scope.drpCabinet != undefined)
            CabinetName = $scope.drpCabinet;

        $http.get("/api/values", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName } })
        .then(function (response) { $scope.AreaVals = response.data; })

    }
    $scope.changeArea = function (drpProject, drpCabinet,drpArea) {

        var ProjectName = "";
        if ($scope.drpProject != undefined)
            ProjectName = $scope.drpProject;

        var CabinetName = "";
        if ($scope.drpCabinet != undefined)
            CabinetName = $scope.drpCabinet;

        var Area = "";
        if ($scope.drpArea != undefined)
            Area = $scope.drpArea;

        $http.get("/api/values", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "Area": Area } })
        .then(function (response) { $scope.LocationVals = response.data; })
    }
    $scope.changeLocation = function (drpProject, drpCabinet, drpArea,drpLocation) {

        var ProjectName = "";
        if ($scope.drpProject != undefined)
            ProjectName = $scope.drpProject;

        var CabinetName = "";
        if ($scope.changeFilterdrpCabinet != undefined)
            CabinetName = $scope.drpCabinet;

        var Area = "";
        if ($scope.drpArea != undefined)
            Area = $scope.drpArea;

        var Location = "";
        if ($scope.drpLocation != undefined)
            Location = $scope.drpLocation;
        $http.get("/api/values", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "Area": Area, "Location": Location } })
        .then(function (response) { $scope.CabTypeVals = response.data; })

    }
    $scope.message = 'test';
    //$scope.ProjectVals = LoadProjectName();
    $scope.data = [];
    $http.get("/api/values")
  .then(function (response) {
     
      $scope.ProjectVals = response.data;
      //$scope.drpProject = $scope.ProjectVals[0];
  });
    
    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    
    $http.get("/api/values", { params: { "ProjectName": ProjectName } })
    .then(function (response) { $scope.CabinetVals = response.data; })

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;

    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;

    $http.get("/api/values", { params: { "ProjectName": ProjectName,"CabinetName": CabinetName } })
    .then(function (response) { $scope.AreaVals = response.data; })

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;

    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;

    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    $http.get("/api/values", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "Area": Area } })
    .then(function (response) { $scope.LocationVals = response.data; })

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;

    var CabinetName = "";
    if ($scope.drpCabinet != undefined)

        CabinetName = $scope.drpCabinet;

    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;
    $http.get("/api/values", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "Area": Area, "Location": Location } })
    .then(function (response) { $scope.CabTypeVals = response.data; })


    $scope.scotches = [
        {
            name: 'Macallan 12',
            price: 50
        },
        {
            name: 'Chivas Regal Royal Salute',
            price: 10000
        },
        {
            name: 'Glenfiddich 1937',
            price: 20000
        }
    ];


    $scope.Legend = [
     {
         LegendName: "IDC",
         color: "#7a5230",
         LegendCurrentRating:"IDC"
     },
     {
         LegendName: "Heat Dissipation",
         color: "#32CD32",
         LegendCurrentRating: "Current Rating"
     }
    ];
   
}]);

routerApp.directive('modal', function () {
    return {
        template:
            //'<div class="modal fade" id="myModal" role="dialog"> <div class="modal-dialog"><div class="modal-content"> <div class="modal-header"><button type="button" class="close" data-dismiss="modal">&times;</button><h4 class="modal-title">Modal Header</h4></div><div class="modal-body"><p>Some text in the modal.</p></div><div class="modal-footer"><button type="button" class="btn btn-default" data-dismiss="modal">Close</button></div></div></div></div>',
            '<div class="modal  fade" >' +
            '<div class="modal-dialog">' +
              '<div class="modal-content">' +
                '<div class="modal-header">' +
                  '<button type="button" class="close" data-dismiss="modal" data-toggle="modal" aria-hidden="true">&times;</button>' +
                  '<h4 class="modal-title">{{ buttonClicked }}!!</h4> ' +
                      '<table id="tableuserslist" width="100%" datatable="ng" class="table dataTable table table-striped display dataTable no-footer DTTT_selectable dtr-inline dtr-column" dt-options="dtOptions">' +
        '<thead>' +
            '<tr>' +
                '<th width="6%">S.No</th>' +
                '<th width="21%">Project Name</th>' +
                '<th width="20%">Cabinet Name</th>' +
                '<th width="20%">Module Name</th>' +
                '<th width="7%">IDC</th>' +
                '<th width="10%">Heat Diss.</th>' +
            '</tr>' +
        '</thead>' +
        '<tbody>' +
            '<tr ng-repeat="user in users">' +
                '<td>{{$index + 1}}</td>' +
                '<td>{{user.ProjectName}}</td>' +
                '<td>{{user.CabinetName}}</td>' +
                '<td>{{user.ModuleName}}</td>' +
                '<td>{{user.IDC}}</td>' +
                '<td>{{user.HeatDiss}}</td>' +
            '</tr>' +
        '</tbody>' +
    '</table>' +

                '</div>' +
                '<div class="modal-body" ng-transclude></div>' +
              '</div>' +
            '</div>' +
          '</div>',
        restrict: 'E',
        transclude: true,
        replace: true,
        scope: true,
        link: function postLink(scope, element, attrs) {
            scope.$watch(attrs.visible, function (value) {
                if (value == true)
                    $(element).modal('show');
                else
                    $(element).modal('hide');
            });

            $(element).on('shown.bs.modal', function () {
                scope.$apply(function () {
                    scope.$parent[attrs.visible] = true;
                });
            });

            $(element).on('hidden.bs.modal', function () {
                scope.$apply(function () {
                    scope.$parent[attrs.visible] = false;
                });
            });
        }
    };
});

routerApp.controller('SMCtrl1', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 525;//svg Width
    $scope.svgHeight = 240;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: -1 } })
   .then(function (response) {
       ChartBarline('.SM24', response.data,-1);
   });
}]);

routerApp.controller('SM24Ctrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 525;//svg Width
    $scope.svgHeight = 240;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM24", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
   .then(function (response) {
       ChartBarline('.SM24', response.data,0);
   });
}]);

routerApp.controller('SM48Ctrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 525;//svg Width
    $scope.svgHeight = 240;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM48", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
   .then(function (response) {
       ChartBarline('.SM48', response.data,0);
   });
}]);

routerApp.controller('SM60Ctrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 525;//svg Width
    $scope.svgHeight = 240;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM60", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
   .then(function (response) {
       ChartBarline('.SM60', response.data,0);
   });
}]);

routerApp.controller('SM110Ctrl', ['$scope', '$location', '$http', function ($scope, $location, $http) {


    $scope.svgWidth = 525;//svg Width
    $scope.svgHeight = 240;//svg Height 

    var ProjectName = "";
    if ($scope.drpProject != undefined)
        ProjectName = $scope.drpProject;
    var CabinetName = "";
    if ($scope.drpCabinet != undefined)
        CabinetName = $scope.drpCabinet;
    var Area = "";
    if ($scope.drpArea != undefined)
        Area = $scope.drpArea;

    var Location = "";
    if ($scope.drpLocation != undefined)
        Location = $scope.drpLocation;

    var CabinetTypeName = "";
    if ($scope.drpCabType != undefined)
        CabinetTypeName = $scope.drpCabType;
    var data = [];
    $http.get("/api/SM110", { params: { "ProjectName": ProjectName, "CabinetName": CabinetName, "AreaName": Area, "LocationName": Location, "CabinetTypeName": CabinetTypeName, ModelView: 0 } })
   .then(function (response) {
       ChartBarline('.SM110', response.data,0);
   });
}]);

function ChartBarline(clss, data, Modalview) {
    //alert(Modalview);
    d3.select(clss).selectAll("*").remove();
    var scWidth = 550;
    var scheight = 250;
    if (Modalview > 0)
    {
        scWidth = 1200;
        scheight = 500;
    }
   else if (Modalview ==-1)
    {
        scWidth = 1200;
        scheight = 250;
    }

    Data = data;
    var margin = { top: 20, right: 30, bottom: 60, left: 40 },
        width = scWidth - margin.left - margin.right,
        height = scheight - margin.top - margin.bottom;
    d3.select(clss).selectAll("*").remove();
    var textWidthHolder = 0;
    /// Adding Date in LineCategory
    Data.forEach(function (d) {
        d.LineCategory.forEach(function (b) {
            b.Date = d.Date;
        })
    });

    var Categories = new Array();
    // Extension method declaration

    var Data;
    var ageNames;
    var x0 = d3.scale.ordinal()
        .rangeRoundBands([0, width], .1);
    var XLine = d3.scale.ordinal()
        .rangeRoundPoints([0, width], .1);
    var x1 = d3.scale.ordinal();

    var y = d3.scale.linear()
        .range([height, 0]);

    var YLine = d3.scale.linear().range([height, 0])
    .domain([0, d3.max(Data, function (d) { return d3.max(d.LineCategory, function (b) { return b.Value }) })]);

    var color = d3.scale.ordinal()
        .range(["#32CD32", "#0000ff", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

    var line = d3.svg.line().x(function (d) {
        return x0(d.Date) + x0.rangeBand() / 2;
    }).y(function (d) { return YLine(d.Value) });




    var xAxis = d3.svg.axis()
        .scale(x0)
        .orient("bottom");

    var yAxis = d3.svg.axis()
        .scale(y)
        .orient("left")
        .tickFormat(d3.format(".2s"));

    var YLeftAxis = d3.svg.axis().scale(YLine).orient("right").tickFormat(d3.format(".2s"));

    var svg = d3.select(clss).append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


    // Bar Data categories
    Data.forEach(function (d) {
        d.Categories.forEach(function (b) {
            if (Categories.findIndex(function (c) { return c.Name === b.Name }) == -1) {
                b.Type = "bar";
                console.log(JSON.stringify(b))
                Categories.push(b)
            }
        })
    });

    // Line Data categories
    Data.forEach(function (d) {
        d.LineCategory.forEach(function (b) {
            if (Categories.findIndex(function (c) { return c.Name === b.Name }) == -1) {
                b.Type = "line";
                console.log(JSON.stringify(b))
                Categories.push(b)
            }
        })
    });

    // Processing Line data
    lineData = DataSegregator(Data.map(function (d) { return d.LineCategory }), "Name");

    // Line Coloring
    LineColor = d3.scale.ordinal();
    LineColor.domain(Categories.filter(function (d) { return d.Type == "line" }).map(function (d) { return d.Name }));
    LineColor.range(["#d40606", "#06bf00", "#98bdc5", "#671919", "#0b172b"])
    x0.domain(Data.map(function (d) { return d.Date; }));
    XLine.domain(Data.map(function (d) { return d.Date; }));
    x1.domain(Categories.filter(function (d) { return d.Type == "bar" }).map(function (d) { return d.Name })).rangeRoundBands([0, x0.rangeBand()]);
    y.domain([0, d3.max(Data, function (d) { return d3.max(d.Categories, function (d) { return d.Value; }); })]);

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    svg.append("g")
       .attr("class", "y axis")
        .attr("transform", "translate(" + (width) + ",0)")
       .call(YLeftAxis)

     .append("text")
       .attr("transform", "rotate(-90)")
       .attr("y", -10)

       .attr("dy", ".71em")
       .style("text-anchor", "end")
       .text("Power(Watts)");

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Current(Amp)");


    var state = svg.selectAll(".state")
        .data(Data)
      .enter().append("g")
        .attr("class", "state")
        .attr("transform", function (d) { return "translate(" + x0(d.Date) + ",0)"; });

    state.selectAll("rect")
        .data(function (d) { return d.Categories; })
      .enter().append("rect")
        .attr("width", x1.rangeBand())
        .attr("x", function (d) { return x1.rangeBand()/2; })
        .attr("y", function (d) { return y(d.Value); })
        //.attr("height", function (d) { return height - y(d.Value); })
        .style("fill", function (d) { return color(d.Name); })
        .transition().delay(500).attrTween("height", function (d) {
            var i = d3.interpolate(0, height - y(d.Value));
            return function (t) {
                return i(t);
            }
        });

    // drawaing lines
    svg.selectAll(".lines").data(lineData).enter().append("g").attr("class", "line")
    .each(function (d) {
        Name = d[0].Name
        d3.select(this).append("path").attr("d", function (b) { return line(b) }).style({ "stroke-width": "2px", "fill": "none" }).style("stroke", LineColor(Name)).transition().duration(1500);
    })


    // Legends

    var LegendHolder = svg.append("g").attr("class", "legendHolder");
    var legend = LegendHolder.selectAll(".legend")
        .data(Categories.map(function (d) { return { "Name": d.Name, "Type": d.Type } }))
      .enter().append("g")
        .attr("class", "legend")
        .attr("transform", function (d, i) { return "translate(0," + (height + margin.bottom / 2) + ")"; })
        .each(function (d, i) {
            //  Legend Symbols


            d3.select(this).append("rect")
            .attr("width", function () { return 18 })
            .attr("x", function (b) {

                left = (i + 1) * 15 + i * 18 + i * 5 + textWidthHolder;
                return left;
            })
             .attr("y", function (b) { return b.Type == 'bar' ? 0 : 7 })
            .attr("height", function (b) { return b.Type == 'bar' ? 18 : 5 })
            .style("fill", function (b) { return b.Type == 'bar' ? color(d.Name) : LineColor(d.Name) });

            //  Legend Text

            d3.select(this).append("text")
            .attr("x", function (b) {

                left = (i + 1) * 15 + (i + 1) * 18 + (i + 1) * 5 + textWidthHolder;

                return left;
            })
            .attr("y", 9)
            .attr("dy", ".35em")
            .style("text-anchor", "start")
            .text(d.Name);

            textWidthHolder += getTextWidth(d.Name, "10px", "calibri");
        });


    // Legend Placing

    d3.select(".legendHolder").attr("transform", function (d) {
        thisWidth = d3.select(this).node().getBBox().width;
        return "translate(" + ((width) / 2 - thisWidth / 2) + ",0)";
    })
}

 function getTextWidth(text, fontSize, fontName) {
            c = document.createElement("canvas");
            ctx = c.getContext("2d");
            ctx.font = fontSize + ' ' + fontName;
            return ctx.measureText(text).width;
        }

        function DataSegregator(array, on) {
            var SegData;
            OrdinalPositionHolder = {
                valueOf: function () {
                    thisObject = this;
                    keys = Object.keys(thisObject);
                    keys.splice(keys.indexOf("valueOf"), 1);
                    keys.splice(keys.indexOf("keys"), 1);
                    return keys.length == 0 ? -1 : d3.max(keys, function (d) { return thisObject[d] })
                }
                , keys: function () {
                    keys = Object.keys(thisObject);
                    keys.splice(keys.indexOf("valueOf"), 1);
                    keys.splice(keys.indexOf("keys"), 1);
                    return keys;
                }
            }
            array[0].map(function (d) { return d[on] }).forEach(function (b) {
                value = OrdinalPositionHolder.valueOf();
                OrdinalPositionHolder[b] = OrdinalPositionHolder > -1 ? ++value : 0;
            })

            SegData = OrdinalPositionHolder.keys().map(function () {
                return [];
            });

            array.forEach(function (d) {
                d.forEach(function (b) {
                    SegData[OrdinalPositionHolder[b[on]]].push(b);
                })
            });

            return SegData;
        }
//.directive("FrontChart", function () {
//    return {
//        restrict: "A",
//        scope: {
//            data: "="
//        },
//        link: function (scope, element) {
//            var vis;
//            var width;
//            var height;
//            var margin;
//            var xRange;
//            var yRange;
//            var yRange1;
//            var xAxis;
//            var yAxis;
//            var yAxis1;
//            var lineFunc;
//            var lineFunc1;

//            element.addClass('line-chart');

//            width = element[0].clientWidth;
//            height = element[0].clientHeight;
//            margin = 35;

//            vis = d3.select(element[0])
//					.append("svg")
//					.attr({ width: width, height: height });

//            xRange = d3.scale.linear()
//						.range([margin, width - margin])
//						.domain([0, 3]);

//            xAxis = d3.svg.axis()
//						.scale(xRange)
//						.tickValues([]);

//            vis.append("svg:g")
//				.attr("class", "x axis")
//				.attr("transform", "translate(0," + (height - margin) + ")")
//				.call(xAxis);

//            yRange = d3.scale.linear()
//						.range([height - margin, margin])
//						.domain([0, 100]);

//            yAxis = d3.svg.axis()
//						.scale(yRange)
//						.tickValues([])
//						.orient("left");

//            vis.append("svg:g")
//				.attr("class", "y axis")
//				.attr("transform", "translate(" + (margin) + ",0)")
//				.call(yAxis);

//             yRange1 = d3.scale.linear()
//						.range([height - margin, margin])
//						.domain([0, 100]);

//            yAxis1 = d3.svg.axis()
//						.scale(yRange1)
//						.tickValues([])
//						.orient("left");

//            vis.append("svg:g")
//				.attr("class", "y axis")
//				.attr("transform", "translate(" + (margin) + ",0)")
//				.call(yAxis1);
//            lineFunc = d3.svg.line()
//				.x(function (d, i) { return xRange(d.CabinetName); })
//				.y(function (d) { return yRange(d.IDC); })
//				.interpolate('cardinal');

//            lineFunc1 = d3.svg.line()
//              .x(function (d, i) { return xRange(i); })
//              .y(function (d) { return yRange(d.Currentrating); })
//              .interpolate('cardinal');

//            var path = vis.append("svg:path")
//				.attr("d", lineFunc(scope.data))
//				.attr("stroke", "black")
//				.attr("stroke-width", 1)
//				.attr("fill", "none");

//            var path1 = vis.append("svg:path")
//           .attr("d", lineFunc1(scope.data))
//           .attr("stroke", "#7a5230")
//           .attr("stroke-width", 1)
//           .attr("fill", "none");
//            var circle = vis.selectAll("circle")
//							.data(scope.data);

//            var circle1 = vis.selectAll("circle")
//							.data(scope.data);

//            circle.enter().append("circle")
//				.attr("cx", function (d, i) { return i * ((width - margin * 2) / 3) + margin; })
//				.attr("cy", function (d) { return height - margin - (d.IDC / 100) * height; })
//				.attr("r", 5)
//				.style("fill", function (d) { return "#ef4e3a"; });

//            circle1.enter().append("circle")
//				.attr("cx", function (d, i) { return i * ((width - margin * 2) / 3) + margin; })
//                .attr("cy", function (d) { return height - margin - (d.Currentrating / 100) * height; })
//				.attr("r", 5)
//				.style("fill", function (d) { return "#ef4e3a"; });

//            scope.$watch(
//		    	"data",
//		    	function () {
//		    	    path.attr("d", lineFunc(scope.data));
//		    	    vis.selectAll("circle")
//		    			.attr("cy", function (d) { return height - margin - (d.IDC / 100) * (height - margin * 2); })
//		    	},
//		    	true
//		    );

//            scope.$watch(
//              "data",
//              function () {
//                  path1.attr("d", lineFunc1(scope.data));
//                  vis.selectAll("circle1")
//                  .attr("cy", function (d) { return height - margin - (d.Currentrating / 100) * (height - margin * 2); });
//              },
//              true
//          );
//        }
//    };
//})
//routerApp
//.directive("lineChart", function () {
//    return {
//        restrict: "A",
//        scope: {
//            data: "="
//        },
//        link: function (scope, element) {
//            var vis;
//            var width;
//            var height;
//            var margin;
//            var xRange;
//            var yRange;
//            var yRange1;
//            var xAxis;
//            var yAxis;
//            var yAxis1;
//            var lineFunc;
//            var lineFunc1;

//            element.addClass('line-chart');

//            width = element[0].clientWidth;
//            height = element[0].clientHeight;
//            margin = 35;

//            vis = d3.select(element[0])
//					.append("svg")
//					.attr({ width: width, height: height });

//            xRange = d3.scale.linear()
//						.range([margin, width - margin])
//						.domain([0, 3]);

//            xAxis = d3.svg.axis()
//						.scale(xRange)
//						.tickValues([]);

//            vis.append("svg:g")
//				.attr("class", "x axis")
//				.attr("transform", "translate(0," + (height - margin) + ")")
//				.call(xAxis);

//            yRange = d3.scale.linear()
//						.range([height - margin, margin])
//						.domain([0, 100]);

//            yAxis = d3.svg.axis()
//						.scale(yRange)
//						.tickValues([])
//						.orient("left");

//            vis.append("svg:g")
//				.attr("class", "y axis")
//				.attr("transform", "translate(" + (margin) + ",0)")
//				.call(yAxis);

//            yRange1 = d3.scale.linear()
//                       .range([height - margin, margin])
//                       .domain([0, 100]);

//            yAxis1 = d3.svg.axis()
//						.scale(yRange1)
//						.tickValues([])
//						.orient("left");

//            vis.append("svg:g")
//				.attr("class", "y axis")
//				.attr("transform", "translate(" + (margin) + ",0)")
//				.call(yAxis1);

//            lineFunc = d3.svg.line()
//				.x(function (d, i) { return xRange(i); })
//				.y(function (d) { return yRange(d.IDC); })
//                //.showValues(true)
//				.interpolate('cardinal');

//            lineFunc1 = d3.svg.line()
//              .x(function (d, i) { return xRange(i); })
//              .y(function (d) { return yRange(d.CurrentRating); })
//                //.showValues(true)
//              .interpolate('cardinal');

//              vis.append("text")
//        .attr("transform", "rotate(-90)")
//        .attr("y", 0 - margin.left)
//        .attr("x", 0 - (height / 2))
//        .attr("dy", "1em")
//        .style("text-anchor", "middle")
//        .text("Current Rating");
//    // text label for the x axis
//            vis.append("text")
//            .attr("x", width/2 )
//            .attr("y", height -20)
//            .style("text-anchor", "middle")
//            .text("Cabinet Name"); 


//            var path = vis.append("svg:path")
//				.attr("d", lineFunc(scope.data))
//				.attr("stroke", "black")
//				.attr("stroke-width", 1)
//				.attr("fill", "none");

//            var path1 = vis.append("svg:path")
//           .attr("d", lineFunc1(scope.data))
//           .attr("stroke", "#7a5230")
//           .attr("stroke-width", 1)
//           .attr("fill", "none");
//            var circle = vis.selectAll("circle")
//							.data(scope.data);

//            var circle1 = vis.selectAll("circle")
//							.data(scope.data);

//            circle.enter().append("circle")
//				.attr("cx", function (d, i) { return i * ((width - margin * 2) / 3) + margin; })
//				.attr("cy", function (d) { return height - margin - (d.IDC / 100) * height; })
//				.attr("r", 5)
//				.style("fill", function (d) { return "#66cc33"; });

//            circle1.enter().append("circle")
//				.attr("cx", function (d, i) { return i * ((width - margin * 2) / 3) + margin; })
//                .attr("cy", function (d) { return height - margin - (d.CurrentRating / 100) * height; })
//				.attr("r", 5)
//				.style("fill", function (d) { return "#4a87ee"; });

//            scope.$watch(
//				"data",
//				function () {
//				    path.attr("d", lineFunc(scope.data));
//				    vis.selectAll("circle")
//						.attr("cy", function (d) { return height - margin - (d.IDC / 100) * (height - margin * 2); })
//				},
//				true
//			);

//            scope.$watch(
//              "data",
//              function () {
//                  path1.attr("d", lineFunc1(scope.data));
//                  vis.selectAll("circle1")
//                  .attr("cy", function (d) { return height - margin - (d.CurrentRating / 100) * (height - margin * 2); });
//              },
//              true
//          );
//        }
//    };
//})

//.directive("lineChart1", function () {
//    return {
//        restrict: "A",
//        scope: {
//            data: "="
//        },
//        link: function (scope, element) {
//            var vis;
//            var width;
//            var height;
//            var margin;
//            var xRange;
//            var yRange;
//            var yRange1;
//            var xAxis;
//            var yAxis;
//            var yAxis1;
//            var lineFunc;
//            var lineFunc1;

//            element.addClass('line-chart1');

//            width = element[0].clientWidth;
//            height = element[0].clientHeight;
//            margin = 35;

//            vis = d3.select(element[0])
//					.append("svg")
//					.attr({ width: width, height: height });

//            xRange = d3.scale.linear()
//						.range([margin, width - margin])
//						.domain([0, 3]);

//            xAxis = d3.svg.axis()
//						.scale(xRange)
//						.tickValues([]);

//            vis.append("svg:g")
//				.attr("class", "x axis")
//				.attr("transform", "translate(0," + (height - margin) + ")")
//				.call(xAxis);

//            yRange = d3.scale.linear()
//						.range([height - margin, margin])
//						.domain([0, 100]);

//            yAxis = d3.svg.axis()
//						.scale(yRange)
//						.tickValues([])
//						.orient("left");

//            vis.append("svg:g")
//				.attr("class", "y axis")
//				.attr("transform", "translate(" + (margin) + ",0)")
//				.call(yAxis);

//            yRange1 = d3.scale.linear()
//                       .range([height - margin, margin])
//                       .domain([0, 100]);

//            yAxis1 = d3.svg.axis()
//						.scale(yRange1)
//						.tickValues([])
//						.orient("left");

//            vis.append("svg:g")
//				.attr("class", "y axis")
//				.attr("transform", "translate(" + (margin) + ",0)")
//				.call(yAxis1);
//            lineFunc = d3.svg.line()
//				.x(function (d, i) { return xRange(i); })
//				.y(function (d) { return yRange(d.value); })
//				.interpolate('cardinal');

//            lineFunc1 = d3.svg.line()
//              .x(function (d, i) { return xRange(i); })
//              .y(function (d) { return yRange(d.value1); })
//              .interpolate('cardinal');

//            var path = vis.append("svg:path")
//				.attr("d", lineFunc(scope.data))
//				.attr("stroke", "black")
//				.attr("stroke-width", 1)
//				.attr("fill", "none");

//            var path1 = vis.append("svg:path")
//           .attr("d", lineFunc1(scope.data))
//           .attr("stroke", "#7a5230")
//           .attr("stroke-width", 1)
//           .attr("fill", "none");
//            var circle = vis.selectAll("circle")
//							.data(scope.data);

//            var circle1 = vis.selectAll("circle")
//							.data(scope.data);

//            circle.enter().append("circle")
//				.attr("cx", function (d, i) { return i * ((width - margin * 2) / 3) + margin; })
//				.attr("cy", function (d) { return height - margin - (d.value / 100) * height; })
//				.attr("r", 5)
//				.style("fill", function (d) { return d.color; });

//            circle1.enter().append("circle")
//				.attr("cx", function (d, i) { return i * ((width - margin * 2) / 3) + margin; })
//                .attr("cy", function (d) { return height - margin - (d.value1 / 100) * height; })
//				.attr("r", 5)
//				.style("fill", function (d) { return d.color; });

//            scope.$watch(
//				"data",
//				function () {
//				    path.attr("d", lineFunc(scope.data));
//				    vis.selectAll("circle")
//						.attr("cy", function (d) { return height - margin - (d.value / 100) * (height - margin * 2); })
//				},
//				true
//			);

//            scope.$watch(
//              "data",
//              function () {
//                  path1.attr("d", lineFunc1(scope.data));
//                  vis.selectAll("circle1")
//                  .attr("cy", function (d) { return height - margin - (d.value1 / 100) * (height - margin * 2); });
//              },
//              true
//          );
//        }
//    };
//})
