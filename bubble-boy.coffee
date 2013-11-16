falafel = require 'falafel'
css = require 'cssauron-falafel'

isId = isRoot = isLookup = isFunction = isFunctionId = isFunctionArgument = isVariableDeclaration = isBlockStatement = null

path = (node) ->
  return '' unless node?
  path(node.parent) + ' > ' + node.type + (node.name? and ":#{node.name}" or '')

getScope = (node) ->
  return null unless node?
  return node if isRoot(node)

  {parent} = node
  return null unless parent?
  return parent if isBlockStatement(parent) or isFunction(parent)
  return getScope parent

addToScope = (node, scopeNode = node) ->
  return unless node.name?
  blockNode = getScope scopeNode
  blockNode.scope ?= {}
  blockNode.scope[node.name] = yes

isDeclared = (node) ->
  name = node.name

  while block = getScope node
    return true if block.scope?[name]
    node = node.parent

init = ->
  isId = css 'id'
  isRoot = css 'root'
  isLookup = css 'lookup'
  isFunction = css 'function'
  isFunctionId = css 'function > .id'
  isFunctionArgument = css 'function > id'
  isVariableDeclaration = css 'variable > id, variable-decl > id'
  isBlockStatement = css 'block'

  init = ->

module.exports = (src, options = {}) ->
  init()

  contextName = options.name or 'sandbox'

  results = falafel "#{src}", tolerant: true, (node) ->
    {parent} = node

    return addToScope node, parent if isFunctionId(node)
    return addToScope node if isVariableDeclaration(node) or isFunctionArgument(node)

    if isId(node)
      if isLookup(parent)
        return unless isId(parent.object) and parent.object?.name is node.name

      return if isDeclared(node)

      node.update "#{contextName}.#{node.name}"

  results.toString()
