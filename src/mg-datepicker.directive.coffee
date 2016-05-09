'use strict'

app = angular.module 'datePeriodPicker'

app.directive 'mgDatepicker', ['$timeout', '$filter', ($timeout, $filter) ->
  restrict: 'AE'
  replace: true
  scope:
    mgOptions: '='
    mgStart: '='
    mgEnd: '='
    mgButtonName: '='
    mgCallback: '='
    mgSelect: '&'

  templateUrl: (tElement, tAttrs) ->
    return "release/mg-datepicker.html"

  link: (scope, element, attrs) ->
    if !scope.mgStart? then return
    $timeout () ->  # Scrolling to selected dates
      id = $filter('date')(scope.mgStart, 'yyyy.MM')
      monthElement = angular.element document.getElementById(id)
      element.parent()[0].scrollTop = monthElement[0].offsetTop
      
  controller: ['$scope', 'ModalService', 'Calendar', (scope, ModalService, Calendar) ->
    scope.weekdays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
    startSelected = false
    # init pension options
    if scope.mgOptions.mgPenTodaysDeal or (scope.mgStart and scope.mgButtonName is 'checkout')
      startSelected = true

    # Get date restictions
    scope.restrictions =
      mindate: new Date()
      maxdate: new Date()
    if scope.mgOptions?.selectableDays?
      # if selectableDays is 1, then only today is selectable -> selectableDays-1
      nEnabledTimeLength = (1000 * 60 * 60 * 24) * (scope.mgOptions.selectableDays-1)
      scope.restrictions.maxdate.setTime(scope.restrictions.maxdate.getTime() + nEnabledTimeLength)
    else
      scope.restrictions.maxdate.setMonth scope.restrictions.mindate.getMonth() + 12

    if scope.mgOptions?.mindate?
      scope.restrictions.mindate = new Date scope.mgOptions.mindate
    if scope.mgOptions?.maxdate?
      scope.restrictions.maxdate = new Date scope.mgOptions.maxdate
    else
    scope.restrictions.mindate.setHours 0, 0, 0, 0
    scope.restrictions.maxdate.setHours 23, 59, 59, 999

    # Make an array of months to be displayed  date restictions
    # Show months that have at least one enabled day
    months = []
    date = new Date scope.restrictions.mindate.getTime()
    date.setHours 0, 0, 0, 0
    date.setDate 1

    while date <= scope.restrictions.maxdate
      months.push new Date date.getTime()
      date.setMonth date.getMonth() + 1

    weeksInMonth = (month) ->
      weeks = []
      day = new Date month
      while day.getMonth() is month.getMonth()
        newDay = new Date day
        if !week
          week = []
          # push null for empty days
          for each in [1..day.getDay()] by 1
            week.push null
        # end of week or end of month
        if day.getDay() is 6 or (new Date day.getYear(), day.getMonth()+1, 0).getDate()==day.getDate()
          week.push newDay

          weeks.push week
          week = []
        else
          week.push newDay

        day.setDate day.getDate()+1
      weeks

    activate = ->
      scope.dates = []
      for monthStart in months
        scope.dates.push { text: $filter('date')(monthStart, 'yyyy.MM'), weeks: weeksInMonth monthStart }

    if scope.mgOptions.enableKoreanCalendar
      Calendar.load scope.restrictions.mindate, scope.restrictions.maxdate, scope.mgOptions.holidayUrl

    scope.calendar =
      offsetMargin: (date) ->
        new Date(date.getFullYear(), date.getMonth()).getDay() * 2.75 + 'rem'
      isVisible: (date, day) ->
        new Date(date.getFullYear(), date.getMonth(), day).getMonth() is date.getMonth()
      isDisabled: (currentDate) ->
        if scope.mgStart and scope.mgEnd and scope.mgButtonName is 'checkout'
          mindate = new Date scope.mgStart
          mindate.setDate mindate.getDate() + 1
        else
          mindate = scope.restrictions.mindate
        if scope.mgOptions.limitNights? and startSelected
          maxdate = new Date scope.mgStart.getFullYear(), scope.mgStart.getMonth(), scope.mgStart.getDate() + scope.mgOptions.limitNights
          if maxdate > scope.restrictions.maxdate then maxdate = scope.restrictions.maxdate
        else
          maxdate = scope.restrictions.maxdate
        (mindate? and currentDate < mindate) or (maxdate? and currentDate > maxdate)
      isToday: (day) ->
        day.toDateString() == new Date().toDateString()
      isStart: (day) ->
        scope.mgStart? and scope.mgStart.getTime() is day.getTime()
      isEnd: (day) ->
        scope.mgEnd? and scope.mgEnd.getTime() is day.getTime()
      class: (day) ->
        classString = ''
        dayObj = new Date day
        if this.isDisabled dayObj
          classString = 'disabled'
        else if scope.mgOptions.enableKoreanCalendar and Calendar.isHoliday dayObj
          classString = 'holiday'
        else
          if dayObj.getDay() is 0
            classString = 'sunday'
          else if dayObj.getDay() is 6
            classString = 'saturday'
        if scope.mgStart? and scope.mgStart.getTime() is dayObj.getTime()
          classString = 'selected'
        else if scope.mgEnd? and scope.mgEnd.getTime() is dayObj.getTime()
          classString = 'selected'
        else if scope.mgStart? and scope.mgEnd? and !startSelected and dayObj > scope.mgStart and dayObj < scope.mgEnd
          classString = 'between-selected'
        else if scope.mgOptions.today?
          if dayObj.getTime() is scope.mgOptions.today.setHours(0, 0, 0, 0)
            classString += ' today'
        else if dayObj.getTime() is new Date().setHours(0, 0, 0, 0)
          classString += ' today'
        classString
      startDayText: ->
        if scope.mgOptions.startDateText
          scope.startDateText
      endDayText: ->
        if scope.mgOptions.endDateText
          scope.endDateText

      select: (date) ->
        # distinguish between tapping a start button and an end button
        if scope.mgButtonName is 'checkout' and scope.mgStart and scope.mgEnd
          scope.mgEnd = date
          startSelected = false
          if scope.mgCallback
            scope.mgCallback('end')
          $timeout (->
            scope.mgSelect()
          ), 300
        else
          # [pension] today's deal only
          # startDate is fixed and only end date will be changed
          if scope.mgOptions.mgPenTodaysDeal
            scope.mgEnd = date
            if scope.mgCallback
              scope.mgCallback('end')
            $timeout (->
              scope.mgSelect()
            ), 300
          else # general case
            startLimit = new Date scope.mgEnd
            startLimit.setDate startLimit.getDate() - scope.mgOptions.limitNights
            if !startSelected or (startSelected and date <= scope.mgStart)
              if !scope.mgButtonName or !scope.mgEnd or scope.mgEnd <= date or date < startLimit
                scope.mgStart = date
                scope.mgEnd = null
                startSelected = true
                if scope.mgCallback
                  scope.mgCallback('start')
              else
                scope.mgStart = date
                if scope.mgCallback
                  scope.mgCallback('start')

                $timeout (->
                  scope.mgSelect()
                ), 300
            else
              scope.mgEnd = date
              startSelected = false
              if scope.mgCallback
                scope.mgCallback('end')

              $timeout (->
                scope.mgSelect()
              ), 300
    activate()
  ]
]
