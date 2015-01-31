"use strict";

var React   = require("react")
var actions = require("./actions")

module.exports = React.createClass({
  displayName : "Money/Toggle",

  render() {
    var {props, open} = this

    return <a href="#" className="HostMoney" onClick={open}>
      <i className="fa fa-money"/>
    </a>
  },

  open(e) {
    e.preventDefault()
    actions.open(this.props.uuid)
  }
})
