"use strict";

require("./styles.css")

var React     = require("react")
var factory   = require("../factory")
var actions   = require("./actions")
var store     = require("./store")
var subscribe = require("oro-dispatcher/lib/subscribe")

var Form       = factory("div",    "HostForm")
var Input      = factory("input",  "HostFormInput")
var Submit     = factory("button", "HostFormSubmit")
var HostIcon   = factory("i",      "fa fa-cube")
var SubmitIcon = factory("i",      "fa fa-plus")
var Loading    = factory("i",      "fa fa-circle-o-notch fa-spin")

function state() {
  return {
    host      : store.getHost(),
    isValid   : store.isValid(),
    isLoading : store.isLoading()
  }
}

module.exports = React.createClass({
  display: "HostForm",
  mixins : [subscribe(store, state)],

  render() {
    var {state, updateHost, submit} = this
    var {host, isValid, isLoading}  = state

    return <Form onSubmit={submit}>
      <HostIcon/>
      <Input placeholder="Add Host" value={host} onChange={updateHost}/>
      {isValid && <Submit onClick={submit}>
        {isLoading ? <Loading/> : <SubmitIcon/>}
      </Submit>}
    </Form>
  },

  updateHost(e) { actions.updateHost(e.target.value) },

  submit(e) {
    e.preventDefault()
    var {isValid, host} = this.state
    if (isValid) {
      this.setState({isLoading: true})
      actions.submit(host)
    }
  }
});
