"use strict";

require("./styles.css")

var React = require("react")
var B     = require("./Button")

function state() {
  return {}
}

module.exports = React.createClass({
  displayName : "Money/Form",
  getInitialState() { return {} },
  emailRes(data) { this.setState({email: "james@bjorkman.ca", status: "How much would you like to send?"}) },
  getEmail(host) {},

  componentDidMount() {
    this.setState({status: "Fetching Payment Details..."})
    setTimeout(this.emailRes.bind(this), 1000)
    // getEmail(this.props.host).then(emailRes);
  },

  render() {
    var {state}         = this
    var {status, email} = state

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
