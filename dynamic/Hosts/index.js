"use strict";

require("./styles.css")

var React     = require("react")
var factory   = require("../factory")
var map       = require("lodash/collection/map")
var Host      = require("../Host")
var subscribe = require("oro-dispatcher/lib/subscribe")
var store     = require("./store")
var actions   = require("./actions")

function state() {
  return {
    hosts : store.getHosts(),
    count : store.getCount()
  }
}

module.exports = React.createClass({
  displayName : "Hosts",
  mixins      : [subscribe(store, state)],

  componentDidMount() { actions.poll() },

  render() {
    var {state} = this
    var {hosts} = state

    return <div className="Hosts">
      {map(hosts, d => <Host {...d} key={d.uuid}/>)}
    </div>
  }
})
