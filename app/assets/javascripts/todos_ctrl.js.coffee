module = angular.module 'todos'

module.controller 'TodosCtrl', ['$scope', '$timeout', 'Restangular', ($scope, $timeout, Restangular) ->
  $scope.init = ->
    $scope.new = {}
    Restangular.all('todos').getList().then (todos) ->
      $scope.todos = todos

  $scope.create = ->
    Restangular.all('todos').post($scope.new)
    $scope.init()

  $scope.update = (element) ->
    element.$dirty = true

  $scope.delete = (element) ->
    element.remove()
    $scope.todos = _.without $scope.todos, element

  updateDirtys = () ->
    for todo in $scope.todos
      if todo.$dirty?
        todo.put()
        todo.$dirty = undefined
    $timeout(updateDirtys, 5000)

  $timeout(updateDirtys, 10000)
]
