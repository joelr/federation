"use strict";

var projection = require("oro-dispatcher/lib/projection")

var __Host, __Length, __Valid
setHost("")

function setHost(host) {
  __Host   = host
  __Length = host.length
  __Valid  = __Length > 0
}

module.exports = projection("HOST_FORM", {

  getHost()   { return __Host },
  getLength() { return __Length },
  isValid()   { return __Valid }

}, function(payload) {
  var {actionType, host} = payload.action

  switch (actionType) {
    case "HOST_FORM_UPDATE_HOST":
      setHost(host)
      this.broadcast()
      break;

    case "HOST_FORM_SUBMIT":
      setHost("")
      this.broadcast()
      break;
  }
})
