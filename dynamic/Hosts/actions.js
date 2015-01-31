"use strict";

var send       = require("oro-dispatcher/lib/send")
var get        = require("oro-xhr/lib/get")
var Dispatcher = require("oro-dispatcher")

function getHosts()               { return get("/api/v1/hosts") }
function getHostsSuccess(data)    { send("HOSTS_UPDATE", JSON.parse(data.text)) }

var actions = module.exports = {
  poll() { getHosts().then(getHostsSuccess) }
}

Dispatcher.register(function(payload) {
  var {actionType} = payload.action;
  if (actionType === "HOST_FORM_SUBMIT") poll();
})
