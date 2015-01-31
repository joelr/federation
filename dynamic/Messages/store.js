"use strict";

var projection = require("oro-dispatcher/lib/projection")
var send       = require("oro-dispatcher/lib/send")

var __Messages
setMessages([]) // Default to empty list of messages

function setMessages(messages) {
  __Messages = messages || [];
}

module.exports = projection("MESSAGES", {

  getMessages(): Array<any> { return __Messages }

}, function(payload) {
  var {actionType, data} = payload.action

  switch (actionType) {
    case "MESSAGES_UPDATE":
      setMessages(data)
      this.broadcast()
      break;
  }
})
