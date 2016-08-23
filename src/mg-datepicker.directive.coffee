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
    if scope.mgOptions.project == 'flights'
      id = null
      monthElement = null
      monthDate = null
      if scope.mgOptions.openButton == 'sdate0'
        monthDate = scope.mgOptions.sdate0
      else if scope.mgOptions.openButton == 'sdate1'
        monthDate = scope.mgOptions.sdate1
      else if scope.mgOptions.openButton == 'sdate2'
        monthDate = scope.mgOptions.sdate2
      if monthDate != null
        id = $filter('date')(monthDate, 'yyyy.MM')
        monthElement = angular.element(document.getElementById(id))
        element.parent()[0].scrollTop = monthElement[0].offsetTop
      return
    if !scope.mgStart? then return
    $timeout () ->  # Scrolling to selected dates
      id = $filter('date')(scope.mgStart, 'yyyy.MM')
      monthElement = angular.element document.getElementById(id)
      element.parent()[0].scrollTop = monthElement[0].offsetTop

  controller: ['$scope', 'ModalService', 'Calendar', '$compile', (scope, ModalService, Calendar, compile) ->
    # set default value
    if not scope.mgOptions.checkInString
      scope.mgOptions.checkInString = 'check in'
    if !scope.mgOptions.checkOutString
      scope.mgOptions.checkOutString = 'check out'

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
            str += '<td id="' + $filter('date')(dateObj, 'yyyyMd') + '" ng-click="calendar.select(' + (if (numClass=="disabled") then "\'disabled\'" else "\'\'") + ','  + $filter('date')(dateObj, 'yyyy,M,d') + ')" class="' + numClass + '">'
            str += '<div class="cell">'
            str += '<div class="num">' + dateObj.getDate() + '</div>'
            if scope.mgOptions.project == 'flights'             # flights
              addStr = ''
              if scope.mgOptions.trip == 'rt' && scope.calendar.isRoundTripSameDate(dateObj)    # 왕복일때 가는날,오는날 같다
                addStr = '<div class="txt txtSame">당일</div>'
              else
                if numClass.indexOf('today') > 0
                  addStr = '<div class="txt txtToday">오늘</div>'
                else
                  if scope.calendar.isSdate0(dateObj)
                    addStr += '<div class="txt txtSdate0">' + scope.mgOptions.sdate0String + '</div>'
                  if scope.calendar.isSdate1(dateObj)
                    addStr += '<div class="txt txtSdate1">' + scope.mgOptions.sdate1String + '</div>'
                  if scope.calendar.isSdate2(dateObj)
                    addStr += '<div class="txt txtSdate2">' + scope.mgOptions.sdate2String + '</div>'
              str += addStr
            else
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
      if scope.mgOptions.limitNights != null    # limitNights 가 설정되어 있으면 전체 다시 그리기로 한다.
        activate()
        return

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
        return

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

    # flights
    drawSelectedFlight = () ->
      options = scope.mgOptions
      elCalendar = document.getElementById('custom-modal')
      today = new Date(Calendar.getToday().getTime()).setHours(0, 0, 0, 0)    # today
      # 1471446000...
      if options.sdate0 != null and options.sdate0.getTime() == today or options.sdate1 != null and options.sdate1.getTime() == today or options.sdate2 != null and options.sdate2.getTime() == today
        angular.element(elCalendar.querySelector('.today')).removeClass 'today'
        angular.element(elCalendar.querySelector('.txtToday')).remove()
      # 당일 삭제
      sameDate = elCalendar.querySelector('.txtSame')
      if sameDate != null
        angular.element(sameDate).remove()
      # 가는날, 오는날, 여정1, 여정2, 여정3 삭제
      elSdate0 = elCalendar.querySelector('.txtSdate0')
      if elSdate0 != null
        angular.element(elSdate0).remove()
      elSdate1 = elCalendar.querySelector('.txtSdate1')
      if elSdate1 != null
        angular.element(elSdate1).remove()
      elSdate2 = elCalendar.querySelector('.txtSdate2')
      if elSdate2 != null
        angular.element(elSdate2).remove()
      # selected 삭제
      selectedArr = elCalendar.querySelectorAll('.selected')
      i = 0
      while i < selectedArr.length
        angular.element(selectedArr[i]).removeClass 'selected'
        i++
      # between-selected 삭제
      betweenArr = elCalendar.querySelectorAll('.between-selected')
      i = 0
      while i < betweenArr.length
        angular.element(betweenArr[i]).removeClass 'between-selected'
        i++
      # 당일 표시(왕복 && 가는날, 오는날이 같을때)
      if options.trip == 'rt' and options.sdate0 != null and options.sdate1 != null and options.sdate0.getTime() == options.sdate1.getTime()
        td = document.getElementById($filter('date')(options.sdate0, 'yyyyMd'))
        angular.element(td).addClass 'selected'
        cell = td.querySelector('.cell')
        angular.element(cell).append '<div class="txt txtSdate0">당일</div>'
      # 당일 아닐때
      else
        # 여정1 표시
        if options.sdate0 != null
          td = document.getElementById($filter('date')(options.sdate0, 'yyyyMd'))
          angular.element(td).addClass 'selected'
          cell = td.querySelector('.cell')
          angular.element(cell).append '<div class="txt txtSdate0">' + scope.mgOptions.sdate0String + '</div>'
        # 여정2 표시
        if options.sdate1 != null
          td = document.getElementById($filter('date')(options.sdate1, 'yyyyMd'))
          angular.element(td).addClass 'selected'
          cell = td.querySelector('.cell')
          angular.element(cell).append '<div class="txt txtSdate1">' + scope.mgOptions.sdate1String + '</div>'
        # 여정3 표시
        if options.sdate2 != null
          td = document.getElementById($filter('date')(options.sdate2, 'yyyyMd'))
          angular.element(td).addClass 'selected'
          cell = td.querySelector('.cell')
          angular.element(cell).append '<div class="txt txtSdate2">' + scope.mgOptions.sdate2String + '</div>'
        # between-selected 표시 (sdate0 ~ sdate1)
        if options.sdate0 != null and options.sdate1 != null and options.sdate0.getTime() != options.sdate1.getTime()
          betweenDate = new Date(options.sdate0.getTime())
          betweenDate.setDate betweenDate.getDate() + 1
          while betweenDate.getTime() < options.sdate1.getTime()
            td = document.getElementById($filter('date')(betweenDate, 'yyyyMd'))
            angular.element(td).addClass 'between-selected'
            betweenDate.setDate betweenDate.getDate() + 1
        # between-selected 표시 (sdate1 ~ sdate2)
        if options.sdate1 != null and options.sdate2 != null and options.sdate1.getTime() != options.sdate2.getTime()
          betweenDate = new Date(options.sdate1.getTime())
          betweenDate.setDate betweenDate.getDate() + 1
          while betweenDate.getTime() < options.sdate2.getTime()
            td = document.getElementById($filter('date')(betweenDate, 'yyyyMd'))
            angular.element(td).addClass 'between-selected'
            betweenDate.setDate betweenDate.getDate() + 1
        # between-selected 표시 (sdate0 ~ sdate2)
        if options.sdate0 != null and options.sdate1 == null and options.sdate2 != null and options.sdate0.getTime() != options.sdate2.getTime()
          betweenDate = new Date(options.sdate0.getTime())
          betweenDate.setDate betweenDate.getDate() + 1
          while betweenDate.getTime() < options.sdate2.getTime()
            td = document.getElementById($filter('date')(betweenDate, 'yyyyMd'))
            angular.element(td).addClass 'between-selected'
            betweenDate.setDate betweenDate.getDate() + 1
      return

    # 공휴일 로드
    if scope.mgOptions.enableKoreanCalendar
      Calendar.load scope.restrictions.mindate, scope.restrictions.maxdate, scope.mgOptions.holidayUrl

    scope.calendar =
      offsetMargin: (date) ->
        new Date(date.getFullYear(), date.getMonth()).getDay() * 2.75 + 'rem'
      isVisible: (date, day) ->
        new Date(date.getFullYear(), date.getMonth(), day).getMonth() is date.getMonth()
      isDisabled: (currentDate) ->
        mindate = scope.restrictions.mindate
        if scope.mgOptions.limitNights? and startSelected
          maxdate = new Date scope.mgStart.getFullYear(), scope.mgStart.getMonth(), scope.mgStart.getDate() + scope.mgOptions.limitNights
          if maxdate > scope.restrictions.maxdate then maxdate = scope.restrictions.maxdate
        else
          maxdate = scope.restrictions.maxdate
        (mindate? and currentDate < mindate) or (maxdate? and currentDate > maxdate)
      isToday: (day) ->
        day.toDateString() == Calendar.getToday().toDateString()
      isStart: (day) ->
        scope.mgStart? and scope.mgStart.getTime() is day.getTime()
      isEnd: (day) ->
        scope.mgEnd? and scope.mgEnd.getTime() is day.getTime()
      isSdate0: (day) ->              # flights
        scope.mgOptions.sdate0 != null && scope.mgOptions.sdate0.getTime() == day.getTime()
      isSdate1: (day) ->              # flights
        scope.mgOptions.sdate1 != null && scope.mgOptions.sdate1.getTime() == day.getTime()
      isSdate2: (day) ->              # flights
        scope.mgOptions.sdate2 != null && scope.mgOptions.sdate2.getTime() == day.getTime()
      isRoundTripSameDate: (day) ->   # flights
        if scope.mgOptions.sdate0 != null && scope.mgOptions.sdate1 != null
          return scope.mgOptions.sdate0.getTime() == day.getTime() && scope.mgOptions.sdate1.getTime() == day.getTime()
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
        # flights
        if scope.mgOptions.project == 'flights'
          options = scope.mgOptions
          if options.sdate0 != null && options.sdate0.getTime() == dayObj.getTime()
            classString += ' selected'
          else if options.sdate1 != null && options.sdate1.getTime() == dayObj.getTime()
            classString += ' selected'
          else if options.sdate2 != null && options.sdate2.getTime() == dayObj.getTime()
            classString += ' selected'
          else if options.sdate0 != null && options.sdate1 != null && dayObj > options.sdate0 && dayObj < options.sdate1    # sdate0 ~ sdate1
            classString = 'between-selected'
          else if options.sdate1 != null && options.sdate2 != null && dayObj > options.sdate1 && dayObj < options.sdate2    # sdate1 ~ sdate2
            classString = 'between-selected'
          else if dayObj.getTime() == new Date().setHours(0, 0, 0, 0)
            classString += ' today'
        else
          if scope.mgStart? and scope.mgStart.getTime() is dayObj.getTime()
            classString += ' selected'
          else if scope.mgEnd? and scope.mgEnd.getTime() is dayObj.getTime()
            classString += ' selected'
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

      select: (isDisabled, nYear, nMonth, nDate) ->
        date = new Date nYear, nMonth-1, nDate
        if isDisabled == 'disabled'         # 비활성이면 return
          return

        # flights
        if typeof scope.mgOptions.project != 'undefined' && scope.mgOptions.project == 'flights'
          today = new Date(Calendar.getToday().getTime()).setHours(0, 0, 0, 0)  # 1471446000...
          if scope.mgOptions.isDomestic == 0 && today == date.getTime()         # 해외이고 오늘 날짜 선택이면 return
            return

          options = scope.mgOptions
          # 편도
          if options.trip == 'ow'
            scope.mgCallback
              trip: 'ow'
              where: 'sdate0'
            options.sdate0 = date
            drawSelectedFlight()
            $timeout (->
              scope.mgSelect()
            ), 300
          # 왕복
          else if options.trip == 'rt'
            scope.mgCallback
              trip: 'rt'
              where: options.openButton
            if options.openButton == 'sdate0'
              if options.sdate1 != null and options.sdate1.getTime() < date.getTime()
                options.sdate1 = null
                options.sdate0 = date
              else
                options.sdate0 = date
            else if scope.mgOptions.openButton == 'sdate1'
              if options.sdate0 != null and options.sdate0.getTime() > date.getTime()
                options.sdate0 = date
                options.sdate1 = null
              else
                options.sdate1 = date

            if options.sdate1 == null
              options.openButton = 'sdate1'
            else
              options.openButton = 'sdate0'
            drawSelectedFlight()
            # 모두 선택했으면 나간다
            if options.sdate0 != null and options.sdate1 != null
              $timeout (->
                scope.mgSelect()
              ), 300
          # 다구간
          else if options.trip == 'md'
            scope.mgCallback
              trip: 'md'
              where: options.openButton
            if options.openButton == 'sdate0'
              options.sdate0 = new Date(date.getTime())
              if options.sdate1 != null and options.sdate1.getTime() < date.getTime()     # sdate1 <
                options.sdate1 = null
              if options.sdate2 != null and options.sdate2.getTime() < date.getTime()     # sdate2 <
                options.sdate1 = null
                options.sdate2 = null
            else if options.openButton == 'sdate1'
              options.sdate1 = new Date(date.getTime())
              if options.sdate0 != null and options.sdate0.getTime() > date.getTime()     # sdate0 >
                options.sdate1 = null
                options.sdate0 = new Date(date.getTime())
              if options.sdate2 != null and options.sdate2.getTime() < date.getTime()     # sdate2 <
                options.sdate2 = null
            else if options.openButton == 'sdate2'
              options.sdate2 = new Date(date.getTime())
              if options.sdate1 != null and options.sdate1.getTime() > date.getTime()     # sdate1 >
                if options.sdate0 != null and options.sdate0.getTime() > date.getTime()   # sdate0 >
                  options.sdate2 = null
                  options.sdate0 = new Date(date.getTime())
                else
                  options.sdate2 = null
                  options.sdate1 = new Date(date.getTime())

            if options.sdate0 == null
              options.openButton = 'sdate0'
            else if options.sdate1 == null
              options.openButton = 'sdate1'
            else if options.sdate2 == null && options.isShowWay3 == true
              options.openButton = 'sdate2'

            drawSelectedFlight()
            # 모두 선택했으면 나간다
            if options.isShowWay3 == true and options.sdate0 != null and options.sdate1 != null and options.sdate2 != null
              $timeout (->
                scope.mgSelect()
              ), 300
            else if options.isShowWay3 == false and options.sdate0 != null and options.sdate1 != null
              $timeout (->
                scope.mgSelect()
              ), 300
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
            drawCheckInCheckOut()
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
                  diffDate = (scope.mgEnd.getTime() - date.getTime()) / (1000 * 60 * 60 * 24)   # 숙박 기간
                  if scope.mgOptions.limitNights && diffDate > scope.mgOptions.limitNights      # 숙박 기간이 limitNights 보다 크면 체크인 설정
                    scope.mgStart = date
                    scope.mgEnd = null
                    startSelected = true
                    removeCheckInOut()
                    drawCheckInCheckOut()
                    if scope.mgCallback
                      return scope.mgCallback('start')

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
                drawCheckInCheckOut()
                if scope.mgCallback
                  scope.mgCallback('start')

              else # 체크인/체크아웃 모두 있고, 체크인 버튼을 눌러서 들어오고, 체크아웃 이전으로 선택하면 실행
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
