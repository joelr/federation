"use strict";

var send = require("oro-dispatcher/lib/send")
var post = require("oro-xhr/lib/post")

function postHost(host) {
  return post("/api/v1/hosts/add", {host})
}

function postHostSuccess() {
  send("HOST_FORM_SUBMIT")
}

module.exports = {
  updateHost(host) { send("HOST_FORM_UPDATE_HOST", {host}) },
  submit(host)     { postHost(host).then(postHostSuccess) }
}
