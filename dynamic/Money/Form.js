"use strict";

require("./styles.css")

var React     = require("react")
var B         = require("./Button")
var store     = require("./store")
var subscribe = require("oro-dispatcher/lib/subscribe")
var post      = require("oro-xhr/lib/post")

function state() {
  return {
    open: store.getOpen()
  }
}

module.exports = React.createClass({
  displayName : "Money/Form",
  mixins      : [subscribe(store, state)],

  emailRes(data) { this.setState({email: JSON.parse(data.text).paypal_email, status: "How much would you like to send?"}) },

  componentDidMount() {
    this.setState({status: "Fetching Payment Details..."})
    getEmail(this.props.host).then(this.emailRes)
  },

  render() {
    var {state}         = this
    var {status, email} = state

    if (!store.isOpen(this.props.uuid)) return null;

    return <div className="Money">
      {status && <div className="MoneyStatus">{status}</div>}
      {email && <div className="MoneyActions">
        <B amount="5"     email={email}/>
        <B amount="15"    email={email}/>
        <B amount="35"    email={email}/>
        <B amount="other" email={email}/>
      </div>}
    </div>
  }
})

function getEmail(host) {
  return post("/api/v1/request_email", {host})
}
