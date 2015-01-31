"use strict";

var send = require("oro-dispatcher/lib/send")
var post = require("oro-xhr/lib/post")

function postMessage(text) {
  return post("/api/v1/messages", {text})
};

function postMessageSuccess() {
  send("MESSAGE_FORM_SUBMIT")
}

module.exports = {
  updateMessage(message) { send("MESSAGE_FORM_UPDATE_MESSAGE", {message}) },

  submit(text) {
    postMessage({text}).then(postMessageSuccess);
  },
}
