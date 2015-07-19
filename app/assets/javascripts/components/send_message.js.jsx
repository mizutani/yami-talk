var SendMessage = React.createClass({
  propTypes: {
    message: React.PropTypes.string,
    createMessage: React.PropTypes.func.isRequired
  },

  getInitialState: function() {
    return {
      message: ''
    };
  },

  submitMeesage: function (event) {
    event.preventDefault();
    $.post(
      '/message.json',
      {message: this.state.message},
      function(data){
        this.setState({
          message: ''
        });
        this.props.createMessage(data);
      }.bind(this));
  },

  changeMessage: function (event) {
    this.setState({
      message: event.target.value
    });
  },

  render: function() {
    return <div className='send-message'>
      <div className='row card-panel teal green lighten-3'>
        <p className="flow-text">闇ちゃんにメッセージを送信する</p>
        <form onSubmit={this.submitMeesage}>
          <input
            className='green lighten-5'
            type="text"
            value={this.state.message}
            onChange={this.changeMessage} />
        </form>
      </div>
    </div>;
  }
});
