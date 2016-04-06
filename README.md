# date-picker
An Angular directive of Scrollable datepicker.

## Overview
A calendar is a widely used component to filter search results.
This directive makes it easier to pick a date period without a whole lot of settings

## Screenshots
![popup_screen_shot](/resource/image/popup-screen-capture.png)


## Usage

1. define options
2. call DatepickerModalService.show
 parameters:
  - startDate: a variable that will be used as startDate
  - endDate: a variable that will be used as endDate
  - callback(eventName): a callback function, which will be called when a date is selected
    receiving callback will receive eventName such as 'start'(for start date selection), 'end'(for start date selection) 
  - datePickerOptions:<br />
    <b>limitNight</b>:  maximum nights that a user can select as a period <br />
    <b>selectableDays</b>: selectable days from today <br />
    (ex: selectableDays:90 means that a user can select any date between today and today + 90 days). <br />
    Visible months are based on this selectable days as well. <br />
    <b></b>
    
###html <br>
```
<a href='javascript:;', ng-click="showDatepicker()">Picke a Date!</a>
```

####javascript<br>
```javascript
    $scope.startDate = null
    $scope.endDate = null
    
    # preload datepicker to make the popup work faster
    DatepickerModalService.preload($scope.startDate, $scope.endDate, datePickerOptions)
    
    var datePickerOptions = {
        enableKoreanCalendar: true,
        limitNights: 13,
        selectableDays: 90
    }
  
    $scope.datepickerCallback = function(eventName) {
        if (eventName === 'start') {
            // start date selected
        } else if (eventName === 'end') {
            // end date selected
        }
    };
    
    
    $scope.showDatepicker = function() {
      $scope.isBottomHidden = true;
      return DatepickerModalService.show($scope.startDate, $scope.endDate, null, datePickerOptions).then(function(result) {
        $scope.startDate = result.start;
        return $scope.endDate = result.end;
      }).then(function() {
        // dates selected
      }, function(err) {
        // modal dismissed
      });
    };
```

## limitation
HTML and CSS files are fixed, and the options are limited.


## License
See [LICENSE](LICENSE) for full license text.

```
Copyright 2016 NAVER Corp.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

## Contact
Please let us know, if you have any questions or suggestions. Also, if you are happy to use this directive, just share us the story so that we can make this component better!
