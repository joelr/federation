"use strict";

var projection = require("oro-dispatcher/lib/projection")

var __Open;
setOpen(undefined)

function setOpen(uuid) {
  __Open = uuid
}

module.exports = projection("MONEYS", {

  getOpen()    { return __Open },
  isOpen(uuid) { return __Open === uuid }

}, function(payload) {
  var {actionType, uuid} = payload.action

  switch (actionType) {
    case "MONEYS_OPEN":
      setOpen(uuid)
      this.broadcast()
      break;
  }
})
