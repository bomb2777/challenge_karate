Feature: schema validation test

Background:
  * def headers = call read('headers.js')
  * configure headers = headers

Scenario: response schema is correct
  * def expectedSchema =
  """
  {
    "page": "#number",
    "per_page": "#number",
    "total": "#number",
    "total_pages": "#number",
    "data": [
      {
        "id": "#number",
        "email": "#string",
        "first_name": "#string",
        "last_name": "#string",
        "avatar": "#string"
      }
    ],
    "support": {
      "url": "#string",
      "text": "#string"
    }
  }
  """

  Given url 'https://reqres.in/api/users'
  And params { page: 1, per_page: 1 }
  When method get
  Then status 200
  And match response == expectedSchema
