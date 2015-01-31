"use strict";

var send = require("oro-dispatcher/lib/send")
var get  = require("oro-xhr/lib/get")

function getMessages()            { return get("/api/v1/messages") }
function getMessagesSuccess(data) { send("MESSAGES_UPDATE", JSON.parse(data.text)) }
function getHosts()               { return get("/api/v1/hosts") }
function getHostsSuccess(data)    { send("HOSTS_UPDATE", JSON.parse(data.text)) }

function allThePolls() {
  getMessages().then(getMessagesSuccess)
  getHosts().then(getHostsSuccess)
}

allThePolls()
setInterval(allThePolls, 1750)
