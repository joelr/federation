"use strict";

require("./styles.css")

var React          = require("react")
var factory        = require("../factory")
var {string, bool} = React.PropTypes

var Name       = factory("div", "HostName")
var Host       = factory("div", "HostHost")
var DonateIcon = factory("i", "fa fa-heart")
var Donate     = factory("a", {className: "HostDonate", target: "_blank"})

var MoneyToggle = require("../Money/Toggle")
var MoneyForm   = require("../Money/Form")

module.exports = React.createClass({
  displayname : "Host",

  propTypes : {
    host         : string,
    name         : string,
    uuid         : string,
    paypal_email : bool,
    charity_url  : string
  },

  render() {
    var {name, host, charity_url: href, uuid, paypal_email: email} = this.props

    return <div className="Host">
      <div className="HostRow">
        <Name>{name ? name : host}</Name>
        <Host>{name && host}</Host>
        {email && <MoneyToggle uuid={"sidebar"+uuid} host={host}/>}
        {href && <Donate href={href}><DonateIcon/></Donate>}
      </div>
      {email && <MoneyForm uuid={"sidebar"+uuid} host={host}/>}
    </div>
  }
})
