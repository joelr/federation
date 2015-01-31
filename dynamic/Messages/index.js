"use strict";

require("./styles.css")

var React     = require("react")
var factory   = require("../factory")
var store     = require("./store")
var map       = require("lodash/collection/map")
var subscribe = require("oro-dispatcher/lib/subscribe")

var Message  = require("../Message")
var Messages = factory("div", "Messages")

function state() {
  return {
    messages : store.getMessages()
  }
}

module.exports = React.createClass({
  displayName : "Messages",
  mixins      : [subscribe(store, state)],

  render() {
    var {messages} = this.state

    if (messages.length === 0) return null;

    return <Messages>
      {map(messages, d => <Message {...d} key={d.uuid}/>)}
    </Messages>
  }
});
