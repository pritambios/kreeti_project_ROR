class Checkbox extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      check: this.props.checkedprops,
      item_id: this.props.itemIdProps,
      users: this.props.users
    }
  }

  handleClick() {
    var checkbox = document.getElementById("checkboxid");
    console.log(checkbox.checked);
    var id = document.getElementById("id_"+this.state.item_id).value;
    if(checkbox.checked) {
      $('#myModal_'+this.state.item_id).modal();
    } else {
      $.ajax({
        url: '/deallocate.' + id,
        type: 'get',
        success: function() {
          console.log('deallocated');
        }.bind(this)
      });
    }
  }

  reallocate() {
    $.ajax({
      type: 'post',
      data: {
        'id': document.getElementById("id_"+this.state.item_id).value,
        'item': {
          'user_id': document.getElementById("username").value
        }
      },
      url: '/reallocate',
      success: function() {
        $('#myModal').modal('hide')
        console.log('reallocated');
      }.bind(this)
    });
  }

  render() {
    console.log(this.state.check);
    return(
      <div>
        <input onChange={this.handleClick.bind(this)} type="checkbox" id="checkboxid" defaultChecked={this.state.check}/>

        <div className="modal fade" id={"myModal_"+this.state.item_id} tabIndex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div className="modal-dialog">
            <div className="modal-content">
              <div className="modal-header">
                <button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 className="modal-title" id="myModalLabel">Reallocate User</h4>
              </div>
              <div className="modal-body">
                <h5>whom do you want to reallocate? </h5>
                <input type="hidden" id={"id_"+this.state.item_id} value={this.state.item_id} />
                <select id="username">
                  {
                    this.state.users.map(function(user) {
                      return (
                        <option key={user.id} value={user.id} > {user.first_name} {user.last_name}</option>
                      )
                    })
                  }
                </select>
              </div>
              <div className="modal-footer">
                <button type="button" className="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" onClick={this.reallocate.bind(this)} className="btn btn-primary">Reallocate</button>
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
}
