"use strict";

var send = require("oro-dispatcher/lib/send")
var get  = require("oro-xhr/lib/get")

// quick
function getMessages()            { return get("/api/v1/messages") }
function getMessagesSuccess(data) { send("MESSAGES_UPDATE", JSON.parse(data.text)) }

function quickPolls() {
  getMessages().then(getMessagesSuccess)
}

quickPolls()
setInterval(quickPolls, 1750)


// Not so quick
function getHosts()               { return get("/api/v1/hosts") }
function getHostsSuccess(data)    { send("HOSTS_UPDATE", JSON.parse(data.text)) }

function notSoQuickPolls() {
  getHosts().then(getHostsSuccess)
}

notSoQuickPolls()
setInterval(notSoQuickPolls, 5000)

