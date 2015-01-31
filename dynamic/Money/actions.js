"use strict";

var send = require("oro-dispatcher/lib/send")

module.exports = {
  open(uuid) { send("MONEYS_OPEN",{uuid}) }
}
