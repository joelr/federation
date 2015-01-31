"use strict";

require("./styles.css")

var React   = require("react")
var factory = require("../factory")

var Message = factory("div", "Message")
var Header  = factory("div", "MessageHeader")
var Name    = factory("div", "MessageName")
var Host    = factory("div", "MessageHost")
var Content = factory("div", "MessageContent")

var {string, number} = React.PropTypes;

module.exports = React.createClass({
  displayName : "Message",

  propTypes : {
    uuid        : string,
    text        : string,
    sender_host : string,
    name        : string,
    created_at  : number
  },

  render() {
    var {text, sender_name: name, sender_host: host} = this.props;

    return <Message>
      <Header>
        <Name>{name || host}</Name>
        <Host>truthtaco.com</Host>
        {name !== undefined && <Host>{host}</Host>}
      </Header>
      <Content>
        {text}
      </Content>
    </Message>
  }
});
