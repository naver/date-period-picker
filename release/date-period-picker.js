(function() {
  'use strict';
  angular.module('datePeriodPicker', []);

}).call(this);

(function() {
  'use strict';
  var app;

  app = angular.module('datePeriodPicker');

  app.service('Calendar', [
    '$http', '$filter', function($http, $filter) {
      var holidays, loadHolidaySuccess, todayDate;
      todayDate = new Date();
      loadHolidaySuccess = false;
      holidays = {
        "2016-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2016-03-05 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2016-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2016-03-20 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2016-04-04 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2016-04-05 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2016-04-13 00:00:00": {
          "name": "20대 국회의원선거",
          "type": "holiday"
        },
        "2016-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2016-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2016-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2016-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2016-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2016-05-14 00:00:00": {
          "name": "석가탄신일",
          "type": "holiday"
        },
        "2016-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2016-05-20 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2016-06-05 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2016-06-06 00:00:00": {
          "name": "현충일",
          "type": "holiday"
        },
        "2016-06-09 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2016-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2016-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2016-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2016-07-17 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2016-07-22 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2016-07-27 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2016-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2016-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2016-08-16 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2016-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2016-09-07 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2016-09-14 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2016-09-15 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2016-09-16 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2016-09-22 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2016-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2016-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2016-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2016-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2016-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2016-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2016-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2016-12-21 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2016-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2017-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2017-01-05 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2017-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2017-01-27 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2017-01-28 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2017-01-29 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2017-01-30 00:00:00": {
          "name": "대체공휴일(설날)",
          "type": "holiday"
        },
        "2017-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2017-02-11 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2017-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2017-02-18 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2017-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2017-03-05 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2017-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2017-03-20 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2017-04-04 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2017-04-05 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2017-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2017-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2017-05-03 00:00:00": {
          "name": "석가탄신일",
          "type": "holiday"
        },
        "2017-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2017-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2017-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2017-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2017-05-21 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2017-05-30 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2017-06-05 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2017-06-06 00:00:00": {
          "name": "현충일",
          "type": "holiday"
        },
        "2017-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2017-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2017-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2017-07-12 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2017-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2017-07-22 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2017-07-23 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2017-08-01 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2017-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2017-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2017-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2017-09-07 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2017-09-23 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2017-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2017-10-04 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2017-10-05 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2017-10-06 00:00:00": {
          "name": "대체공휴일(추석)",
          "type": "holiday"
        },
        "2017-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2017-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2017-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2017-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2017-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2017-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2017-12-20 00:00:00": {
          "name": "19대 대통령선거",
          "type": "holiday"
        },
        "2017-12-22 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2017-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2018-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2018-01-05 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2018-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2018-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2018-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2018-02-15 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2018-02-16 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2018-02-17 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2018-02-19 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2018-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2018-03-02 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2018-03-06 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2018-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2018-03-21 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2018-04-05 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2018-04-06 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2018-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2018-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2018-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2018-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2018-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2018-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2018-05-21 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2018-05-22 00:00:00": {
          "name": "석가탄신일",
          "type": "holiday"
        },
        "2018-06-06 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2018-06-13 00:00:00": {
          "name": "2018 지방선거",
          "type": "holiday"
        },
        "2018-06-18 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2018-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2018-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2018-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2018-07-17 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2018-07-23 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2018-07-27 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2018-08-06 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2018-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2018-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2018-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2018-09-08 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2018-09-23 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2018-09-24 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2018-09-25 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2018-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2018-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2018-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2018-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2018-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2018-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2018-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2018-12-22 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2018-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2019-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2019-01-06 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2019-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2019-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2019-02-05 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2019-02-06 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2019-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2019-02-19 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2019-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2019-03-06 00:00:00": {
          "name": "조합장선거",
          "type": "solarterms"
        },
        "2019-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2019-03-21 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2019-04-05 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2019-04-06 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2019-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2019-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2019-05-05 00:00:00": {
          "name": "어린이날",
          "type": "holiday"
        },
        "2019-05-06 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2019-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2019-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2019-05-12 00:00:00": {
          "name": "석가탄신일",
          "type": "holiday"
        },
        "2019-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2019-05-21 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2019-06-06 00:00:00": {
          "name": "현충일",
          "type": "holiday"
        },
        "2019-06-07 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2019-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2019-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2019-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2019-07-23 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2019-08-08 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2019-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2019-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2019-09-08 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2019-09-12 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2019-09-13 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2019-09-14 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2019-09-23 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2019-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2019-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2019-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2019-10-24 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2019-11-08 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2019-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2019-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2019-12-22 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2019-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2020-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2020-01-06 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2020-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2020-01-24 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2020-01-25 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2020-01-26 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2020-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2020-02-08 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2020-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2020-02-19 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2020-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2020-03-05 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2020-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2020-03-20 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2020-04-04 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2020-04-05 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2020-04-15 00:00:00": {
          "name": "21대 국회의원선거",
          "type": "holiday"
        },
        "2020-04-19 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2020-04-30 00:00:00": {
          "name": "석가탄신일",
          "type": "holiday"
        },
        "2020-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2020-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2020-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2020-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2020-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2020-05-20 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2020-06-05 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2020-06-06 00:00:00": {
          "name": "현충일",
          "type": "holiday"
        },
        "2020-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2020-06-25 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2020-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2020-07-16 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2020-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2020-07-22 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2020-07-26 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2020-08-05 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2020-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2020-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2020-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2020-09-07 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2020-09-22 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2020-09-30 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2020-10-01 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2020-10-02 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2020-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2020-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2020-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2020-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2020-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2020-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2020-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2020-12-21 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2020-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2021-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2021-01-05 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2021-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2021-02-03 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2021-02-11 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2021-02-12 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2021-02-13 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2021-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2021-02-18 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2021-02-26 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2021-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2021-03-05 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2021-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2021-03-20 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2021-04-04 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2021-04-05 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2021-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2021-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2021-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2021-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2021-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2021-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2021-05-19 00:00:00": {
          "name": "석가탄신일",
          "type": "holiday"
        },
        "2021-05-21 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2021-06-05 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2021-06-06 00:00:00": {
          "name": "현충일",
          "type": "holiday"
        },
        "2021-06-14 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2021-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2021-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2021-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2021-07-11 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2021-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2021-07-21 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2021-07-22 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2021-07-31 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2021-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2021-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2021-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2021-09-07 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2021-09-20 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2021-09-21 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2021-09-22 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2021-09-23 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2021-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2021-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2021-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2021-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2021-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2021-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2021-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2021-12-22 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2021-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2022-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2022-01-05 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2022-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2022-01-31 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2022-02-01 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2022-02-02 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2022-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2022-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2022-02-15 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2022-02-19 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2022-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2022-03-05 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2022-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2022-03-21 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2022-04-05 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2022-04-06 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2022-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2022-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2022-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2022-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2022-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2022-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2022-05-21 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2022-06-01 00:00:00": {
          "name": "2022 지방선거",
          "type": "holiday"
        },
        "2022-06-03 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2022-06-06 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2022-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2022-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2022-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2022-07-16 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2022-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2022-07-23 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2022-07-26 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2022-08-05 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2022-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2022-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2022-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2022-09-08 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2022-09-09 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2022-09-10 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2022-09-11 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2022-09-23 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2022-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2022-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2022-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2022-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2022-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2022-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2022-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2022-12-21 00:00:00": {
          "name": "20대 대통령선거",
          "type": "holiday"
        },
        "2022-12-22 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2022-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2023-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2023-01-05 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2023-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2023-01-21 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2023-01-22 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2023-01-23 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2023-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2023-02-05 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2023-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2023-02-19 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2023-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2023-03-06 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2023-03-08 00:00:00": {
          "name": "조합장선거",
          "type": "solarterms"
        },
        "2023-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2023-03-21 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2023-04-05 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2023-04-06 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2023-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2023-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2023-05-05 00:00:00": {
          "name": "어린이날",
          "type": "holiday"
        },
        "2023-05-06 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2023-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2023-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2023-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2023-05-21 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2023-05-27 00:00:00": {
          "name": "석가탄신일",
          "type": "holiday"
        },
        "2023-06-06 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2023-06-22 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2023-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2023-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2023-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2023-07-21 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2023-07-23 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2023-07-31 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2023-08-08 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2023-08-10 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2023-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2023-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2023-09-08 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2023-09-23 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2023-09-28 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2023-09-29 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2023-09-30 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2023-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2023-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2023-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2023-10-24 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2023-11-08 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2023-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2023-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2023-12-22 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2023-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2024-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2024-01-06 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2024-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2024-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2024-02-09 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2024-02-10 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2024-02-11 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2024-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2024-02-19 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2024-02-24 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2024-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2024-03-05 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2024-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2024-03-20 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2024-04-04 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2024-04-05 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2024-04-10 00:00:00": {
          "name": "22대 국회의원선거",
          "type": "holiday"
        },
        "2024-04-19 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2024-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2024-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2024-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2024-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2024-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2024-05-20 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2024-06-05 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2024-06-06 00:00:00": {
          "name": "현충일",
          "type": "holiday"
        },
        "2024-06-10 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2024-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2024-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2024-07-06 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2024-07-15 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2024-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2024-07-22 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2024-07-25 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2024-08-04 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2024-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2024-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2024-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2024-09-07 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2024-09-16 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2024-09-17 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2024-09-18 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2024-09-22 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2024-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2024-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2024-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2024-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2024-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2024-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2024-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2024-12-21 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2024-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2025-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2025-01-05 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2025-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2025-01-28 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2025-01-29 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2025-01-30 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2025-02-03 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2025-02-12 00:00:00": {
          "name": "정월 대보름",
          "type": "solarterms"
        },
        "2025-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2025-02-18 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2025-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        },
        "2025-03-05 00:00:00": {
          "name": "경칩",
          "type": "solarterms"
        },
        "2025-03-14 00:00:00": {
          "name": "화이트데이",
          "type": "etc"
        },
        "2025-03-20 00:00:00": {
          "name": "춘분",
          "type": "solarterms"
        },
        "2025-04-04 00:00:00": {
          "name": "청명",
          "type": "solarterms"
        },
        "2025-04-05 00:00:00": {
          "name": "한식",
          "type": "solarterms"
        },
        "2025-04-20 00:00:00": {
          "name": "곡우",
          "type": "solarterms"
        },
        "2025-05-01 00:00:00": {
          "name": "근로자의날",
          "type": "national"
        },
        "2025-05-05 00:00:00": {
          "name": "입하",
          "type": "solarterms"
        },
        "2025-05-08 00:00:00": {
          "name": "어버이날",
          "type": "national"
        },
        "2025-05-10 00:00:00": {
          "name": "유권자의날",
          "type": "national"
        },
        "2025-05-15 00:00:00": {
          "name": "스승의날",
          "type": "national"
        },
        "2025-05-21 00:00:00": {
          "name": "소만",
          "type": "solarterms"
        },
        "2025-05-31 00:00:00": {
          "name": "단오",
          "type": "solarterms"
        },
        "2025-06-05 00:00:00": {
          "name": "망종",
          "type": "solarterms"
        },
        "2025-06-06 00:00:00": {
          "name": "현충일",
          "type": "holiday"
        },
        "2025-06-21 00:00:00": {
          "name": "하지",
          "type": "solarterms"
        },
        "2025-06-25 00:00:00": {
          "name": "6.25 한국 전쟁",
          "type": "national"
        },
        "2025-07-07 00:00:00": {
          "name": "소서",
          "type": "solarterms"
        },
        "2025-07-17 00:00:00": {
          "name": "제헌절",
          "type": "national"
        },
        "2025-07-20 00:00:00": {
          "name": "초복",
          "type": "solarterms"
        },
        "2025-07-22 00:00:00": {
          "name": "대서",
          "type": "solarterms"
        },
        "2025-07-30 00:00:00": {
          "name": "중복",
          "type": "solarterms"
        },
        "2025-08-07 00:00:00": {
          "name": "입추",
          "type": "solarterms"
        },
        "2025-08-09 00:00:00": {
          "name": "말복",
          "type": "solarterms"
        },
        "2025-08-15 00:00:00": {
          "name": "광복절",
          "type": "holiday"
        },
        "2025-08-23 00:00:00": {
          "name": "처서",
          "type": "solarterms"
        },
        "2025-09-07 00:00:00": {
          "name": "백로",
          "type": "solarterms"
        },
        "2025-09-23 00:00:00": {
          "name": "추분",
          "type": "solarterms"
        },
        "2025-10-03 00:00:00": {
          "name": "개천절",
          "type": "holiday"
        },
        "2025-10-05 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2025-10-06 00:00:00": {
          "name": "추석",
          "type": "holiday"
        },
        "2025-10-07 00:00:00": {
          "name": "추석",
          "type": "consecutive"
        },
        "2025-10-08 00:00:00": {
          "name": "한로",
          "type": "solarterms"
        },
        "2025-10-09 00:00:00": {
          "name": "한글날",
          "type": "holiday"
        },
        "2025-10-23 00:00:00": {
          "name": "상강",
          "type": "solarterms"
        },
        "2025-11-07 00:00:00": {
          "name": "입동",
          "type": "solarterms"
        },
        "2025-11-22 00:00:00": {
          "name": "소설",
          "type": "solarterms"
        },
        "2025-12-07 00:00:00": {
          "name": "대설",
          "type": "solarterms"
        },
        "2025-12-21 00:00:00": {
          "name": "동지",
          "type": "solarterms"
        },
        "2025-12-25 00:00:00": {
          "name": "성탄절",
          "type": "holiday"
        },
        "2026-01-01 00:00:00": {
          "name": "새해 첫날",
          "type": "holiday"
        },
        "2026-01-05 00:00:00": {
          "name": "소한",
          "type": "solarterms"
        },
        "2026-01-20 00:00:00": {
          "name": "대한",
          "type": "solarterms"
        },
        "2026-02-04 00:00:00": {
          "name": "입춘",
          "type": "solarterms"
        },
        "2026-02-14 00:00:00": {
          "name": "밸런타인데이",
          "type": "etc"
        },
        "2026-02-16 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2026-02-17 00:00:00": {
          "name": "설날",
          "type": "holiday"
        },
        "2026-02-18 00:00:00": {
          "name": "설날",
          "type": "consecutive"
        },
        "2026-02-19 00:00:00": {
          "name": "우수",
          "type": "solarterms"
        },
        "2026-03-01 00:00:00": {
          "name": "삼일절",
          "type": "holiday"
        }
      };
      return {
        load: function(mindate, maxdate, url) {
          if (loadHolidaySuccess) {
            return;
          }
          if (url) {
            return $http({
              method: 'GET',
              url: url,
              params: {
                startDate: $filter('date')(mindate, 'yyyy-MM-dd'),
                endDate: $filter('date')(maxdate, 'yyyy-MM-dd')
              }
            }).then(function(o) {
              loadHolidaySuccess = true;
              return holidays = o.data;
            });
          }
        },
        isHoliday: function(date) {
          var dateString;
          if (date && holidays) {
            dateString = $filter('date')(date, 'yyyy-MM-dd 00:00:00');
            if (holidays[dateString] && (holidays[dateString].type === 'holiday' || holidays[dateString].type === 'consecutive')) {
              return true;
            }
          }
          return false;
        },
        getToday: function() {
          return todayDate;
        },
        setToday: function(d) {
          return todayDate = d;
        },
        setHoliday: function(h) {
          holidays = h;
          return loadHolidaySuccess = true;
        }
      };
    }
  ]);

}).call(this);

