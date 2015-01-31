"use strict";

var projection = require("oro-dispatcher/lib/projection")

var __Hosts
setHosts([])

function setHosts(hosts) {
  __Hosts = hosts;
}

module.exports = projection("HOSTS", {

  getHosts() { return __Hosts },
  getCount() { return __Hosts.length }

}, function(payload) {
  var {actionType, hosts} = payload.action

  switch (actionType) {
    case "HOSTS_UPDATE":
      setHosts(hosts)
      this.broadcast()
      break;
  }
})
