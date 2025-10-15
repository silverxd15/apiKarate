Feature: Users
  Background:
    * url 'https://regres.in'

  @TEST-1
  Scenario: Get All Users
    Given path '/api/user?page=2'
    When method GET
    Then  status 200