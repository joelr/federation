"use strict";

require("./styles.css")

var React   = require("react")
var factory = require("../factory")
var Moment  = require("moment")

var Message  = factory("div", "Message")
var Header   = factory("div", "MessageHeader")
var Name     = factory("div", "MessageName")
var Host     = factory("div", "MessageHost")
var Time     = factory("div", "MessageTime")
var Content  = factory("div", "MessageContent")
var Meta     = factory("div", "MessageMeta")
var TimeIcon = factory("i",   "fa fa-clock-o")
var HostIcon = factory("i",   "fa fa-cube")

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
    var {text, sender_name: name, sender_host: host, created_at: time} = this.props;

    return <Message>
      <Header>
        <Name>{name || host}</Name>
      </Header>
      <Content>
        {text}
      </Content>
      <Meta>
        <Time><TimeIcon/> {Moment(time,"x").fromNow()}:</Time>
        {name !== undefined && <Host><HostIcon/> {host}</Host>}
      </Meta>
    </Message>
  }
});
