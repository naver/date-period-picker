angular.module('datePeriodPicker').run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('release/datepicker-modal.html',
    "<div id=\"custom-modal\" ng-click=\"close()\" ng-show=\"options.display\"><div id=\"overlay\" ng-click=\"$event.stopPropagation()\"><mg-datepicker mg-start=\"start\" mg-end=\"end\" mg-select=\"close({start:start, end:end})\" mg-button-name=\"buttonName\" mg-options=\"options\"></mg-datepicker></div><div id=\"fade\"></div></div>"
  );


  $templateCache.put('release/mg-datepicker.html',
    "<div class=\"datepicker\"><div ng-repeat=\"month in ::dates\" id=\"{{month.text}}\" class=\"month\"><table cellspacing=\"0\" cellpadding=\"0\" class=\"table\"><div class=\"title\"><div class=\"title_label\">{{month.text}}<thead class=\"header\"><tr><th ng-repeat=\"week in ::weekdays\" ng-class=\"{{week}}\">{{week}}</th></tr></thead></div></div><tbody class=\"body\"><tr ng-repeat=\"week in ::month.weeks\"><td ng-repeat=\"day in ::week track by $index\" ng-class=\"calendar.class(day)\" ng-click=\"calendar.isDisabled(day) || calendar.select(day)\"><div ng-if=\"::day\" class=\"cell\"><div class=\"num\">{{::day | date:'d'}}</div><div ng-show=\"calendar.isStart(day)\" class=\"txt\">{{::calendar.startDayText() || '입실'}}</div><div ng-show=\"!calendar.isStart(day) &amp;&amp; calendar.isEnd(day)\" class=\"txt\">{{::calendar.endDayText() || '퇴실'}}</div><div ng-show=\"!calendar.isStart(day) &amp;&amp; !calendar.isEnd(day) &amp;&amp; calendar.isToday(day)\" class=\"txt\"><div class=\"today\">오늘</div></div></div></td></tr></tbody></table></div></div>"
  );

}]);
