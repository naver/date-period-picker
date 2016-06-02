angular.module('datePeriodPicker').run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('release/datepicker-modal.html',
    "<div id=\"custom-modal\" ng-click=\"close()\" ng-show=\"options.display\"><div id=\"overlay\" ng-click=\"$event.stopPropagation()\" ng-style=\"options.overlayZIndex\"><mg-datepicker mg-start=\"start\" mg-end=\"end\" mg-select=\"close()\" mg-button-name=\"buttonName\" mg-callback=\"callback\" mg-options=\"options\"></mg-datepicker></div><div id=\"fade\" ng-style=\"options.fadeZIndex\"></div></div>"
  );


  $templateCache.put('release/mg-datepicker.html',
    "<div class=\"datepicker\"></div>"
  );

}]);
