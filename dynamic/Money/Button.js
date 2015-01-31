"use strict";

var React = require("react")
var f     = require("../factory")
var I     = f("input", {type: "hidden"})

module.exports = React.createClass({
  displayName : "Money/Button",

  render() {
    var {amount, email} = this.props
    return <form method="post" action="https://www.paypal.com/cgi-bin/webscr" target="_blank">
      <I name="cmd"           value="_donations"/>
      <I name="business"      value={email}/>
      <I name="item_name"     value="Federation"/>
      <I name="currency_code" value="USD"/>
      {amount !== "other" && <I name="amount" value={amount}/>}
      <button className="MoneyButton">
        {amount === "other" ? "Other" : "$"+amount}
      </button>
    </form>
  }
})
