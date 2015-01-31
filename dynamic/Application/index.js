"use strict";

require("./styles.css");

var React   = require("react")
var factory = require("../factory")

var App     = factory("div", "Application")
var Header  = factory("h1",  "Application_header")
var Content = factory("div", "Application_content")
var Main    = factory("div", "Application_main")
// var Side    = factory("div", "Application_side")

module.exports = React.createClass({
  displayName : "Application",

  render() {
    return <App>
      <Header>Federation</Header>
      <Content>
        <Main>Main</Main>
      </Content>
    </App>
  }
});

