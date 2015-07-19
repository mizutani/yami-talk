var Message = React.createClass({
  playVoice: function(event){
    this.setState({
      isPlay: true
    });
  },

  getInitialState: function(){
    return {
      isPlay: false,
    }
  },

  render: function(){
    return <li className="collection-item avatar">
      <Audio src={this.props.vocieSrc} isPlay={this.state.isPlay} />
      <i className="material-icons circle red right-align" onClick={this.playVoice}>play_arrow</i>
      <span className="title">USER: {this.props.userText}</span>
      <p>{this.props.talkText}</p>
    </li>;
  }
});