(function() {
  'use strict';
  var app;

  app = angular.module('datePeriodPicker');

  app.controller('DatepickerModalController', [
    '$scope', 'close', 'start', 'end', 'buttonName', 'callback', 'options', function($scope, close, start, end, buttonName, callback, options) {
      if (start != null) {
        $scope.start = new Date(start.getTime());
      }
      if (end != null) {
        $scope.end = new Date(end.getTime());
      }
      if (buttonName != null) {
        $scope.buttonName = buttonName;
      }
      if (callback != null) {
        $scope.callback = callback;
      }
      $scope.options = options;
      $scope.close = function() {
        $scope.callback('close');
        if (options.project === 'flights') {
          return close({
            trip: $scope.options.trip,
            sdate0: $scope.options.sdate0,
            sdate1: $scope.options.sdate1,
            sdate2: $scope.options.sdate2
          });
        } else {
          return close({
            start: $scope.start,
            end: $scope.end
          });
        }
      };
      if (!options.display) {
        close(null, 200);
      }
      return $scope.$on('$locationChangeStart', function(event, next, current) {
        if (options.display === 1) {
          $scope.callback('close');
          return close();
        }
      });
    }
  ]);

}).call(this);

(function() {
  'use strict';
  var app;

  app = angular.module('datePeriodPicker');

  app.service('DatepickerModalService', [
    'ModalService', '$q', function(ModalService, $q) {
      return {
        preload: function(start, end, options) {
          options.display = 0;
          return ModalService.showModal({
            templateUrl: 'release/datepicker-modal.html',
            controller: 'DatepickerModalController',
            inputs: {
              start: start,
              end: end,
              buttonName: null,
              callback: null,
              options: options
            }
          });
        },
        showModal: function(start, end, buttonName, callback, options) {
          var deferred;
          options.display = 1;
          deferred = $q.defer();
          ModalService.showModal({
            templateUrl: 'release/datepicker-modal.html',
            controller: 'DatepickerModalController',
            inputs: {
              start: start,
              end: end,
              buttonName: buttonName,
              callback: callback,
              options: options
            }
          }).then(function(modal) {
            return modal.close.then(function(result) {
              if (result) {
                return deferred.resolve(result);
              } else {
                return deferred.reject();
              }
            });
          });
          return deferred.promise;
        },
        show: function(start, end, callback, options) {
          return this.showModal(start, end, null, callback, options);
        },
        checkin: function(start, end, options) {
          return this.showModal(start, end, 'checkin', callback, options);
        },
        checkout: function(start, end, options) {
          return this.showModal(start, end, 'checkout', callback, options);
        }
      };
    }
  ]);

}).call(this);

