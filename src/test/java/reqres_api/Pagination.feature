Feature: pagination works as expected on the users endpoint

Background:
  * url 'https://reqres.in/api'
  Given path 'users'
  When method get
  Then status 200
  * def result_data = response
  * def total_item_count = result_data.total

Scenario: test pagination default
  * match result_data.page == 1
  * match result_data.per_page == 6
  * match result_data.total_pages == total_item_count / result_data.per_page

Scenario: test pagination minimal
  Given path 'users'
  And params { page: 1, per_page: 1 }
  When method get
  Then status 200
  * def res = response

  * match res.page == 1
  * match res.per_page == 1
  * match res.total_pages == total_item_count

Scenario: test pagination maximal
  Given path 'users'
  And params { page: 1, per_page: 12 }
  When method get
  Then status 200
  * def res = response

  * match res.page == 1
  * match res.per_page == total_item_count
  * match res.total_pages == 1

Scenario: test pagination mixed
  Given path 'users'
  And params { page: 2, per_page: 4 }
  When method get
  Then status 200
  * def res = response

  * match res.page == 2
  * match res.per_page == 4
  * match res.total_pages == total_item_count / res.per_page
  * match res.data[0].id == 5 // check that first id on page 2 is '5'

Scenario: test pagination less than minimal
  Given path 'users'
  And params { page: -1, per_page: -1 }
  When method get
  Then status 200
  * def res = response

  * match res.page == -1
  * match res.per_page == -1
  * match res.total == total_item_count
  * match res.total_pages == total_item_count * -1
  * assert res.data.length == 0

Scenario: test pagination more than maximal
  * def exceedsMaximum = total_item_count + 1

  Given path 'users'
  And params { page: '#(exceedsMaximum)', per_page: '#(exceedsMaximum)' }
  When method get
  Then status 200
  * def res = response

  * match res.page == 13
  * match res.per_page == 13
  * match res.total == total_item_count
  * match res.total_pages == 1
  * assert res.data.length == 0