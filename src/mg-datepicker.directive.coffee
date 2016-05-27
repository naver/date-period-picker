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

  controller: ['$scope', 'ModalService', 'Calendar', '$compile', (scope, ModalService, Calendar, compile) ->
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
      arrayMonths = [];
      for monthStart in months
#        scope.dates.push { text: $filter('date')(monthStart, 'yyyy.MM'), weeks: weeksInMonth monthStart }
        arrayMonths.push {monthText:$filter('date')(monthStart, 'yyyy.MM'), weeks:weeksInMonth(monthStart)}
      drawCalendar(arrayMonths);

    drawCalendar = (arrayMonths) ->
      calendarHtml = ''
      for month in arrayMonths
        calendarHtml += getMonthHtml month
      elCustom = document.getElementById 'custom-modal'
      elCon = elCustom.querySelector '.datepicker'
      welCon = angular.element elCon
      elCompile = compile(calendarHtml)(scope)
      welCon.html ''
      welCon.append elCompile

    getMonthHtml = (obj) ->
      weeks = obj.weeks
      monthText = obj.monthText
      str = ''
      str += '<div class="month" id="' + monthText + '">'
      str += '<div class="title"><div class="title_label">' + monthText + '</div></div>'
      str += '<table cellspacing="0" cellpadding="0" class="table">'
      str += '<thead class="header"><tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr></thead>'
      str += '<tbody class="body">'
      for week in weeks
        dateArr = week
        str += '<tr>'
        for dateObj in dateArr
          if dateObj == null
            str += '<td><div class="cell"><div class="num"></div></div></td>'
          else
            numClass = scope.calendar.class(dateObj)
            str += '<td id="' + $filter('date')(dateObj, 'yyyyMd') + '" ng-click="calendar.select(' + $filter('date')(dateObj, 'yyyy,M,d') + ')" class="' + numClass + '">'
            str += '<div class="cell">'
            str += '<div class="num">' + dateObj.getDate() + '</div>'
            # 오늘
            if numClass.indexOf('today') > 0
              str += '<div class="txt txtToday">오늘</div>'
            # 체크인
            if scope.calendar.isStart(dateObj)
              str += '<div class="txt txtCheckIn">' + scope.mgOptions.checkInString + '</div>'
            # 체크아웃
            if scope.calendar.isEnd(dateObj)
              str += '<div class="txt txtCheckOut">' + scope.mgOptions.checkOutString + '</div>'
            str += '</div></td>'
        str += '</tr>';
      str += '</tbody></table></div>';
      str

    drawCheckInCheckOut = ->
      if scope.mgStart != null
        drawStartDate scope.mgStart, scope.mgStart.getFullYear(), scope.mgStart.getMonth() + 1, scope.mgStart.getDate()
      if scope.mgEnd != null
        drawEndDate scope.mgEnd, scope.mgEnd.getFullYear(), scope.mgEnd.getMonth() + 1, scope.mgEnd.getDate()
      if scope.mgStart != null and scope.mgEnd != null
        beDate = new Date(scope.mgStart.getFullYear(), scope.mgStart.getMonth(), scope.mgStart.getDate())
        beDate.setDate beDate.getDate() + 1
        while beDate < scope.mgEnd
          elTd = document.getElementById($filter('date')(beDate, 'yyyyMd'))
          angular.element(elTd).addClass 'between-selected'
          beDate.setDate beDate.getDate() + 1

    drawStartDate = (date, nYear, nMonth, nDate) ->
      td = document.getElementById nYear + '' + nMonth + '' + nDate
      angular.element(td).addClass 'selected'
      cell = td.querySelector '.cell'
      angular.element(cell).append '<div class="txt txtCheckIn">' + scope.mgOptions.checkInString + '</div>'

      elCustom = document.getElementById 'custom-modal'
      if scope.calendar.isToday(date)                             # 만약 오늘을 클릭한거라면
        # 글자 제거
        elTodayStr = elCustom.querySelector '.txtToday'
        if typeof elTodayStr != 'undefined'
          angular.element(elTodayStr).remove()
        # 클래스 제거
        elToday = elCustom.querySelector '.today'
        if typeof elToday != 'undefined'
          angular.element(elToday).removeClass 'today'
      else                                                        # 오늘을 클릭한게 아니면
        todayId = $filter('date')(Calendar.getToday(), 'yyyyMd')
        td = document.getElementById todayId
        if td.querySelector('.txtToday') == null
          # 오늘 표시가 없으면 넣는다
          angular.element(td).addClass 'today'
          angular.element(td.querySelector('.cell')).append '<div class="txt txtToday">오늘</div>'

    drawEndDate = (date, nYear, nMonth, nDate) ->
      td = document.getElementById nYear + '' + nMonth + '' + nDate
      angular.element(td).addClass 'selected'
      cell = td.querySelector '.cell'
      angular.element(cell).append '<div class="txt txtCheckOut">' + scope.mgOptions.checkOutString + '</div>'

    removeCheckOut = ->
      elCustom = document.getElementById 'custom-modal'
      # 체크아웃 글자 remove
      elCheckOut = elCustom.querySelector '.txtCheckOut'
      if typeof elCheckOut != 'undefined'
        angular.element(elCheckOut).remove()
      # selected removeClass
      arrSelect = elCustom.querySelectorAll '.selected'
      if 0 < arrSelect.length
        checkoutSelected = arrSelect[arrSelect.length - 1]
        angular.element(checkoutSelected).removeClass 'selected'
      # between-selected removeClass
      arrBetween = elCustom.querySelectorAll '.between-selected'
      for elBetween in arrBetween
        angular.element(elBetween).removeClass 'between-selected'

    removeCheckInOut = () ->
      elCustom = document.getElementById 'custom-modal'
      # 체크인 글자 remove
      elCheckIn = elCustom.querySelector '.txtCheckIn'
      if typeof elCheckIn != 'undefined'
        angular.element(elCheckIn).remove()
      # 체크아웃 글자 remove
      elCheckOut = elCustom.querySelector '.txtCheckOut'
      if typeof elCheckOut != 'undefined'
        angular.element(elCheckOut).remove()
      # selected removeClass
      arrSelect = elCustom.querySelectorAll '.selected'
      for elSelect in arrSelect
        angular.element(elSelect).removeClass 'selected'
      # between-selected removeClass
      arrBetween = elCustom.querySelectorAll '.between-selected'
      for elBetween in arrBetween
        angular.element(elBetween).removeClass 'between-selected'


    # 공휴일 로드
    if scope.mgOptions.enableKoreanCalendar
      Calendar.load scope.restrictions.mindate, scope.restrictions.maxdate, scope.mgOptions.holidayUrl

    scope.calendar =
      offsetMargin: (date) ->
        new Date(date.getFullYear(), date.getMonth()).getDay() * 2.75 + 'rem'
      isVisible: (date, day) ->
        new Date(date.getFullYear(), date.getMonth(), day).getMonth() is date.getMonth()
      isDisabled: (currentDate) ->
#        if scope.mgStart and scope.mgEnd and scope.mgButtonName is 'checkout'
#          mindate = new Date scope.mgStart
#          mindate.setDate mindate.getDate() + 1
#        else
#          mindate = scope.restrictions.mindate
        mindate = scope.restrictions.mindate
        if scope.mgOptions.limitNights? and startSelected
          maxdate = new Date scope.mgStart.getFullYear(), scope.mgStart.getMonth(), scope.mgStart.getDate() + scope.mgOptions.limitNights
          if maxdate > scope.restrictions.maxdate then maxdate = scope.restrictions.maxdate
        else
          maxdate = scope.restrictions.maxdate
        (mindate? and currentDate < mindate) or (maxdate? and currentDate > maxdate)
      isToday: (day) ->
        #day.toDateString() == new Date().toDateString()
        day.toDateString() == Calendar.getToday().toDateString()
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
          classString += ' selected'
        else if scope.mgEnd? and scope.mgEnd.getTime() is dayObj.getTime()
          classString += ' selected'
        #else if scope.mgStart? and scope.mgEnd? and !startSelected and dayObj > scope.mgStart and dayObj < scope.mgEnd
        else if scope.mgStart? and scope.mgEnd? and dayObj > scope.mgStart and dayObj < scope.mgEnd
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

      select: (nYear, nMonth, nDate) ->
        date = new Date nYear, nMonth-1, nDate
        if Calendar.getToday() > date         # 오늘 날짜 이전 선택이면 return
          return

        # distinguish between tapping a start button and an end button
        if scope.mgButtonName is 'checkout' and scope.mgStart and scope.mgEnd
          if date <= scope.mgStart #체크인 이전을 클릭시엔 체크인을 선택
            scope.mgStart = date
            scope.mgEnd = null
            startSelected = true
            removeCheckInOut()
            drawCheckInCheckOut()
            if scope.mgCallback
              scope.mgCallback('start')
            return

          scope.mgEnd = date
          startSelected = false
          removeCheckInOut()
          drawCheckInCheckOut()
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
            removeCheckOut()
            drawEndDate date, nYear, nMonth, nDate
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

                if scope.mgButtonName == 'checkin' && scope.mgStart != null && scope.mgEnd != null && date < scope.mgEnd
                  scope.mgStart = date
                  startSelected = true
                  removeCheckInOut()
                  drawCheckInCheckOut()
                  if scope.mgCallback
                    scope.mgCallback('start')
                  return $timeout (->
                    scope.mgSelect()
                  ), 300

                scope.mgStart = date
                scope.mgEnd = null
                startSelected = true
                removeCheckInOut()
                drawStartDate date, nYear, nMonth, nDate
                if scope.mgCallback
                  scope.mgCallback('start')

              else                            # 체크인/체크아웃 모두 있고, 체크인 버튼을 눌러서 들어오고, 체크아웃 이전으로 선택하면 실행
                scope.mgStart = date
                removeCheckInOut()
                drawCheckInCheckOut()
                if scope.mgCallback
                  scope.mgCallback('start')

                $timeout (->
                  scope.mgSelect()
                ), 300

            else
              scope.mgEnd = date
              startSelected = false
              removeCheckInOut()
              drawCheckInCheckOut()
              if scope.mgCallback
                scope.mgCallback('end')
              $timeout (->
                scope.mgSelect()
              ), 300

    activate()
  ]
]
