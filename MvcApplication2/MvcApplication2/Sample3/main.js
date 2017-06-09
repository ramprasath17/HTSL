angular.module('myApp', []).directive('crD3Bars', [
  function () {
      return {
          restrict: 'E',
          scope: {
              data: '='
          },
          link: function (scope, element) {
              scope.data.forEach(function (d) {
                  d.name = d.name._i;
                  d.value = +d.value;
                  //console.log(d.name, d.value)
              });
              var margin = { top: 20, right: 20, bottom: 30, left: 40 },
                width = 800 - margin.left - margin.right,
                height = 500 - margin.top - margin.bottom;
              var svg = d3.select(element[0])
                .append("svg")
                .attr('width', 800)
                .attr('height', 800)
                .append("g")
                  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

              var x = d3.scale.ordinal().rangeRoundBands([0, width], .1);
              var y = d3.scale.linear().range([height, 0]);

              var xAxis = d3.svg.axis()
                  .scale(x)
                  .orient("bottom");

              var yAxis = d3.svg.axis()
                  .scale(y)
                  .orient("left")
                  .ticks(10);

              //For tool tip

              var tip = d3.tip()
            .attr('class', 'd3-tip')
            .offset([-10, 0])
            .html(function (d) {
                return "<span style='color:red'>" + d.date, d.value + "</span>";
            });

              svg.call(tip);
              //Render graph based on 'data'
              scope.render = function (data) {
                  //Set our scale's domains
                  x.domain(data.map(function (d) { return d.name; }));
                  y.domain([0, d3.max(data, function (d) { return d.value; })]);

                  //Redraw the axes
                  svg.selectAll('g.axis').remove();
                  //X axis
                  svg.append("g")
                      .attr("class", "x axis")
                      .attr("transform", "translate(0," + height + ")")
                      .call(xAxis)
                      .selectAll("text")
                  .style("text-anchor", "end")
                  .attr("dx", "-.8em")
                  .attr("dy", "-.55em")
                  .attr("transform", "rotate(-60)");

                  //Y axis
                  svg.append("g")
                      .attr("class", "y axis")
                      .call(yAxis)
                    .append("text")
                      .attr("transform", "rotate(-90)")
                      .attr("y", 6)
                      .attr("dy", ".55em")
                      .attr("transform", "rotate(-90)")
                      .style("text-anchor", "end")
                      .text("value");


                  var bars = svg.selectAll(".bar").data(data);
                  bars.enter()
                    .append("rect")
                    .attr("class", "bar")
                    .attr("x", function (d) { return x(d.name); })
                    .attr("width", x.rangeBand())
                    .attr('height', function (d) { return height - y(d.value); })
                    .attr("y", function (d) { return y(d.value); })
                    .on('mouseover', tip.show)
                  .on('mouseout', tip.hide)
                  //Animate bars
                  // bars
                  //     .transition()
                  //     .duration(1000)
                  //     .attr('height', function(d) { return height - y(d.value); })
                  //     .attr("y", function(d) { return y(d.value); })
                  // //     .on('mouseover', tip.show)
                  // // .on('mouseout', tip.hide)

              };

              //Watch 'data' and run scope.render(newVal) whenever it changes
              //Use true for 'objectEquality' property so comparisons are done on equality and not reference
              scope.$watch('data', function () {
                  scope.render(scope.data);
              }, true);
          }
      };
  }
])


   .controller('Ctrl', function ($scope, $http) {
       var currentDate,
         weekStart,
         weekEnd,
         shortWeekFormat = 'MMMM Do';
       $scope.currentWeekStart;
       $scope.currentWeekEnd;

       function setCurrentDate(aMoment) {
           currentDate = aMoment,
           weekStart = currentDate.clone().startOf('week'),
           weekEnd = currentDate.clone().endOf('week')
       }

       setCurrentDate(moment());

       $scope.currentWeekStart = function () { return weekStart.format(shortWeekFormat); };
       $scope.currentWeekEnd = function () { return weekEnd.format(shortWeekFormat); };

       $scope.week = function (item) {
           var eventTime = moment(item.name);
           return (eventTime >= weekStart && eventTime <= weekEnd);
       };
       var data = [
                 { name: moment('May 29 2016'), value: 300 },
             { name: moment('May 30 2016'), value: 150 },
             { name: moment('May 31 2016'), value: 400 },
             { name: moment('Jun 1 2016'), value: 300 },
             { name: moment('Jun 2 2016'), value: 100 },
             { name: moment('Jun 3 2016'), value: 300 },
             { name: moment('Jun 4 2016'), value: 150 },
                 { name: moment('Jun 5 2016'), value: 300 },
             { name: moment('Jun 6 2016'), value: 150 },
             { name: moment('Jun 7 2016'), value: 400 },
             { name: moment('Jun 8 2016'), value: 300 },
             { name: moment('Jun 9 2016'), value: 100 },
             { name: moment('Jun 10 2016'), value: 300 },
             { name: moment('Jun 11 2016'), value: 150 },
             { name: moment('Jun 12 2016'), value: 400 },
             { name: moment('Jun 13 2016'), value: 300 },
             { name: moment('Jun 14 2016'), value: 100 },
             { name: moment('Jun 15 2016'), value: 400 },
             { name: moment('Jun 16 2016'), value: 300 },
             { name: moment('Jun 17 2016'), value: 100 },
             { name: moment('Jun 18 2016'), value: 100 }
       ];

       var beginValue = weekStart._d;
       var endValue = weekEnd._d;

       $scope.myData = data.filter(function (d) {
           return d.name >= beginValue && d.name <= endValue;
       });

       $scope.nextWeek = function () {
           var next = setCurrentDate(currentDate.add(7, 'days'));
           next = currentDate;
           beginValue = weekStart._d;
           endValue = weekEnd._d;

           $scope.myData = data.filter(function (d) {
               return d.name >= beginValue && d.name <= endValue;
           });


           $scope.$watch('myData', function () {
               $scope.render($scope.myData);
           }, true);
           console.log($scope.myData)

       };


       $scope.prevWeek = function () {
           var prev = setCurrentDate(currentDate.subtract(7, 'days'));
           prev = currentDate;
           //console.log(weekStart)
           //console.log(weekEnd)
           $scope.myData = data.filter(function (d) {
               return d.name >= weekStart._d && d.name <= weekEnd._d;
           });
           // console.log($scope.myData)
       };


   });