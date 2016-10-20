class Modal extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: this.props.users,
      item_id: this.props.item_id,
      check: this.props.check
    }
    this.showModal = this.showModal.bind(this);
  }

  componentDidMount() {
    this.showModal();
  }

  componentWillReceiveProps(nextProps) {
    this.setState({
      item_id: nextProps.item_id
    })
    this.showModal();
  }

  reallocate(e) {
    $.ajax({
      type: 'post',
      data: {
        'id': this.state.item_id,
        'item': {
          'user_id': document.getElementById("username").value
        }
      },
      url: '/reallocate',
      success: function() {
        this.props.reallocateSuccess();
        $('#myModal').modal('hide');
      }.bind(this)
    });
  }

  showModal() {
    $('#myModal').modal();
  }

  render() {
    return (
      <div>
      <div className="modal fade" id={"myModal"} tabIndex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div className="modal-dialog">
          <div className="modal-content">
            <div className="modal-header">
              <button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
              <h4 className="modal-title" id="myModalLabel">Reallocate User</h4>
            </div>
            <div className="modal-body">
              <h5>whom do you want to reallocate? </h5>
              <select id="username">
                {
                  this.state.users.map(user => {
                    return (
                      < option key={user.id} value={user.id} > {user.first_name} {user.last_name}</option>
                    )
                  })
                }
              </select>
            </div>
            <div className="modal-footer">
              <button type="button" className="btn btn-default" onClick={this.props.modalClose}>Close</button>
              <button type="button" onClick={ this.reallocate.bind(this) } className="btn btn-primary">Reallocate</button>
            </div>
          </div>
        </div>
      </div>
      </div>
    )
  }
}
