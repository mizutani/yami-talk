var TalkYami = React.createClass({
  getInitialState: function(){
    return {
      messages: []
    }
  },

  createMessage: function(data){
    var message = {
      vocieSrc: data.file_name,
      userText: data.send_message,
      talkText: data.talk_message,
    }

    this.state.messages.push(message);
    this.setState({
      messages: this.state.messages
    });
  },

  render: function() {

    var messages = this.state.messages.map(function(message, index) {
      return <Message
        key={index}
        vocieSrc={'/assets/' + message.vocieSrc}
        userText={message.userText}
        talkText={message.talkText}
        />;
    }.bind(this));

    return <div className='container'>
      <div className='message-canvas'>
        <ul className="collection">
          {messages}
        </ul>
      </div>
      <SendMessage createMessage={this.createMessage} />
    </div>;
  }
});
