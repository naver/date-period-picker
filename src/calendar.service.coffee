'use strict'

app = angular.module 'datePeriodPicker'
app.service 'Calendar', ['$http', '$filter', ($http, $filter) ->
  # Get holidays
  holidays = null
  
  load: (mindate, maxdate, url) ->
    if holidays then return

    if url # specify a custom url
      $http(
        method: 'GET'
        url: url
        params: {
          startDate: $filter('date') mindate, 'yyyy-MM-dd'
          endDate: $filter('date') maxdate, 'yyyy-MM-dd'
        }
      ).then (o) ->
        if o.data? && o.data.today? then o.data.today = new Date(o.data.today) else o.data.today = new Date() # string 을 date 객체로 변환
        holidays = o.data

    else # use the default korean holiday data (2016-03-01 ~ 2026-02-29). It was generated on 2016-02-29
      holidays = { "2016-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2016-03-05 00:00:00":{"name":"경칩","type":"solarterms"},"2016-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2016-03-20 00:00:00":{"name":"춘분","type":"solarterms"},"2016-04-04 00:00:00":{"name":"청명","type":"solarterms"},"2016-04-05 00:00:00":{"name":"한식","type":"solarterms"},"2016-04-13 00:00:00":{"name":"20대 국회의원선거","type":"holiday"},"2016-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2016-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2016-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2016-05-08 00:00:00":{"name":"어버이날","type":"national"},"2016-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2016-05-14 00:00:00":{"name":"석가탄신일","type":"holiday"},"2016-05-15 00:00:00":{"name":"스승의날","type":"national"},"2016-05-20 00:00:00":{"name":"소만","type":"solarterms"},"2016-06-05 00:00:00":{"name":"망종","type":"solarterms"},"2016-06-06 00:00:00":{"name":"현충일","type":"holiday"},"2016-06-09 00:00:00":{"name":"단오","type":"solarterms"},"2016-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2016-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2016-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2016-07-17 00:00:00":{"name":"초복","type":"solarterms"},"2016-07-22 00:00:00":{"name":"대서","type":"solarterms"},"2016-07-27 00:00:00":{"name":"중복","type":"solarterms"},"2016-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2016-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2016-08-16 00:00:00":{"name":"말복","type":"solarterms"},"2016-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2016-09-07 00:00:00":{"name":"백로","type":"solarterms"},"2016-09-14 00:00:00":{"name":"추석","type":"consecutive"},"2016-09-15 00:00:00":{"name":"추석","type":"holiday"},"2016-09-16 00:00:00":{"name":"추석","type":"consecutive"},"2016-09-22 00:00:00":{"name":"추분","type":"solarterms"},"2016-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2016-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2016-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2016-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2016-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2016-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2016-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2016-12-21 00:00:00":{"name":"동지","type":"solarterms"},"2016-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2017-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2017-01-05 00:00:00":{"name":"소한","type":"solarterms"},"2017-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2017-01-27 00:00:00":{"name":"설날","type":"consecutive"},"2017-01-28 00:00:00":{"name":"설날","type":"holiday"},"2017-01-29 00:00:00":{"name":"설날","type":"consecutive"},"2017-01-30 00:00:00":{"name":"대체공휴일(설날)","type":"holiday"},"2017-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2017-02-11 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2017-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2017-02-18 00:00:00":{"name":"우수","type":"solarterms"},"2017-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2017-03-05 00:00:00":{"name":"경칩","type":"solarterms"},"2017-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2017-03-20 00:00:00":{"name":"춘분","type":"solarterms"},"2017-04-04 00:00:00":{"name":"청명","type":"solarterms"},"2017-04-05 00:00:00":{"name":"한식","type":"solarterms"},"2017-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2017-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2017-05-03 00:00:00":{"name":"석가탄신일","type":"holiday"},"2017-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2017-05-08 00:00:00":{"name":"어버이날","type":"national"},"2017-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2017-05-15 00:00:00":{"name":"스승의날","type":"national"},"2017-05-21 00:00:00":{"name":"소만","type":"solarterms"},"2017-05-30 00:00:00":{"name":"단오","type":"solarterms"},"2017-06-05 00:00:00":{"name":"망종","type":"solarterms"},"2017-06-06 00:00:00":{"name":"현충일","type":"holiday"},"2017-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2017-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2017-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2017-07-12 00:00:00":{"name":"초복","type":"solarterms"},"2017-07-17 00:00:00":{"name":"제헌절","type":"national"},"2017-07-22 00:00:00":{"name":"중복","type":"solarterms"},"2017-07-23 00:00:00":{"name":"대서","type":"solarterms"},"2017-08-01 00:00:00":{"name":"말복","type":"solarterms"},"2017-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2017-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2017-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2017-09-07 00:00:00":{"name":"백로","type":"solarterms"},"2017-09-23 00:00:00":{"name":"추분","type":"solarterms"},"2017-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2017-10-04 00:00:00":{"name":"추석","type":"holiday"},"2017-10-05 00:00:00":{"name":"추석","type":"consecutive"},"2017-10-06 00:00:00":{"name":"대체공휴일(추석)","type":"holiday"},"2017-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2017-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2017-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2017-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2017-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2017-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2017-12-20 00:00:00":{"name":"19대 대통령선거","type":"holiday"},"2017-12-22 00:00:00":{"name":"동지","type":"solarterms"},"2017-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2018-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2018-01-05 00:00:00":{"name":"소한","type":"solarterms"},"2018-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2018-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2018-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2018-02-15 00:00:00":{"name":"설날","type":"consecutive"},"2018-02-16 00:00:00":{"name":"설날","type":"holiday"},"2018-02-17 00:00:00":{"name":"설날","type":"consecutive"},"2018-02-19 00:00:00":{"name":"우수","type":"solarterms"},"2018-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2018-03-02 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2018-03-06 00:00:00":{"name":"경칩","type":"solarterms"},"2018-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2018-03-21 00:00:00":{"name":"춘분","type":"solarterms"},"2018-04-05 00:00:00":{"name":"청명","type":"solarterms"},"2018-04-06 00:00:00":{"name":"한식","type":"solarterms"},"2018-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2018-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2018-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2018-05-08 00:00:00":{"name":"어버이날","type":"national"},"2018-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2018-05-15 00:00:00":{"name":"스승의날","type":"national"},"2018-05-21 00:00:00":{"name":"소만","type":"solarterms"},"2018-05-22 00:00:00":{"name":"석가탄신일","type":"holiday"},"2018-06-06 00:00:00":{"name":"망종","type":"solarterms"},"2018-06-13 00:00:00":{"name":"2018 지방선거","type":"holiday"},"2018-06-18 00:00:00":{"name":"단오","type":"solarterms"},"2018-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2018-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2018-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2018-07-17 00:00:00":{"name":"초복","type":"solarterms"},"2018-07-23 00:00:00":{"name":"대서","type":"solarterms"},"2018-07-27 00:00:00":{"name":"중복","type":"solarterms"},"2018-08-06 00:00:00":{"name":"말복","type":"solarterms"},"2018-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2018-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2018-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2018-09-08 00:00:00":{"name":"백로","type":"solarterms"},"2018-09-23 00:00:00":{"name":"추분","type":"solarterms"},"2018-09-24 00:00:00":{"name":"추석","type":"holiday"},"2018-09-25 00:00:00":{"name":"추석","type":"consecutive"},"2018-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2018-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2018-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2018-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2018-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2018-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2018-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2018-12-22 00:00:00":{"name":"동지","type":"solarterms"},"2018-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2019-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2019-01-06 00:00:00":{"name":"소한","type":"solarterms"},"2019-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2019-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2019-02-05 00:00:00":{"name":"설날","type":"holiday"},"2019-02-06 00:00:00":{"name":"설날","type":"consecutive"},"2019-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2019-02-19 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2019-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2019-03-06 00:00:00":{"name":"조합장선거","type":"solarterms"},"2019-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2019-03-21 00:00:00":{"name":"춘분","type":"solarterms"},"2019-04-05 00:00:00":{"name":"청명","type":"solarterms"},"2019-04-06 00:00:00":{"name":"한식","type":"solarterms"},"2019-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2019-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2019-05-05 00:00:00":{"name":"어린이날","type":"holiday"},"2019-05-06 00:00:00":{"name":"입하","type":"solarterms"},"2019-05-08 00:00:00":{"name":"어버이날","type":"national"},"2019-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2019-05-12 00:00:00":{"name":"석가탄신일","type":"holiday"},"2019-05-15 00:00:00":{"name":"스승의날","type":"national"},"2019-05-21 00:00:00":{"name":"소만","type":"solarterms"},"2019-06-06 00:00:00":{"name":"현충일","type":"holiday"},"2019-06-07 00:00:00":{"name":"단오","type":"solarterms"},"2019-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2019-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2019-07-17 00:00:00":{"name":"제헌절","type":"national"},"2019-07-23 00:00:00":{"name":"대서","type":"solarterms"},"2019-08-08 00:00:00":{"name":"입추","type":"solarterms"},"2019-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2019-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2019-09-08 00:00:00":{"name":"백로","type":"solarterms"},"2019-09-12 00:00:00":{"name":"추석","type":"consecutive"},"2019-09-13 00:00:00":{"name":"추석","type":"holiday"},"2019-09-14 00:00:00":{"name":"추석","type":"consecutive"},"2019-09-23 00:00:00":{"name":"추분","type":"solarterms"},"2019-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2019-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2019-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2019-10-24 00:00:00":{"name":"상강","type":"solarterms"},"2019-11-08 00:00:00":{"name":"입동","type":"solarterms"},"2019-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2019-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2019-12-22 00:00:00":{"name":"동지","type":"solarterms"},"2019-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2020-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2020-01-06 00:00:00":{"name":"소한","type":"solarterms"},"2020-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2020-01-24 00:00:00":{"name":"설날","type":"consecutive"},"2020-01-25 00:00:00":{"name":"설날","type":"holiday"},"2020-01-26 00:00:00":{"name":"설날","type":"consecutive"},"2020-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2020-02-08 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2020-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2020-02-19 00:00:00":{"name":"우수","type":"solarterms"},"2020-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2020-03-05 00:00:00":{"name":"경칩","type":"solarterms"},"2020-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2020-03-20 00:00:00":{"name":"춘분","type":"solarterms"},"2020-04-04 00:00:00":{"name":"청명","type":"solarterms"},"2020-04-05 00:00:00":{"name":"한식","type":"solarterms"},"2020-04-15 00:00:00":{"name":"21대 국회의원선거","type":"holiday"},"2020-04-19 00:00:00":{"name":"곡우","type":"solarterms"},"2020-04-30 00:00:00":{"name":"석가탄신일","type":"holiday"},"2020-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2020-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2020-05-08 00:00:00":{"name":"어버이날","type":"national"},"2020-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2020-05-15 00:00:00":{"name":"스승의날","type":"national"},"2020-05-20 00:00:00":{"name":"소만","type":"solarterms"},"2020-06-05 00:00:00":{"name":"망종","type":"solarterms"},"2020-06-06 00:00:00":{"name":"현충일","type":"holiday"},"2020-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2020-06-25 00:00:00":{"name":"단오","type":"solarterms"},"2020-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2020-07-16 00:00:00":{"name":"초복","type":"solarterms"},"2020-07-17 00:00:00":{"name":"제헌절","type":"national"},"2020-07-22 00:00:00":{"name":"대서","type":"solarterms"},"2020-07-26 00:00:00":{"name":"중복","type":"solarterms"},"2020-08-05 00:00:00":{"name":"말복","type":"solarterms"},"2020-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2020-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2020-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2020-09-07 00:00:00":{"name":"백로","type":"solarterms"},"2020-09-22 00:00:00":{"name":"추분","type":"solarterms"},"2020-09-30 00:00:00":{"name":"추석","type":"consecutive"},"2020-10-01 00:00:00":{"name":"추석","type":"holiday"},"2020-10-02 00:00:00":{"name":"추석","type":"consecutive"},"2020-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2020-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2020-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2020-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2020-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2020-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2020-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2020-12-21 00:00:00":{"name":"동지","type":"solarterms"},"2020-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2021-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2021-01-05 00:00:00":{"name":"소한","type":"solarterms"},"2021-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2021-02-03 00:00:00":{"name":"입춘","type":"solarterms"},"2021-02-11 00:00:00":{"name":"설날","type":"consecutive"},"2021-02-12 00:00:00":{"name":"설날","type":"holiday"},"2021-02-13 00:00:00":{"name":"설날","type":"consecutive"},"2021-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2021-02-18 00:00:00":{"name":"우수","type":"solarterms"},"2021-02-26 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2021-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2021-03-05 00:00:00":{"name":"경칩","type":"solarterms"},"2021-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2021-03-20 00:00:00":{"name":"춘분","type":"solarterms"},"2021-04-04 00:00:00":{"name":"청명","type":"solarterms"},"2021-04-05 00:00:00":{"name":"한식","type":"solarterms"},"2021-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2021-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2021-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2021-05-08 00:00:00":{"name":"어버이날","type":"national"},"2021-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2021-05-15 00:00:00":{"name":"스승의날","type":"national"},"2021-05-19 00:00:00":{"name":"석가탄신일","type":"holiday"},"2021-05-21 00:00:00":{"name":"소만","type":"solarterms"},"2021-06-05 00:00:00":{"name":"망종","type":"solarterms"},"2021-06-06 00:00:00":{"name":"현충일","type":"holiday"},"2021-06-14 00:00:00":{"name":"단오","type":"solarterms"},"2021-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2021-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2021-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2021-07-11 00:00:00":{"name":"초복","type":"solarterms"},"2021-07-17 00:00:00":{"name":"제헌절","type":"national"},"2021-07-21 00:00:00":{"name":"중복","type":"solarterms"},"2021-07-22 00:00:00":{"name":"대서","type":"solarterms"},"2021-07-31 00:00:00":{"name":"말복","type":"solarterms"},"2021-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2021-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2021-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2021-09-07 00:00:00":{"name":"백로","type":"solarterms"},"2021-09-20 00:00:00":{"name":"추석","type":"consecutive"},"2021-09-21 00:00:00":{"name":"추석","type":"holiday"},"2021-09-22 00:00:00":{"name":"추석","type":"consecutive"},"2021-09-23 00:00:00":{"name":"추분","type":"solarterms"},"2021-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2021-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2021-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2021-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2021-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2021-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2021-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2021-12-22 00:00:00":{"name":"동지","type":"solarterms"},"2021-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2022-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2022-01-05 00:00:00":{"name":"소한","type":"solarterms"},"2022-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2022-01-31 00:00:00":{"name":"설날","type":"consecutive"},"2022-02-01 00:00:00":{"name":"설날","type":"holiday"},"2022-02-02 00:00:00":{"name":"설날","type":"consecutive"},"2022-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2022-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2022-02-15 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2022-02-19 00:00:00":{"name":"우수","type":"solarterms"},"2022-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2022-03-05 00:00:00":{"name":"경칩","type":"solarterms"},"2022-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2022-03-21 00:00:00":{"name":"춘분","type":"solarterms"},"2022-04-05 00:00:00":{"name":"청명","type":"solarterms"},"2022-04-06 00:00:00":{"name":"한식","type":"solarterms"},"2022-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2022-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2022-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2022-05-08 00:00:00":{"name":"어버이날","type":"national"},"2022-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2022-05-15 00:00:00":{"name":"스승의날","type":"national"},"2022-05-21 00:00:00":{"name":"소만","type":"solarterms"},"2022-06-01 00:00:00":{"name":"2022 지방선거","type":"holiday"},"2022-06-03 00:00:00":{"name":"단오","type":"solarterms"},"2022-06-06 00:00:00":{"name":"망종","type":"solarterms"},"2022-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2022-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2022-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2022-07-16 00:00:00":{"name":"초복","type":"solarterms"},"2022-07-17 00:00:00":{"name":"제헌절","type":"national"},"2022-07-23 00:00:00":{"name":"대서","type":"solarterms"},"2022-07-26 00:00:00":{"name":"중복","type":"solarterms"},"2022-08-05 00:00:00":{"name":"말복","type":"solarterms"},"2022-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2022-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2022-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2022-09-08 00:00:00":{"name":"백로","type":"solarterms"},"2022-09-09 00:00:00":{"name":"추석","type":"consecutive"},"2022-09-10 00:00:00":{"name":"추석","type":"holiday"},"2022-09-11 00:00:00":{"name":"추석","type":"consecutive"},"2022-09-23 00:00:00":{"name":"추분","type":"solarterms"},"2022-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2022-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2022-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2022-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2022-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2022-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2022-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2022-12-21 00:00:00":{"name":"20대 대통령선거","type":"holiday"},"2022-12-22 00:00:00":{"name":"동지","type":"solarterms"},"2022-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2023-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2023-01-05 00:00:00":{"name":"소한","type":"solarterms"},"2023-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2023-01-21 00:00:00":{"name":"설날","type":"consecutive"},"2023-01-22 00:00:00":{"name":"설날","type":"holiday"},"2023-01-23 00:00:00":{"name":"설날","type":"consecutive"},"2023-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2023-02-05 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2023-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2023-02-19 00:00:00":{"name":"우수","type":"solarterms"},"2023-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2023-03-06 00:00:00":{"name":"경칩","type":"solarterms"},"2023-03-08 00:00:00":{"name":"조합장선거","type":"solarterms"},"2023-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2023-03-21 00:00:00":{"name":"춘분","type":"solarterms"},"2023-04-05 00:00:00":{"name":"청명","type":"solarterms"},"2023-04-06 00:00:00":{"name":"한식","type":"solarterms"},"2023-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2023-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2023-05-05 00:00:00":{"name":"어린이날","type":"holiday"},"2023-05-06 00:00:00":{"name":"입하","type":"solarterms"},"2023-05-08 00:00:00":{"name":"어버이날","type":"national"},"2023-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2023-05-15 00:00:00":{"name":"스승의날","type":"national"},"2023-05-21 00:00:00":{"name":"소만","type":"solarterms"},"2023-05-27 00:00:00":{"name":"석가탄신일","type":"holiday"},"2023-06-06 00:00:00":{"name":"망종","type":"solarterms"},"2023-06-22 00:00:00":{"name":"단오","type":"solarterms"},"2023-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2023-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2023-07-17 00:00:00":{"name":"제헌절","type":"national"},"2023-07-21 00:00:00":{"name":"초복","type":"solarterms"},"2023-07-23 00:00:00":{"name":"대서","type":"solarterms"},"2023-07-31 00:00:00":{"name":"중복","type":"solarterms"},"2023-08-08 00:00:00":{"name":"입추","type":"solarterms"},"2023-08-10 00:00:00":{"name":"말복","type":"solarterms"},"2023-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2023-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2023-09-08 00:00:00":{"name":"백로","type":"solarterms"},"2023-09-23 00:00:00":{"name":"추분","type":"solarterms"},"2023-09-28 00:00:00":{"name":"추석","type":"consecutive"},"2023-09-29 00:00:00":{"name":"추석","type":"holiday"},"2023-09-30 00:00:00":{"name":"추석","type":"consecutive"},"2023-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2023-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2023-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2023-10-24 00:00:00":{"name":"상강","type":"solarterms"},"2023-11-08 00:00:00":{"name":"입동","type":"solarterms"},"2023-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2023-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2023-12-22 00:00:00":{"name":"동지","type":"solarterms"},"2023-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2024-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2024-01-06 00:00:00":{"name":"소한","type":"solarterms"},"2024-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2024-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2024-02-09 00:00:00":{"name":"설날","type":"consecutive"},"2024-02-10 00:00:00":{"name":"설날","type":"holiday"},"2024-02-11 00:00:00":{"name":"설날","type":"consecutive"},"2024-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2024-02-19 00:00:00":{"name":"우수","type":"solarterms"},"2024-02-24 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2024-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2024-03-05 00:00:00":{"name":"경칩","type":"solarterms"},"2024-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2024-03-20 00:00:00":{"name":"춘분","type":"solarterms"},"2024-04-04 00:00:00":{"name":"청명","type":"solarterms"},"2024-04-05 00:00:00":{"name":"한식","type":"solarterms"},"2024-04-10 00:00:00":{"name":"22대 국회의원선거","type":"holiday"},"2024-04-19 00:00:00":{"name":"곡우","type":"solarterms"},"2024-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2024-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2024-05-08 00:00:00":{"name":"어버이날","type":"national"},"2024-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2024-05-15 00:00:00":{"name":"스승의날","type":"national"},"2024-05-20 00:00:00":{"name":"소만","type":"solarterms"},"2024-06-05 00:00:00":{"name":"망종","type":"solarterms"},"2024-06-06 00:00:00":{"name":"현충일","type":"holiday"},"2024-06-10 00:00:00":{"name":"단오","type":"solarterms"},"2024-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2024-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2024-07-06 00:00:00":{"name":"소서","type":"solarterms"},"2024-07-15 00:00:00":{"name":"초복","type":"solarterms"},"2024-07-17 00:00:00":{"name":"제헌절","type":"national"},"2024-07-22 00:00:00":{"name":"대서","type":"solarterms"},"2024-07-25 00:00:00":{"name":"중복","type":"solarterms"},"2024-08-04 00:00:00":{"name":"말복","type":"solarterms"},"2024-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2024-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2024-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2024-09-07 00:00:00":{"name":"백로","type":"solarterms"},"2024-09-16 00:00:00":{"name":"추석","type":"consecutive"},"2024-09-17 00:00:00":{"name":"추석","type":"holiday"},"2024-09-18 00:00:00":{"name":"추석","type":"consecutive"},"2024-09-22 00:00:00":{"name":"추분","type":"solarterms"},"2024-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2024-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2024-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2024-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2024-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2024-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2024-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2024-12-21 00:00:00":{"name":"동지","type":"solarterms"},"2024-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2025-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2025-01-05 00:00:00":{"name":"소한","type":"solarterms"},"2025-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2025-01-28 00:00:00":{"name":"설날","type":"consecutive"},"2025-01-29 00:00:00":{"name":"설날","type":"holiday"},"2025-01-30 00:00:00":{"name":"설날","type":"consecutive"},"2025-02-03 00:00:00":{"name":"입춘","type":"solarterms"},"2025-02-12 00:00:00":{"name":"정월 대보름","type":"solarterms"},"2025-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2025-02-18 00:00:00":{"name":"우수","type":"solarterms"},"2025-03-01 00:00:00":{"name":"삼일절","type":"holiday"},"2025-03-05 00:00:00":{"name":"경칩","type":"solarterms"},"2025-03-14 00:00:00":{"name":"화이트데이","type":"etc"},"2025-03-20 00:00:00":{"name":"춘분","type":"solarterms"},"2025-04-04 00:00:00":{"name":"청명","type":"solarterms"},"2025-04-05 00:00:00":{"name":"한식","type":"solarterms"},"2025-04-20 00:00:00":{"name":"곡우","type":"solarterms"},"2025-05-01 00:00:00":{"name":"근로자의날","type":"national"},"2025-05-05 00:00:00":{"name":"입하","type":"solarterms"},"2025-05-08 00:00:00":{"name":"어버이날","type":"national"},"2025-05-10 00:00:00":{"name":"유권자의날","type":"national"},"2025-05-15 00:00:00":{"name":"스승의날","type":"national"},"2025-05-21 00:00:00":{"name":"소만","type":"solarterms"},"2025-05-31 00:00:00":{"name":"단오","type":"solarterms"},"2025-06-05 00:00:00":{"name":"망종","type":"solarterms"},"2025-06-06 00:00:00":{"name":"현충일","type":"holiday"},"2025-06-21 00:00:00":{"name":"하지","type":"solarterms"},"2025-06-25 00:00:00":{"name":"6.25 한국 전쟁","type":"national"},"2025-07-07 00:00:00":{"name":"소서","type":"solarterms"},"2025-07-17 00:00:00":{"name":"제헌절","type":"national"},"2025-07-20 00:00:00":{"name":"초복","type":"solarterms"},"2025-07-22 00:00:00":{"name":"대서","type":"solarterms"},"2025-07-30 00:00:00":{"name":"중복","type":"solarterms"},"2025-08-07 00:00:00":{"name":"입추","type":"solarterms"},"2025-08-09 00:00:00":{"name":"말복","type":"solarterms"},"2025-08-15 00:00:00":{"name":"광복절","type":"holiday"},"2025-08-23 00:00:00":{"name":"처서","type":"solarterms"},"2025-09-07 00:00:00":{"name":"백로","type":"solarterms"},"2025-09-23 00:00:00":{"name":"추분","type":"solarterms"},"2025-10-03 00:00:00":{"name":"개천절","type":"holiday"},"2025-10-05 00:00:00":{"name":"추석","type":"consecutive"},"2025-10-06 00:00:00":{"name":"추석","type":"holiday"},"2025-10-07 00:00:00":{"name":"추석","type":"consecutive"},"2025-10-08 00:00:00":{"name":"한로","type":"solarterms"},"2025-10-09 00:00:00":{"name":"한글날","type":"holiday"},"2025-10-23 00:00:00":{"name":"상강","type":"solarterms"},"2025-11-07 00:00:00":{"name":"입동","type":"solarterms"},"2025-11-22 00:00:00":{"name":"소설","type":"solarterms"},"2025-12-07 00:00:00":{"name":"대설","type":"solarterms"},"2025-12-21 00:00:00":{"name":"동지","type":"solarterms"},"2025-12-25 00:00:00":{"name":"성탄절","type":"holiday"},"2026-01-01 00:00:00":{"name":"새해 첫날","type":"holiday"},"2026-01-05 00:00:00":{"name":"소한","type":"solarterms"},"2026-01-20 00:00:00":{"name":"대한","type":"solarterms"},"2026-02-04 00:00:00":{"name":"입춘","type":"solarterms"},"2026-02-14 00:00:00":{"name":"밸런타인데이","type":"etc"},"2026-02-16 00:00:00":{"name":"설날","type":"consecutive"},"2026-02-17 00:00:00":{"name":"설날","type":"holiday"},"2026-02-18 00:00:00":{"name":"설날","type":"consecutive"},"2026-02-19 00:00:00":{"name":"우수","type":"solarterms"},"2026-03-01 00:00:00":{"name":"삼일절","type":"holiday"}}

  isHoliday: (date) ->
    if date and holidays
      dateString = $filter('date') date, 'yyyy-MM-dd 00:00:00'
      if holidays[dateString] and (holidays[dateString].type == 'holiday' or holidays[dateString].type == 'consecutive')
        return true
    false
  getToday: () ->
    holidays.today
]
