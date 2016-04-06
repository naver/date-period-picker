'use strict'

app = angular.module 'datePeriodPicker'
app.controller 'DatepickerModalController', ['$scope', 'close', 'start', 'end', 'buttonName', 'callback', 'options', ($scope, close, start, end, buttonName, callback, options) ->
  if start? then $scope.start = new Date start.getTime()
  if end? then $scope.end = new Date end.getTime()
  if buttonName? then $scope.buttonName = buttonName
  if callback? then $scope.callback = callback
  $scope.options = options
  $scope.close = ->
    close({start:$scope.start, end:$scope.end})
  if !options.display
    close(null, 200)
]
