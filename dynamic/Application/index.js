"use strict";

require("./styles.css");

var React   = require("react")
var factory = require("../factory")

var Main    = require("../Main")
var Sidebar = require("../Sidebar")

var App     = factory("div", "Application")
var Header  = factory("h1",  "Application_header")
var Content = factory("div", "Application_content")

module.exports = React.createClass({
  displayName : "Application",

  render() {
    return <App>
      <Content>
        <Header>Federation</Header>
        <Main/>
      </Content>
      <Sidebar/>
    </App>
  }
});

