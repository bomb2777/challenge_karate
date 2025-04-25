Feature: user account test

Background:
  * def headers = call read('headers.js')
  * configure headers = headers

Scenario: create user and login
  * def email = 'eve.holt@reqres.in'
  * def password = 'abcd1234!'
  * def registerBody =
  """
  {
    "email": '#(email)',
    "password": '#(password)'
  }
  """
  Given url 'https://reqres.in/api/register'
  And request registerBody
  When method post
  Then status 200
  * def token = response.token


  * def loginBody =
  """
  {
    "email": '#(email)',
    "password": '#(password)'
  }
  """
  Given url 'https://reqres.in/api/login'
  And request loginBody
  When method post
  Then status 200
  And match response.token == token
