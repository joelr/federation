"use strict";

var projection = require("oro-dispatcher/lib/projection")

var maxSize = 140
var minSize = 1

var __Message, __Length, __Remaining, __Valid
setMessage("") // Default to empty message;

function setMessage(msg) {
  __Message   = msg
  __Length    = msg.length
  __Remaining = maxSize - __Length
  __Valid     = maxSize >= __Length && __Length >= minSize
}

module.exports = projection("MESSAGE_FORM", {

  getMessage()   : string  { return __Message   },
  getLength()    : number  { return __Length    },
  getRemaining() : number  { return __Remaining },
  isValid()      : boolean { return __Valid     }

}, function(payload) {
  var {actionType, message} = payload.action

  console.log(actionType, payload.action)

  switch (actionType) {
    case "MESSAGE_FORM_UPDATE_MESSAGE":
      setMessage(message)
      this.broadcast()
      break;

    case "MESSAGE_FORM_SUBMIT":
      setMessage("")
      this.broadcast()
      break;
  }
});
