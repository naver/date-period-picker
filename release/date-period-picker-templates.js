angular.module('datePeriodPicker').run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('release/datepicker-modal.html',
    "<div id=\"custom-modal\" ng-click=\"close()\" ng-show=\"options.display\"><div id=\"overlay\" ng-click=\"$event.stopPropagation()\" ng-style=\"options.overlayZIndex\"><mg-datepicker mg-start=\"start\" mg-end=\"end\" mg-select=\"close()\" mg-button-name=\"buttonName\" mg-callback=\"callback\" mg-options=\"options\"></mg-datepicker></div><div id=\"fade\" ng-style=\"options.fadeZIndex\"><a href=\"javascript:;\" class=\"btn_calendar_close\"><span class=\"blind\"> 달력 닫기</span></a></div></div>"
  );


  $templateCache.put('release/mg-datepicker.html',
    "<div class=\"datepicker\"></div>"
  );

}]);
