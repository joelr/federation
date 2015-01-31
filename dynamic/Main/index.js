"use strict";

var React       = require("react")
var factory     = require("../factory")
var MessageForm = require("../MessageForm")
var Messages    = require("../Messages")

var Main = factory("div", "Application_main")

module.exports = React.createClass({
  displayName : "Main",

  render() {
    return <Main>
      <MessageForm/>
      <Messages/>
    </Main>
  }
});
