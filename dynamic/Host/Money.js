"use strict";

var React   = require("react")
var factory = require("../factory")

var I = factory("input", {type:"hidden"})

module.exports = React.createClass({
  render() {
    return <form method="post" action="https://www.sandbox.paypal.com/cgi-bin/webscr" target="_blank">
      <I name="button"    value="donate"/>
      <I name="business"  value={this.props.email}/>
      <I name="item_name" value=""/>
      <I name="quantity" value=""/>
      <I name="amount" value="5"/>
      <I name="currency_code" value=""/>
      <I name="shipping" value=""/>
      <I name="tax" value=""/>
      <I name="notify_url" value=""/>
      <I name="env" value=""/>
      <I name="cmd" value=""/>
      <I name="bn" value=""/>
      <button type="submit">
        <i className="fa fa-money"/>
      </button>
    </form>
  }
})
