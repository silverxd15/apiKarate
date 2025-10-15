@regresion
Feature: Pruebas automatizadas de la página todo.ly

  Background:
    * url todoURL

  @CREAR-PROYECTO
  Scenario: Crear un nuevo proyecto
    And path 'projects.json'
    And request { "Content": "Proyecto Karate Automatizado", "Icon": 4 }
    And header Authorization = tokenAuth
    When method post
    Then status 200
    And match response.Content == "Proyecto Karate Automatizado"
    * def projectId = response.Id
    * print projectId

  @OBTENER-PROYECTO
  Scenario: Consultar proyecto creado
    * def createResult = call read('classpath:todoLy/testTodoLy.feature@CREAR-PROYECTO')
    Given path '/projects/' + createResult.projectId + '.json'
    And header Authorization = tokenAuth
    When method get
    Then status 200
    And match response.Id == createResult.projectId
