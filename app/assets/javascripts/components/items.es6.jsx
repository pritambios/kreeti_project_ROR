class Items extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      users: this.props.users
    }
  }
  componentWillMount() {
    console.log(this.props.users.map(function(item) {
      return item.email
    }));
  }
  render () {

    return (
    	<table className="table table-bordered">
    	    <thead>
    	       <tr>
                <th> Name </th>
                <th> Price </th>
                <th> Description </th>
                <th> Category </th>
                <th> Allocate/Deallocate </th>
                <th> User name </th>
             </tr>
    	    </thead>
          <tbody>
            {
              this.props.items.map(item => {
                return (
                  <tr key={item.id}>
                    <td>{item.name}</td>
                    <td>{item.unit_price}</td>
                    <td>{item.description}</td>
                    <td>{item.category.name}</td>
                    <td> <Checkbox users= {this.state.users} itemIdProps={item.id} checkedprops={!item.user.admin} />
                    </td>
                    <td></td>
                  </tr>
                )
              })
            }
          </tbody>
    	</table>
    );
  }
}

class Checkbox extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      checked: this.props.checkedprops
    }
  }

  handleClick() {
    var checkbox = document.getElementById("checkboxid");
    if(checkbox.checked) {
      $('#myModal').modal();
    } else {
      $.ajax({
        url: '/deallocate.' + this.props.itemIdProps,
        type: 'get',
        success: function() {
          console.log('hello');
        }.bind(this)
      });
    }
  }
  reallocate() {
    $.ajax({
      url: '/deallocate.' + this.props.itemIdProps,
      type: 'get',
      success: function() {
        console.log('hello');
      }.bind(this)
    });
  }
  render() {
    return(
      <div>
        <input onChange={this.handleClick.bind(this)} type="checkbox" id="checkboxid" defaultChecked={this.state.checked}/>

        <div className="modal fade" id="myModal" tabIndex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
          <div className="modal-dialog">
            <div className="modal-content">
              <div className="modal-header">
                <button type="button" className="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 className="modal-title" id="myModalLabel">Reallocate User</h4>
              </div>
              <div className="modal-body">
                <h5>whom do you want to reallocate? </h5>

                <select>
                  {
                    this.props.users.map(function(user) {
                      return (
                        <option key={user.id} value={user.id}> {user.first_name} {user.last_name}</option>
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
class Users extends React.Component {
  render() {
    return(
      <select>
        {
          this.props.users.map(function(user) {
            return (
              <option key={user.id} value={user.id}> {user.first_name} {user.last_name}</option>
            )
          })
        }
      </select>
    )
  }
}
