var Audio = React.createClass({
  propTypes: {
    src: React.PropTypes.string,
    isPlay: React.PropTypes.bool
  },

  getInitialState: function(){
    return {
      isPlay: false,
    }
  },

  componentWillReceiveProps: function(nextProps){
    if (nextProps.isPlay !== this.state.isPlay) {
      this.setState({
        isPlay: nextProps.isPlay,
      });
    }
  },

  componentDidUpdate: function(){
    if(this.state.isPlay){
      React.findDOMNode(this).play();
      this.setState({
        isPlay: false
      });
    }
  },

  render: function(){
    return <audio id="audio">
            <source src={this.props.src} />
          </audio>;
  }
});
