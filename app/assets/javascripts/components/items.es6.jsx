class Items extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
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
                <th> Allocate/Deallocate </th>
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
                  </tr>
                )
              })
            }
          </tbody>
    	</table>
    );
  }
}
