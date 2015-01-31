"use strict";

var React    = require("react")
var factory  = require("../factory")
var {string} = React.PropTypes

var MoneyIcon  = factory("i", "fa fa-money")
var DonateIcon = factory("i", "fa fa-heart")

module.exports = React.createClass({
  displayname : "Host",

  propTypes : {
    host         : string,
    name         : string,
    uuid         : string,
    paypal_email : string,
    charity_url  : string
  },

  render() {
    var {name, host} = this.props

    return <div className="Host">
      {name ? name : host}
      {name && host}
      <MoneyIcon/>
      <DonateIcon/>
    </div>
  }
})
