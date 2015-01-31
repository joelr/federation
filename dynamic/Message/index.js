"use strict";

var React   = require("react")
var factory = require("../factory")

var Message = factory("div", "Message")
var Header  = factory("div", "MessageHeader")
var Name    = factory("div", "MessageName")
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
    var {text, name, sender_host} = this.props;

    return <Message>
      <Header>
        <Name>{name || sender_host}</Name>
      </Header>
      <Content>
        {text}
      </Content>
    </Message>
  }
});
