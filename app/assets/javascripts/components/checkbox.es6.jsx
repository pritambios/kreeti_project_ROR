class Checkbox extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: this.props.users,
      check: this.props.checkedprops,
      item_id: this.props.itemIdProps,
      visible: false
    }
  }

  handleClick(e) {
    var checkbox = e.target;
    var id = this.state.item_id;
    if(checkbox.checked) {
      this.setState({
        visible: true
      })
    } else {
        this.deallocate(id)
    }
  }

  deallocate(id) {
    $.ajax({
      url: '/deallocate.' + id,
      type: 'get',
      success: function() {
        this.setState({
          check: false
        })
      }.bind(this)
    });
  }

  modalClose() {
    $('#myModal').modal('hide');
    this.setState({
      check: false,
      visible: false
    })
  }

  reallocateSuccess() {
    $('#myModal').modal('hide');
    this.setState({
      check: true,
      visible: false
    })
  }

  render() {
    return(
      <div>
        <input onChange={this.handleClick.bind(this)} type="checkbox" checked={this.state.check}/>
        <span id="">({this.state.check ? "Allocated" : "No Allocation"})</span>
        {
          this.state.visible ? <Modal reallocateSuccess={ this.reallocateSuccess.bind(this) }
                modalClose={this.modalClose.bind(this) } check={ this.state.check } users={ this.state.users }
                item_id={this.state.item_id} /> : ''
        }
      </div>
    )
  }
}
