"use strict";

var React = require("react")

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
    console.log("money open", this.props.uuid)
  }
})
