# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# //= require Chart.js/Chart.js
# //= require angular-chart.js/angular-chart.js


angular.module('StockChart', ['chart.js'])
  .service 'ChartApi', ($http) ->
    return getLast30Days: (code, callback) ->
      $http.get 'chart_api/getLast30Days/' + code
        .success (res) ->
          callback res
        .error (res) ->
          callback false

  .controller 'StockChartController', ($scope, ChartApi) ->


    # Todo: Improve experience, by setting timed out notification "Loading..." if takes long time.
    $scope.loadChart = () ->
      # No ticker have been choosen
      if $scope.code == ''
        return

      ChartApi.getLast30Days($scope.code, (res) ->
        if res == false
          $scope.message = 'No data available at the time' # Failed request to the server

        if res.status != 'Ok'
          $scope.message = res.error # Most of the times this is not what we want customer to see, because it can be highly technical

        labels = []
        data = []
        prevMonth = false
        res.result.forEach (dayPrice) ->
          date = dayPrice.date.split("-")
          # Show the first day of the month with the month itself
          if prevMonth == date[1]
            day = date[2]
          else
            day = date[1] + '/' + date[2]

          labels.push(day)
          prevMonth = date[1]
          data.push(dayPrice.price.toFixed(2))

        $scope.chartLabels = labels
        $scope.chartData = [data]

      )


