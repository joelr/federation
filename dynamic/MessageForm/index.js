"use strict";

var React     = require("react")
var factory   = require("../factory")
var store     = require("./store")
var actions   = require("./actions")
var subscribe = require("oro-dispatcher/lib/subscribe")

var Form       = factory("form",     "MessageForm")
var MessageBox = factory("textarea", "MessageBox")
var CharCount  = factory("div",      "MessageCharCount")
var Submit     = factory("button",   "MessageSubmitButton")
var Actions    = factory("div",      "MessageActions")

function state() {
  return {
    remaining : store.getRemaining(),
    message   : store.getMessage(),
    isValid   : store.isValid()
  }
}

module.exports = React.createClass({
  displayName : "MessageForm",
  mixins      : [subscribe(store, state)],

  render() {
    var {state, updateMessage, submit} = this
    var {remaining, message, isValid}  = state

    return <Form onSubmit={submit}>
      <MessageBox value={message} onChange={updateMessage}/>
      {isValid && <Actions>
        <CharCount>{remaining}</CharCount>
        <Submit onClick={submit}>Broadcast</Submit>
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



