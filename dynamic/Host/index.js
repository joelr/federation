"use strict";

require("./styles.css")

var React    = require("react")
var factory  = require("../factory")
var {string} = React.PropTypes

var Name       = factory("div", "HostName")
var Host       = factory("div", "HostHost")
var DonateIcon = factory("i", "fa fa-heart")
var Donate     = factory("a", {className: "HostDonate", target: "_blank"})

var Money = require("./Money")

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
    var {name, host, charity_url: href, paypal_email: email} = this.props

    return <div className="Host">
      <Name>{name ? name : host}</Name>
      <Host>{name && host}</Host>
      {email && <Money email={email}/>}
      {href && <Donate href={href}><DonateIcon/></Donate>}
    </div>
  }
})
