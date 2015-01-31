"use strict";

require("./styles.css")

var React   = require("react")
var cx      = require("react/lib/cx")
var factory = require("../factory")

var Sidebar   = factory("div",    "Sidebar")
var Open      = factory("button", "SidebarToggle")
var Close     = factory("button", "SidebarToggle")
var OpenIcon  = factory("i",      "fa fa-chevron-right")
var CloseIcon = factory("i",      "fa fa-chevron-left")
var Overflow  = factory("div",    "SidebarOverflow")

var HostForm = require("../HostForm")
var Hosts    = require("../Hosts")

function cs(state) {
  return cx({
    "Sidebar" : true,
    "u-open"  : state.open
  })
}

module.exports = React.createClass({
  displayName : "Sidebar",
  getInitialState() { return {open: true} },

  render() {
    var {state, open, close} = this
    var {open: isOpen}       = state

    return <div className={cs(state)}>
      <Overflow>
        <HostForm/>
        <Hosts/>
      </Overflow>
      {isOpen
        ? <Close onClick={close}><CloseIcon/></Close>
        : <Open onClick={open}><OpenIcon/></Open>
      }
    </div>
  },

  open()  { this.setState( { open: true}) },
  close() { this.setState( { open: false}) }
})
