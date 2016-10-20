class Items extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      items: this.props.items,
      users: this.props.users
    }
  }

  componentWillMount() {
    console.log(this.props.items.map(function(item) {
      return item.user
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
                <th> Allocation Status </th>
             </tr>
    	    </thead>
          <tbody>
            {
              this.state.items.map(item => {
                return (
                  <tr key={item.id} id="item_id">
                    <td>{item.name}</td>
                    <td>{item.unit_price}</td>
                    <td>{item.description}</td>
                    <td>{item.category.name}</td>
                    <td> <Checkbox users= {this.state.users} itemIdProps={item.id} user = { item.user.email } checkedprops={ !item.user.admin } />
                    </td>
                  </tr>
                )
              })
            }
          </tbody>
    	</table>
    );
  }
}
