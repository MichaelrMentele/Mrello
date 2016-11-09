Things to consider:
- initially shipping the app:
    + secondary layer
    + auth, if not signed in, then ship the app, we don't have to worry about auth at this point
    + How do I handle state? When I ship the app... I need to control the session somehow. Restrict certain actions etc.

Backbone doesn't nest params under a models name by resource. This is an issue for strong params. I decided to override the Backbone.sync function to accept an optional paramRoot property on the model. This way I can next that models attributes under the given root. The other way would have been to change the toJSON methon on the model itself which would result in different serialization and deserialization.

How can we handle user authentication? One way to do it is have a filter on the api root application controller that checks for a token being passed in along with the request. Wait. They need to send some information to the backend. We can create a session still. Frontend sends form information. If the user isn't authenticated... Redirect to login page. The router needs to handle this.