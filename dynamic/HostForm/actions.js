"use strict";

var send = require("oro-dispatcher/lib/send")
var post = require("oro-xhr/lib/post")
var get = require("oro-xhr/lib/get")

function postHost(host) {
  return post("/api/v1/hosts/add", {host})
}

function postHostSuccess() {
  send("HOST_FORM_SUBMIT")
}

function broadcast() {
  return get("/api/v1/broadcast");
}

module.exports = {
  updateHost(host) { send("HOST_FORM_UPDATE_HOST", {host}) },
  submit(host)     { postHost(host).then(postHostSuccess).then(broadcast) }
}
