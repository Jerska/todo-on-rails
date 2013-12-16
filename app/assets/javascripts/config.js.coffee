module = angular.module 'todos', ['restangular', 'ui.bootstrap', 'ui.bootstrap.datetimepicker', 'ui.dateTimeInput']

module.config ['RestangularProvider', (RestangularProvider) ->
  RestangularProvider.setDefaultHeaders
    "Accept": 'application/json',
    "X-Version": '0.2'

  RestangularProvider.setBaseUrl '/api'

  RestangularProvider.setErrorInterceptor (err) ->
    if err.config.method != "GET"
      msg = 'Erreur: Modifications non enregistrées'
    else
      msg = "Problème de connexion internet"
    noty layout: 'topCenter', type: 'error', text: msg
    console.log err.data

  RestangularProvider.setRequestInterceptor (element, operation, route, url) ->
    if element and element.originalElement
      delete element.originalElement
    element

  RestangularProvider.setResponseExtractor (response, operation) ->
    newResponse = response
    if operation is "getList" and response.hasOwnProperty "data"
      newResponse = response.data
      newResponse.meta = response.meta
    if angular.isArray response
      angular.forEach newResponse, (value, key) ->
        newResponse[key].originalElement = angular.copy value
    else
      newResponse.originalElement = angular.copy response
    newResponse
]
