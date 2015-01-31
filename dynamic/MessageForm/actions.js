"use strict";

var send = require("oro-dispatcher/lib/send")

module.exports = {
  updateMessage(message) { send("MESSAGE_FORM_UPDATE_MESSAGE", {message}) },
  submit(message)        { send("MESSAGE_FORM_SUBMIT", {message}) },
}
