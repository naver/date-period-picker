'use strict'

app = angular.module 'datePeriodPicker'
app.controller 'DatepickerModalController', ['$scope', 'close', 'start', 'end', 'buttonName', 'options', ($scope, close, start, end, buttonName, options) ->
  if start? then $scope.start = new Date start.getTime()
  if end? then $scope.end = new Date end.getTime()
  if buttonName? then $scope.buttonName = buttonName
  $scope.options = options
  $scope.close = close
  if !options.display
    close(null, 200)
]
