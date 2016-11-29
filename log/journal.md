11-29
Consider removing all templates for each resource but the show and the index action. Everything else is pretty much redundant.

11-27 
Need to architect at a high level to ensure I'm not getting lost in the churn.

Going to create paper model. Think about client side architecture.

11-27
Removing ownership. 

11-26 
When an organization creates a board how does that work?

What is the point of an ownership? Does an org and a user have just one? Because an ownership can have many boards. I'm not sure an ownership is even necessary...

11-26
Note: It would be nice to refactor so that there is a route for organization owned boards and user owned boards. We could use a namespace. 

11-26
Adding boards. Refactoring tests.

11-25
In the middle of adding a board and trying to figure out how to ignore log files after committing them.

11-5
Things to consider:
- initially shipping the app:
    + secondary layer
    + auth, if not signed in, then ship the app, we don't have to worry about auth at this point
    + How do I handle state? When I ship the app... I need to control the session somehow. Restrict certain actions etc.

Backbone doesn't nest params under a models name by resource. This is an issue for strong params. I decided to override the Backbone.sync function to accept an optional paramRoot property on the model. This way I can next that models attributes under the given root. The other way would have been to change the toJSON methon on the model itself which would result in different serialization and deserialization.

How can we handle user authentication? One way to do it is have a filter on the api root application controller that checks for a token being passed in along with the request. Wait. They need to send some information to the backend. We can create a session still. Frontend sends form information. If the user isn't authenticated... Redirect to login page. The router needs to handle this.