(function() {
  'use strict';
  var app;

  app = angular.module('datePeriodPicker');

  app.directive('mgDatepicker', [
    '$timeout', '$filter', function($timeout, $filter) {
      return {
        restrict: 'AE',
        replace: true,
        scope: {
          mgOptions: '=',
          mgStart: '=',
          mgEnd: '=',
          mgButtonName: '=',
          mgCallback: '=',
          mgSelect: '&'
        },
        templateUrl: function(tElement, tAttrs) {
          return "release/mg-datepicker.html";
        },
        link: function(scope, element, attrs) {
          var id, monthDate, monthElement;
          if (scope.mgOptions.project === 'flights') {
            id = null;
            monthElement = null;
            monthDate = null;
            if (scope.mgOptions.openButton === 'sdate0') {
              monthDate = scope.mgOptions.sdate0;
            } else if (scope.mgOptions.openButton === 'sdate1') {
              monthDate = scope.mgOptions.sdate1;
            } else if (scope.mgOptions.openButton === 'sdate2') {
              monthDate = scope.mgOptions.sdate2;
            }
            if (monthDate !== null) {
              id = $filter('date')(monthDate, 'yyyy.MM');
              monthElement = angular.element(document.getElementById(id));
              element.parent()[0].scrollTop = monthElement[0].offsetTop;
            }
            return;
          }
          if (scope.mgStart == null) {
            return;
          }
          return $timeout(function() {
            id = $filter('date')(scope.mgStart, 'yyyy.MM');
            monthElement = angular.element(document.getElementById(id));
            return element.parent()[0].scrollTop = monthElement[0].offsetTop;
          });
        },
        controller: [
          '$scope', 'ModalService', 'Calendar', '$compile', function(scope, ModalService, Calendar, compile) {
            var activate, date, drawCalendar, drawCheckInCheckOut, drawEndDate, drawSelectedFlight, drawStartDate, getMonthHtml, months, nEnabledTimeLength, ref, ref1, ref2, removeCheckInOut, removeCheckOut, startSelected, weeksInMonth;
            if (!scope.mgOptions.checkInString) {
              scope.mgOptions.checkInString = 'check in';
            }
            if (!scope.mgOptions.checkOutString) {
              scope.mgOptions.checkOutString = 'check out';
            }
            scope.weekdays = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
            startSelected = false;
            if (scope.mgOptions.mgPenTodaysDeal || (scope.mgStart && scope.mgButtonName === 'checkout')) {
              startSelected = true;
            }
            scope.restrictions = {
              mindate: new Date(),
              maxdate: new Date()
            };
            if (((ref = scope.mgOptions) != null ? ref.selectableDays : void 0) != null) {
              nEnabledTimeLength = (1000 * 60 * 60 * 24) * (scope.mgOptions.selectableDays - 1);
              scope.restrictions.maxdate.setTime(scope.restrictions.maxdate.getTime() + nEnabledTimeLength);
            } else {
              scope.restrictions.maxdate.setMonth(scope.restrictions.mindate.getMonth() + 12);
            }
            if (((ref1 = scope.mgOptions) != null ? ref1.mindate : void 0) != null) {
              scope.restrictions.mindate = new Date(scope.mgOptions.mindate);
            }
            if (((ref2 = scope.mgOptions) != null ? ref2.maxdate : void 0) != null) {
              scope.restrictions.maxdate = new Date(scope.mgOptions.maxdate);
            } else {

            }
            scope.restrictions.mindate.setHours(0, 0, 0, 0);
            scope.restrictions.maxdate.setHours(23, 59, 59, 999);
            months = [];
            date = new Date(scope.restrictions.mindate.getTime());
            date.setHours(0, 0, 0, 0);
            date.setDate(1);
            while (date <= scope.restrictions.maxdate) {
              months.push(new Date(date.getTime()));
              date.setMonth(date.getMonth() + 1);
            }
            weeksInMonth = function(month) {
              var day, each, j, newDay, ref3, week, weeks;
              weeks = [];
              day = new Date(month);
              while (day.getMonth() === month.getMonth()) {
                newDay = new Date(day);
                if (!week) {
                  week = [];
                  for (each = j = 1, ref3 = day.getDay(); j <= ref3; each = j += 1) {
                    week.push(null);
                  }
                }
                if (day.getDay() === 6 || (new Date(day.getYear(), day.getMonth() + 1, 0)).getDate() === day.getDate()) {
                  week.push(newDay);
                  weeks.push(week);
                  week = [];
                } else {
                  week.push(newDay);
                }
                day.setDate(day.getDate() + 1);
              }
              return weeks;
            };
            activate = function() {
              var arrayMonths, j, len, monthStart;
              scope.dates = [];
              arrayMonths = [];
              for (j = 0, len = months.length; j < len; j++) {
                monthStart = months[j];
                arrayMonths.push({
                  monthText: $filter('date')(monthStart, 'yyyy.MM'),
                  weeks: weeksInMonth(monthStart)
                });
              }
              return drawCalendar(arrayMonths);
            };
            drawCalendar = function(arrayMonths) {
              var calendarHtml, elCompile, elCon, elCustom, j, len, month, welCon;
              calendarHtml = '';
              for (j = 0, len = arrayMonths.length; j < len; j++) {
                month = arrayMonths[j];
                calendarHtml += getMonthHtml(month);
              }
              elCustom = document.getElementById('custom-modal');
              elCon = elCustom.querySelector('.datepicker');
              welCon = angular.element(elCon);
              elCompile = compile(calendarHtml)(scope);
              welCon.html('');
              return welCon.append(elCompile);
            };
            getMonthHtml = function(obj) {
              var addStr, dateArr, dateObj, j, k, len, len1, monthText, numClass, str, week, weeks;
              weeks = obj.weeks;
              monthText = obj.monthText;
              str = '';
              str += '<div class="month" id="' + monthText + '">';
              str += '<div class="title"><div class="title_label">' + monthText + '</div></div>';
              str += '<table cellspacing="0" cellpadding="0" class="table">';
              str += '<thead class="header"><tr><th>SUN</th><th>MON</th><th>TUE</th><th>WED</th><th>THU</th><th>FRI</th><th>SAT</th></tr></thead>';
              str += '<tbody class="body">';
              for (j = 0, len = weeks.length; j < len; j++) {
                week = weeks[j];
                dateArr = week;
                str += '<tr>';
                for (k = 0, len1 = dateArr.length; k < len1; k++) {
                  dateObj = dateArr[k];
                  if (dateObj === null) {
                    str += '<td><div class="cell"><div class="num"></div></div></td>';
                  } else {
                    numClass = scope.calendar["class"](dateObj);
                    str += '<td id="' + $filter('date')(dateObj, 'yyyyMd') + '" ng-click="calendar.select(' + (numClass === "disabled" ? "\'disabled\'" : "\'\'") + ',' + $filter('date')(dateObj, 'yyyy,M,d') + ')" class="' + numClass + '">';
                    str += '<div class="cell">';
                    str += '<div class="num">' + dateObj.getDate() + '</div>';
                    if (scope.mgOptions.project === 'flights') {
                      addStr = '';
                      if (scope.mgOptions.trip === 'rt' && scope.calendar.isRoundTripSameDate(dateObj)) {
                        addStr = '<div class="txt txtSame">당일</div>';
                      } else {
                        if (numClass.indexOf('today') !== -1) {
                          addStr = '<div class="txt txtToday">오늘</div>';
                        } else {
                          if (scope.calendar.isSdate0(dateObj)) {
                            addStr += '<div class="txt txtSdate0">' + scope.mgOptions.sdate0String + '</div>';
                          }
                          if (scope.calendar.isSdate1(dateObj)) {
                            addStr += '<div class="txt txtSdate1">' + scope.mgOptions.sdate1String + '</div>';
                          }
                          if (scope.calendar.isSdate2(dateObj)) {
                            addStr += '<div class="txt txtSdate2">' + scope.mgOptions.sdate2String + '</div>';
                          }
                        }
                      }
                      str += addStr;
                    } else {
                      if (numClass.indexOf('today') !== -1) {
                        str += '<div class="txt txtToday">오늘</div>';
                      }
                      if (scope.calendar.isStart(dateObj)) {
                        str += '<div class="txt txtCheckIn">' + scope.mgOptions.checkInString + '</div>';
                      }
                      if (scope.calendar.isEnd(dateObj)) {
                        str += '<div class="txt txtCheckOut">' + scope.mgOptions.checkOutString + '</div>';
                      }
                    }
                    str += '</div></td>';
                  }
                }
                str += '</tr>';
              }
              str += '</tbody></table></div>';
              return str;
            };
            drawCheckInCheckOut = function() {
              var beDate, elTd;
              if (scope.mgOptions.limitNights !== null) {
                activate();
                return;
              }
              if (scope.mgStart !== null) {
                drawStartDate(scope.mgStart, scope.mgStart.getFullYear(), scope.mgStart.getMonth() + 1, scope.mgStart.getDate());
              }
              if (scope.mgEnd !== null) {
                drawEndDate(scope.mgEnd, scope.mgEnd.getFullYear(), scope.mgEnd.getMonth() + 1, scope.mgEnd.getDate());
              }
              if (scope.mgStart !== null && scope.mgEnd !== null) {
                beDate = new Date(scope.mgStart.getFullYear(), scope.mgStart.getMonth(), scope.mgStart.getDate());
                beDate.setDate(beDate.getDate() + 1);
                while (beDate < scope.mgEnd) {
                  elTd = document.getElementById($filter('date')(beDate, 'yyyyMd'));
                  angular.element(elTd).addClass('between-selected');
                  beDate.setDate(beDate.getDate() + 1);
                }
              }
            };
            drawStartDate = function(date, nYear, nMonth, nDate) {
              var cell, elCustom, elToday, elTodayStr, td, todayId;
              td = document.getElementById(nYear + '' + nMonth + '' + nDate);
              angular.element(td).addClass('selected');
              cell = td.querySelector('.cell');
              angular.element(cell).append('<div class="txt txtCheckIn">' + scope.mgOptions.checkInString + '</div>');
              elCustom = document.getElementById('custom-modal');
              if (scope.calendar.isToday(date)) {
                elTodayStr = elCustom.querySelector('.txtToday');
                if (typeof elTodayStr !== 'undefined') {
                  angular.element(elTodayStr).remove();
                }
                elToday = elCustom.querySelector('.today');
                if (typeof elToday !== 'undefined') {
                  return angular.element(elToday).removeClass('today');
                }
              } else {
                todayId = $filter('date')(Calendar.getToday(), 'yyyyMd');
                td = document.getElementById(todayId);
                if (td.querySelector('.txtToday') === null) {
                  angular.element(td).addClass('today');
                  return angular.element(td.querySelector('.cell')).append('<div class="txt txtToday">오늘</div>');
                }
              }
            };
            drawEndDate = function(date, nYear, nMonth, nDate) {
              var cell, td;
              td = document.getElementById(nYear + '' + nMonth + '' + nDate);
              angular.element(td).addClass('selected');
              cell = td.querySelector('.cell');
              return angular.element(cell).append('<div class="txt txtCheckOut">' + scope.mgOptions.checkOutString + '</div>');
            };
            removeCheckOut = function() {
              var arrBetween, arrSelect, checkoutSelected, elBetween, elCheckOut, elCustom, j, len, results;
              elCustom = document.getElementById('custom-modal');
              elCheckOut = elCustom.querySelector('.txtCheckOut');
              if (typeof elCheckOut !== 'undefined') {
                angular.element(elCheckOut).remove();
              }
              arrSelect = elCustom.querySelectorAll('.selected');
              if (0 < arrSelect.length) {
                checkoutSelected = arrSelect[arrSelect.length - 1];
                angular.element(checkoutSelected).removeClass('selected');
              }
              arrBetween = elCustom.querySelectorAll('.between-selected');
              results = [];
              for (j = 0, len = arrBetween.length; j < len; j++) {
                elBetween = arrBetween[j];
                results.push(angular.element(elBetween).removeClass('between-selected'));
              }
              return results;
            };
            removeCheckInOut = function() {
              var arrBetween, arrSelect, elBetween, elCheckIn, elCheckOut, elCustom, elSelect, j, k, len, len1, results;
              elCustom = document.getElementById('custom-modal');
              elCheckIn = elCustom.querySelector('.txtCheckIn');
              if (typeof elCheckIn !== 'undefined') {
                angular.element(elCheckIn).remove();
              }
              elCheckOut = elCustom.querySelector('.txtCheckOut');
              if (typeof elCheckOut !== 'undefined') {
                angular.element(elCheckOut).remove();
              }
              arrSelect = elCustom.querySelectorAll('.selected');
              for (j = 0, len = arrSelect.length; j < len; j++) {
                elSelect = arrSelect[j];
                angular.element(elSelect).removeClass('selected');
              }
              arrBetween = elCustom.querySelectorAll('.between-selected');
              results = [];
              for (k = 0, len1 = arrBetween.length; k < len1; k++) {
                elBetween = arrBetween[k];
                results.push(angular.element(elBetween).removeClass('between-selected'));
              }
              return results;
            };
            drawSelectedFlight = function() {
              var betweenArr, betweenDate, cell, elCalendar, elSdate0, elSdate1, elSdate2, i, options, sameDate, selectedArr, td, today;
              options = scope.mgOptions;
              elCalendar = document.getElementById('custom-modal');
              today = new Date(Calendar.getToday().getTime()).setHours(0, 0, 0, 0);
              if (options.sdate0 !== null && options.sdate0.getTime() === today || options.sdate1 !== null && options.sdate1.getTime() === today || options.sdate2 !== null && options.sdate2.getTime() === today) {
                angular.element(elCalendar.querySelector('.today')).removeClass('today');
                angular.element(elCalendar.querySelector('.txtToday')).remove();
              }
              sameDate = elCalendar.querySelector('.txtSame');
              if (sameDate !== null) {
                angular.element(sameDate).remove();
              }
              elSdate0 = elCalendar.querySelector('.txtSdate0');
              if (elSdate0 !== null) {
                angular.element(elSdate0).remove();
              }
              elSdate1 = elCalendar.querySelector('.txtSdate1');
              if (elSdate1 !== null) {
                angular.element(elSdate1).remove();
              }
              elSdate2 = elCalendar.querySelector('.txtSdate2');
              if (elSdate2 !== null) {
                angular.element(elSdate2).remove();
              }
              selectedArr = elCalendar.querySelectorAll('.selected');
              i = 0;
              while (i < selectedArr.length) {
                angular.element(selectedArr[i]).removeClass('selected');
                i++;
              }
              betweenArr = elCalendar.querySelectorAll('.between-selected');
              i = 0;
              while (i < betweenArr.length) {
                angular.element(betweenArr[i]).removeClass('between-selected');
                i++;
              }
              if (options.trip === 'rt' && options.sdate0 !== null && options.sdate1 !== null && options.sdate0.getTime() === options.sdate1.getTime()) {
                td = document.getElementById($filter('date')(options.sdate0, 'yyyyMd'));
                angular.element(td).addClass('selected');
                cell = td.querySelector('.cell');
                angular.element(cell).append('<div class="txt txtSdate0">당일</div>');
              } else {
                if (options.sdate0 !== null) {
                  td = document.getElementById($filter('date')(options.sdate0, 'yyyyMd'));
                  angular.element(td).addClass('selected');
                  cell = td.querySelector('.cell');
                  angular.element(cell).append('<div class="txt txtSdate0">' + scope.mgOptions.sdate0String + '</div>');
                }
                if (options.sdate1 !== null) {
                  td = document.getElementById($filter('date')(options.sdate1, 'yyyyMd'));
                  angular.element(td).addClass('selected');
                  cell = td.querySelector('.cell');
                  angular.element(cell).append('<div class="txt txtSdate1">' + scope.mgOptions.sdate1String + '</div>');
                }
                if (options.sdate2 !== null) {
                  td = document.getElementById($filter('date')(options.sdate2, 'yyyyMd'));
                  angular.element(td).addClass('selected');
                  cell = td.querySelector('.cell');
                  angular.element(cell).append('<div class="txt txtSdate2">' + scope.mgOptions.sdate2String + '</div>');
                }
                if (options.sdate0 !== null && options.sdate1 !== null && options.sdate0.getTime() !== options.sdate1.getTime()) {
                  betweenDate = new Date(options.sdate0.getTime());
                  betweenDate.setDate(betweenDate.getDate() + 1);
                  while (betweenDate.getTime() < options.sdate1.getTime()) {
                    td = document.getElementById($filter('date')(betweenDate, 'yyyyMd'));
                    angular.element(td).addClass('between-selected');
                    betweenDate.setDate(betweenDate.getDate() + 1);
                  }
                }
                if (options.sdate1 !== null && options.sdate2 !== null && options.sdate1.getTime() !== options.sdate2.getTime()) {
                  betweenDate = new Date(options.sdate1.getTime());
                  betweenDate.setDate(betweenDate.getDate() + 1);
                  while (betweenDate.getTime() < options.sdate2.getTime()) {
                    td = document.getElementById($filter('date')(betweenDate, 'yyyyMd'));
                    angular.element(td).addClass('between-selected');
                    betweenDate.setDate(betweenDate.getDate() + 1);
                  }
                }
                if (options.sdate0 !== null && options.sdate1 === null && options.sdate2 !== null && options.sdate0.getTime() !== options.sdate2.getTime()) {
                  betweenDate = new Date(options.sdate0.getTime());
                  betweenDate.setDate(betweenDate.getDate() + 1);
                  while (betweenDate.getTime() < options.sdate2.getTime()) {
                    td = document.getElementById($filter('date')(betweenDate, 'yyyyMd'));
                    angular.element(td).addClass('between-selected');
                    betweenDate.setDate(betweenDate.getDate() + 1);
                  }
                }
              }
            };
            if (scope.mgOptions.enableKoreanCalendar) {
              Calendar.load(scope.restrictions.mindate, scope.restrictions.maxdate, scope.mgOptions.holidayUrl);
            }
            scope.calendar = {
              offsetMargin: function(date) {
                return new Date(date.getFullYear(), date.getMonth()).getDay() * 2.75 + 'rem';
              },
              isVisible: function(date, day) {
                return new Date(date.getFullYear(), date.getMonth(), day).getMonth() === date.getMonth();
              },
              isDisabled: function(currentDate) {
                var maxdate, mindate;
                mindate = scope.restrictions.mindate;
                if ((scope.mgOptions.limitNights != null) && startSelected) {
                  maxdate = new Date(scope.mgStart.getFullYear(), scope.mgStart.getMonth(), scope.mgStart.getDate() + scope.mgOptions.limitNights);
                  if (maxdate > scope.restrictions.maxdate) {
                    maxdate = scope.restrictions.maxdate;
                  }
                } else {
                  maxdate = scope.restrictions.maxdate;
                }
                return ((mindate != null) && currentDate < mindate) || ((maxdate != null) && currentDate > maxdate);
              },
              isToday: function(day) {
                return day.toDateString() === Calendar.getToday().toDateString();
              },
              isStart: function(day) {
                return (scope.mgStart != null) && scope.mgStart.getTime() === day.getTime();
              },
              isEnd: function(day) {
                return (scope.mgEnd != null) && scope.mgEnd.getTime() === day.getTime();
              },
              isSdate0: function(day) {
                return scope.mgOptions.sdate0 !== null && scope.mgOptions.sdate0.getTime() === day.getTime();
              },
              isSdate1: function(day) {
                return scope.mgOptions.sdate1 !== null && scope.mgOptions.sdate1.getTime() === day.getTime();
              },
              isSdate2: function(day) {
                return scope.mgOptions.sdate2 !== null && scope.mgOptions.sdate2.getTime() === day.getTime();
              },
              isRoundTripSameDate: function(day) {
                if (scope.mgOptions.sdate0 !== null && scope.mgOptions.sdate1 !== null) {
                  return scope.mgOptions.sdate0.getTime() === day.getTime() && scope.mgOptions.sdate1.getTime() === day.getTime();
                }
              },
              "class": function(day) {
                var classString, dayObj, options;
                classString = '';
                dayObj = new Date(day);
                if (this.isDisabled(dayObj)) {
                  classString = 'disabled';
                } else if (scope.mgOptions.enableKoreanCalendar && Calendar.isHoliday(dayObj)) {
                  classString = 'holiday';
                } else {
                  if (dayObj.getDay() === 0) {
                    classString = 'sunday';
                  } else if (dayObj.getDay() === 6) {
                    classString = 'saturday';
                  }
                }
                if (scope.mgOptions.project === 'flights') {
                  options = scope.mgOptions;
                  if (options.sdate0 !== null && options.sdate0.getTime() === dayObj.getTime()) {
                    classString += ' selected';
                  } else if (options.sdate1 !== null && options.sdate1.getTime() === dayObj.getTime()) {
                    classString += ' selected';
                  } else if (options.sdate2 !== null && options.sdate2.getTime() === dayObj.getTime()) {
                    classString += ' selected';
                  } else if (options.sdate0 !== null && options.sdate1 !== null && dayObj > options.sdate0 && dayObj < options.sdate1) {
                    classString = 'between-selected';
                  } else if (options.sdate1 !== null && options.sdate2 !== null && dayObj > options.sdate1 && dayObj < options.sdate2) {
                    classString = 'between-selected';
                  } else if (dayObj.getTime() === new Date().setHours(0, 0, 0, 0)) {
                    classString = 'today';
                  }
                } else {
                  if ((scope.mgStart != null) && scope.mgStart.getTime() === dayObj.getTime()) {
                    classString += ' selected';
                  } else if ((scope.mgEnd != null) && scope.mgEnd.getTime() === dayObj.getTime()) {
                    classString += ' selected';
                  } else if ((scope.mgStart != null) && (scope.mgEnd != null) && dayObj > scope.mgStart && dayObj < scope.mgEnd) {
                    classString = 'between-selected';
                  } else if (scope.mgOptions.today != null) {
                    if (dayObj.getTime() === scope.mgOptions.today.setHours(0, 0, 0, 0)) {
                      classString = 'today';
                    }
                  } else if (dayObj.getTime() === new Date().setHours(0, 0, 0, 0)) {
                    classString = 'today';
                  }
                }
                return classString;
              },
              startDayText: function() {
                if (scope.mgOptions.startDateText) {
                  return scope.startDateText;
                }
              },
              endDayText: function() {
                if (scope.mgOptions.endDateText) {
                  return scope.endDateText;
                }
              },
              select: function(isDisabled, nYear, nMonth, nDate) {
                var diffDate, options, startLimit, today;
                date = new Date(nYear, nMonth - 1, nDate);
                if (isDisabled === 'disabled') {
                  return;
                }
                if (typeof scope.mgOptions.project !== 'undefined' && scope.mgOptions.project === 'flights') {
                  today = new Date(Calendar.getToday().getTime()).setHours(0, 0, 0, 0);
                  if (scope.mgOptions.isDomestic === 0 && today === date.getTime()) {
                    return;
                  }
                  options = scope.mgOptions;
                  if (options.trip === 'ow') {
                    scope.mgCallback({
                      trip: 'ow',
                      where: 'sdate0'
                    });
                    options.sdate0 = date;
                    drawSelectedFlight();
                    $timeout((function() {
                      return scope.mgSelect();
                    }), 300);
                  } else if (options.trip === 'rt') {
                    scope.mgCallback({
                      trip: 'rt',
                      where: options.openButton
                    });
                    if (options.openButton === 'sdate0') {
                      if (options.sdate1 !== null && options.sdate1.getTime() < date.getTime()) {
                        options.sdate1 = null;
                        options.sdate0 = date;
                      } else {
                        options.sdate0 = date;
                      }
                    } else if (scope.mgOptions.openButton === 'sdate1') {
                      if (options.sdate0 !== null && options.sdate0.getTime() > date.getTime()) {
                        options.sdate0 = date;
                        options.sdate1 = null;
                      } else {
                        options.sdate1 = date;
                      }
                    }
                    if (options.sdate1 === null) {
                      options.openButton = 'sdate1';
                    } else {
                      options.openButton = 'sdate0';
                    }
                    drawSelectedFlight();
                    if (options.sdate0 !== null && options.sdate1 !== null) {
                      $timeout((function() {
                        return scope.mgSelect();
                      }), 300);
                    }
                  } else if (options.trip === 'md') {
                    scope.mgCallback({
                      trip: 'md',
                      where: options.openButton
                    });
                    if (options.openButton === 'sdate0') {
                      options.sdate0 = new Date(date.getTime());
                      if (options.sdate1 !== null && options.sdate1.getTime() < date.getTime()) {
                        options.sdate1 = null;
                      }
                      if (options.sdate2 !== null && options.sdate2.getTime() < date.getTime()) {
                        options.sdate1 = null;
                        options.sdate2 = null;
                      }
                    } else if (options.openButton === 'sdate1') {
                      options.sdate1 = new Date(date.getTime());
                      if (options.sdate0 !== null && options.sdate0.getTime() > date.getTime()) {
                        options.sdate1 = null;
                        options.sdate0 = new Date(date.getTime());
                      }
                      if (options.sdate2 !== null && options.sdate2.getTime() < date.getTime()) {
                        options.sdate2 = null;
                      }
                    } else if (options.openButton === 'sdate2') {
                      options.sdate2 = new Date(date.getTime());
                      if (options.sdate1 !== null && options.sdate1.getTime() > date.getTime()) {
                        if (options.sdate0 !== null && options.sdate0.getTime() > date.getTime()) {
                          options.sdate2 = null;
                          options.sdate1 = null;
                          options.sdate0 = new Date(date.getTime());
                        } else {
                          options.sdate2 = null;
                          options.sdate1 = new Date(date.getTime());
                        }
                      }
                    }
                    if (options.sdate0 === null) {
                      options.openButton = 'sdate0';
                    } else if (options.sdate1 === null) {
                      options.openButton = 'sdate1';
                    } else if (options.sdate2 === null && options.isShowWay3 === true) {
                      options.openButton = 'sdate2';
                    }
                    drawSelectedFlight();
                    if (options.isShowWay3 === true && options.sdate0 !== null && options.sdate1 !== null && options.sdate2 !== null) {
                      $timeout((function() {
                        return scope.mgSelect();
                      }), 300);
                    } else if (options.isShowWay3 === false && options.sdate0 !== null && options.sdate1 !== null) {
                      $timeout((function() {
                        return scope.mgSelect();
                      }), 300);
                    }
                  }
                  return;
                }
                if (scope.mgButtonName === 'checkout' && scope.mgStart && scope.mgEnd) {
                  if (date <= scope.mgStart) {
                    scope.mgStart = date;
                    scope.mgEnd = null;
                    startSelected = true;
                    removeCheckInOut();
                    drawCheckInCheckOut();
                    if (scope.mgCallback) {
                      scope.mgCallback('start');
                    }
                    return;
                  }
                  scope.mgEnd = date;
                  startSelected = false;
                  removeCheckInOut();
                  drawCheckInCheckOut();
                  if (scope.mgCallback) {
                    scope.mgCallback('end');
                  }
                  return $timeout((function() {
                    return scope.mgSelect();
                  }), 300);
                } else {
                  if (scope.mgOptions.mgPenTodaysDeal) {
                    scope.mgEnd = date;
                    removeCheckOut();
                    drawCheckInCheckOut();
                    if (scope.mgCallback) {
                      scope.mgCallback('end');
                    }
                    return $timeout((function() {
                      return scope.mgSelect();
                    }), 300);
                  } else {
                    scope.mgEnd = null;
                    startLimit = new Date(scope.mgEnd);
                    startLimit.setDate(startLimit.getDate() - scope.mgOptions.limitNights);
                    if (!startSelected || (startSelected && date <= scope.mgStart)) {
                      if (!scope.mgButtonName || !scope.mgEnd || scope.mgEnd <= date || date < startLimit) {
                        if (scope.mgButtonName === 'checkin' && scope.mgStart !== null && scope.mgEnd !== null && date < scope.mgEnd) {
                          diffDate = (scope.mgEnd.getTime() - date.getTime()) / (1000 * 60 * 60 * 24);
                          if (scope.mgOptions.limitNights && diffDate > scope.mgOptions.limitNights) {
                            scope.mgStart = date;
                            scope.mgEnd = null;
                            startSelected = true;
                            removeCheckInOut();
                            drawCheckInCheckOut();
                            if (scope.mgCallback) {
                              return scope.mgCallback('start');
                            }
                          }
                          scope.mgStart = date;
                          startSelected = true;
                          removeCheckInOut();
                          drawCheckInCheckOut();
                          if (scope.mgCallback) {
                            scope.mgCallback('start');
                          }
                          return $timeout((function() {
                            return scope.mgSelect();
                          }), 300);
                        }
                        scope.mgStart = date;
                        scope.mgEnd = null;
                        startSelected = true;
                        removeCheckInOut();
                        drawCheckInCheckOut();
                        if (scope.mgCallback) {
                          return scope.mgCallback('start');
                        }
                      } else {
                        scope.mgStart = date;
                        removeCheckInOut();
                        drawCheckInCheckOut();
                        if (scope.mgCallback) {
                          scope.mgCallback('start');
                        }
                        return $timeout((function() {
                          return scope.mgSelect();
                        }), 300);
                      }
                    } else {
                      scope.mgEnd = date;
                      startSelected = false;
                      removeCheckInOut();
                      drawCheckInCheckOut();
                      if (scope.mgCallback) {
                        scope.mgCallback('end');
                      }
                      return $timeout((function() {
                        return scope.mgSelect();
                      }), 300);
                    }
                  }
                }
              }
            };
            return activate();
          }
        ]
      };
    }
  ]);

}).call(this);
