'use strict'

app = angular.module 'datePeriodPicker'
app.controller 'DatepickerModalController', ['$scope', 'close', 'start', 'end', 'buttonName', 'callback', 'options', ($scope, close, start, end, buttonName, callback, options) ->
  if start? then $scope.start = new Date start.getTime()
  if end? then $scope.end = new Date end.getTime()
  if buttonName? then $scope.buttonName = buttonName
  if callback? then $scope.callback = callback
  $scope.options = options
  $scope.close = ->
    $scope.callback('close')
    if options.project == 'flights'   # flights
      close({
        trip: $scope.options.trip,
        sdate0: $scope.options.sdate0,
        sdate1: $scope.options.sdate1,
        sdate2: $scope.options.sdate2
      })
    else
      close({start:$scope.start, end:$scope.end})
  if !options.display
    close(null, 200)
  $scope.$on '$locationChangeStart', (event, next, current) ->
    if options.display == 1
      $scope.callback('close')
      close()
]
