angular.module('MyDirectives').directive 'ddSort', ->
  return {
    restrict: 'A'
    link: ($scope, $el, $attr) ->
      nodes = undefined
      values = undefined
      $el.sortable
        stop: (event, ui) ->
          newValues = []
          modelValues = $scope.$eval($attr.ngModel)
          ((node, id) ->
            ((_node, _id) ->
              modelValues[id] = values[_id] if node is _node
            ) _node, _id for _node, _id in  nodes
          ) node, id for node, id in $el.children(':not(.ui-sortable-placeholder)')
          $scope.$apply()
      $scope.$watch $attr.ngModel, (newValue, oldValue) ->
        nodes = []
        values = []
        ((node, id) ->
          nodes.push node
          values.push newValue[id]
        ) node, id for node, id in $el.children(':not(.ui-sortable-placeholder)')
      , true
  }
