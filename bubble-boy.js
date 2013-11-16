// Generated by CoffeeScript 1.6.3
var addToScope, css, falafel, getScope, init, isBlockStatement, isDeclared, isFunction, isFunctionArgument, isFunctionId, isId, isLookup, isRoot, isVariableDeclaration, path;

falafel = require('falafel');

css = require('cssauron-falafel');

isId = isRoot = isLookup = isFunction = isFunctionId = isFunctionArgument = isVariableDeclaration = isBlockStatement = null;

path = function(node) {
  if (node == null) {
    return '';
  }
  return path(node.parent) + ' > ' + node.type + ((node.name != null) && (":" + node.name) || '');
};

getScope = function(node) {
  var parent;
  if (node == null) {
    return null;
  }
  if (isRoot(node)) {
    return node;
  }
  parent = node.parent;
  if (parent == null) {
    return null;
  }
  if (isBlockStatement(parent) || isFunction(parent)) {
    return parent;
  }
  return getScope(parent);
};

addToScope = function(node, scopeNode) {
  var blockNode;
  if (scopeNode == null) {
    scopeNode = node;
  }
  if (node.name == null) {
    return;
  }
  blockNode = getScope(scopeNode);
  if (blockNode.scope == null) {
    blockNode.scope = {};
  }
  return blockNode.scope[node.name] = true;
};

isDeclared = function(node) {
  var block, name, _ref;
  name = node.name;
  while (block = getScope(node)) {
    if ((_ref = block.scope) != null ? _ref[name] : void 0) {
      return true;
    }
    node = node.parent;
  }
};

init = function() {
  isId = css('id');
  isRoot = css('root');
  isLookup = css('lookup');
  isFunction = css('function');
  isFunctionId = css('function > .id');
  isFunctionArgument = css('function > id');
  isVariableDeclaration = css('variable > id, variable-decl > id');
  isBlockStatement = css('block');
  return init = function() {};
};

module.exports = function(src, options) {
  var contextName, results;
  if (options == null) {
    options = {};
  }
  init();
  contextName = options.name || 'sandbox';
  results = falafel("" + src, {
    tolerant: true
  }, function(node) {
    var parent, _ref;
    parent = node.parent;
    if (isFunctionId(node)) {
      return addToScope(node, parent);
    }
    if (isVariableDeclaration(node) || isFunctionArgument(node)) {
      return addToScope(node);
    }
    if (isId(node)) {
      if (isLookup(parent)) {
        if (!(isId(parent.object) && ((_ref = parent.object) != null ? _ref.name : void 0) === node.name)) {
          return;
        }
      }
      if (isDeclared(node)) {
        return;
      }
      return node.update("" + contextName + "." + node.name);
    }
  });
  return results.toString();
};
