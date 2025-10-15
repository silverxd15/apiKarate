Feature: Pruebas automatizadas de la página regreses in

  @TEST-1
  Scenario: Obtener el listado de pagina 2 - OK
    Given url reqresURL + 'api/' + 'users'
    And param page = '2'
    When method GET
    Then status 200
    And print response

  @TEST-2
  Scenario: Obtner solamente un usuario con su ID - OK
    Given url reqresURL + 'api/' + 'users/' + '2'
    When method GET
    Then status 200
    And print response

  @TEST-4
  Scenario: Verificar que un cliente no exita  con su ID - NO -OK
    Given url reqresURL + 'api/' + 'users/' + '23'
    When method GET
    Then status 404
    And print response

  @TEST-5
  Scenario: Creacion de un usuario - OK
    Given url reqresURL + 'api/' + 'users'
    And request
    """
    {
    "name": "Leonard",
    "job": "QE"
    }
    """
    When method POST
    Then status 201
    * print response

  @TEST-6
  Scenario: Obtener el listado de usuarios
    Given url 'https://reqres.in/api/users'
    And param page = '2'
    When method GET
    Then status 200
    * print response

