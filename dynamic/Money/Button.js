"use strict";

var React = require("react")

module.exports = React.createClass({
  displayName : "Money/Button",

  render() {
    var {amount} = this.props
    return <form>
      <button className="MoneyButton">
        {amount === "other" ? "Other" : "$"+amount}
      </button>
    </form>
  }
})
