angular.module('datePeriodPicker').run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('release/datepicker-modal.html',
    "<div id=\"custom-modal\" ng-click=\"close()\" ng-show=\"options.display\"><div id=\"overlay\" ng-click=\"$event.stopPropagation()\" ng-style=\"options.overlayZIndex\"><mg-datepicker mg-start=\"start\" mg-end=\"end\" mg-select=\"close()\" mg-button-name=\"buttonName\" mg-callback=\"callback\" mg-options=\"options\"></mg-datepicker></div><div id=\"fade\" ng-style=\"options.fadeZIndex\"></div></div>"
  );


  $templateCache.put('release/mg-datepicker.html',
    "<div class=\"datepicker\"><!--.month(ng-repeat=\"month in ::dates\", id=\"{{month.text}}\")--><!--  table.table(cellspacing='0', cellpadding='0')--><!--    .title--><!--      .title_label {{month.text}}--><!--        thead.header--><!--          tr--><!--            th(ng-repeat=\"week in ::weekdays\" ng-class=\"{{week}}\") {{week}}--><!--    tbody.body--><!--      tr(ng-repeat=\"week in ::month.weeks\")--><!--        td(ng-repeat=\"day in ::week track by $index\" ng-class= \"calendar.class(day)\" ng-click=\"calendar.isDisabled(day) || calendar.select(day)\")--><!--          .cell(ng-if='::day')--><!--            .num {{::day | date:'d'}}--><!--            .txt(ng-show=\"calendar.isStart(day)\") {{::calendar.startDayText() || '입실'}}--><!--            .txt(ng-show=\"!calendar.isStart(day) && calendar.isEnd(day)\") {{::calendar.endDayText() || '퇴실'}}--><!--            .txt(ng-show=\"!calendar.isStart(day) && !calendar.isEnd(day) && calendar.isToday(day)\")--><!--              .today 오늘--></div>"
  );

}]);
