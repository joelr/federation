"use strict"

var React  = require("react")
var assign = require("lodash/object/assign")

module.exports = function(tag, options) {
  var opts = typeof options === "string"
               ? {className: options}
               : options || {}

  return React.createClass({
    displayName : "factory/" + tag + "/" + opts.className,

    render() {
      var {props}    = this
      var {children} = props
      var newProps   = assign({}, props, opts)

      return React.createElement(tag, newProps, children)
    }
  });
}

