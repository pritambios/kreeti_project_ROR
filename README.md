# Inventory management system
User should be able to keep track of inventory of items.

To do this end -
* Users should be able to add / edit items to the system.
* Each item can belong to a category, and it should be possible to create, list, view, edit and delete categories.
* Category names should be unique.
* Each item will also belong to a brand, and it should be possible to create, list, view, edit and delete brands.
* Brand name should be unique.

Rails extension
* Users should be able to sign in the system if he / she does not have any account and will be required to provide name, email id & password while creating account for the first time.
* If the user is an existing user then he / she will be able to login the system.
* While logging in the system if the user email / password provided is wrong then it will show appropriate error messages.
* The system should display the name of the user on the upper right corner of the page when that specific user logs in and will show it as long as the user stays logged in.
* Items of a particular category / brand can be allotted to a person.
* System should store details of the person to whom the item has been allotted like - person’s name, email, mobile number, etc.
* If an item is reallotted to another person then system should also keep track of those allotments i.e system should keep track of the total allotment history.
* It should be possible to deallocate an item.
* There should be a functionality to see the details of the allotment history for each item.
* It should be possible to see all the items allotted to a person

react extension
*There will be a single page where user will be able to see all the items in a tabular format containing the items basic info(name, price, description, category) and column containing a checkbox, User can allocate or deallocate by clicking that checkbox.