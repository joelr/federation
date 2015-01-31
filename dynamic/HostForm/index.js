"use strict";

require("./styles.css")
  
var React   = require("react")
var factory = require("../factory")

var Form       = factory("div",    "HostForm")
var Input      = factory("input",  "HostFormInput")
var Submit     = factory("button", "HostFormSubmit")
var HostIcon   = factory("i",      "fa fa-cube")
var SubmitIcon = factory("i",      "fa fa-plus")

module.exports = React.createClass({
  display: "HostForm",

  render() {
    return <Form>
      <HostIcon/>
      <Input placeholder="Add Host"/>
      <Submit>
        <SubmitIcon/>
      </Submit>
    </Form>
  }
});
