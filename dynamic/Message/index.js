"use strict";

require("./styles.css")

var React   = require("react")
var factory = require("../factory")
var Moment  = require("moment")

var MoneyToggle = require("../Money/Toggle")
var MoneyForm   = require("../Money/Form")

var Message   = factory("div", "Message")
var Header    = factory("div", "MessageHeader")
var Name      = factory("div", "MessageName")
var Host      = factory("div", "MessageHost")
var Time      = factory("div", "MessageTime")
var Content   = factory("div", "MessageContent")
var Radio     = factory("div", "MessageRadio")
var Meta      = factory("div", "MessageMeta")
var TimeIcon  = factory("i",   "fa fa-clock-o")
var HostIcon  = factory("i",   "fa fa-cube")
var RadioIcon = factory("i",   "fa fa-signal")

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
    var {text, uuid, sender_name: name, sender_host: host, created_at: time, radio} = this.props;

    return <Message>
      <Header>
        <Name>{name || host}</Name>
        <MoneyToggle uuid={"message"+uuid} host={host}/>
      </Header>
      <Content>
        <MoneyForm uuid={"message"+uuid} host={host}/>
        {text}
      </Content>
      <Meta>
        {radio && <Radio><RadioIcon/> Radio</Radio>}
        <Time><TimeIcon/> {Moment(time,"x").fromNow()}:</Time>
        {name !== undefined && <Host><HostIcon/> {host}</Host>}
      </Meta>
    </Message>
  }
});
