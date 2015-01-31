"use strict";

require("./styles.css")

var React     = require("react")
var cx        = require("react/lib/cx")
var factory   = require("../factory")
var store     = require("./store")
var actions   = require("./actions")
var subscribe = require("oro-dispatcher/lib/subscribe")

var Form          = factory("form",     "MessageForm")
var MessageBox    = factory("textarea", "MessageBox")
var Submit        = factory("button",   "MessageSubmitButton")
var Actions       = factory("div",      "MessageActions")

function csBox(state) {
  return cx({
    "MessageBox" : true,
    "u-valid"    : state.isValid,
    "u-tall"     : state.length > 0,
    "u-bad"      : state.length > 140
  })
}

function csCount(state) {
  return cx({
    "MessageCharCount" : true,
    "u-bad"            : state.length > 140
  })
}

function state() {
  return {
    length    : store.getLength(),
    remaining : store.getRemaining(),
    message   : store.getMessage(),
    isValid   : store.isValid()
  }
}

module.exports = React.createClass({
  displayName : "MessageForm",
  mixins      : [subscribe(store, state)],

  render() {
    var {state, updateMessage, submit}        = this
    var {remaining, message, isValid, length} = state

    return <Form onSubmit={submit}>
      <textarea placeholder="What do you need to say?" className={csBox(state)} value={message} onChange={updateMessage}/>
      {length > 0 && <Actions>
        <div className={csCount(state)}>{remaining}</div>
        { isValid && <Submit onClick={submit}>Broadcast</Submit> }
      </Actions>}
    </Form>
  },

  updateMessage(e) { actions.updateMessage(e.target.value) },

  submit(e) {
    e.preventDefault();
    var {isValid, message} = this.state
    if (isValid) actions.submit(this.state.message);
  }
});
