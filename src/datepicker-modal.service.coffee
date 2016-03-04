'use strict'

app = angular.module 'datePeriodPicker'
app.service 'DatepickerModalService', ['ModalService', '$q', (ModalService, $q) ->
  # use preload before using show in order to improve
  preload: (start, end, options) ->
    options.display = 0
    ModalService.showModal(
      templateUrl: 'release/datepicker-modal.html'
      controller: 'DatepickerModalController'
      inputs:
        start: start
        end: end
        buttonName: null
        options: options
    )

  showModal: (start, end, buttonName, options) ->
    options.display = 1
    deferred = $q.defer()
    ModalService.showModal(
      templateUrl: 'release/datepicker-modal.html'
      controller: 'DatepickerModalController'
      inputs:
        start: start
        end: end
        buttonName: buttonName
        options: options
    ).then (modal) ->
      modal.close.then (result) ->
        if result then deferred.resolve result else deferred.reject()
    deferred.promise

  show: (start, end, options) ->
    this.showModal(start, end, null, options)

  checkin: (start, end, options) ->
    this.showModal(start, end, 'checkin', options)

  checkout: (start, end, options) ->
    this.showModal(start, end, 'checkout', options)
]
