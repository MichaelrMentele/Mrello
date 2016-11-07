# Data Architecture
Our app contains a single board which can contain multiple lists. A board has lists but also has buttons and a searchbar

Lists can contain multiple cards. A list is a collection of cards.

Cards can contain multiple comments. A card has a collection of comments and an editor view that allows the addition of comments.

# Object Relationships
[diagram]

# Views
We basically have a 1-to-1 mapping of a view for each object. This way we can reference an object in the same context as events that would modify them.

# Design Choices
What I could have done is removed some of the extra layers. Some of the pieces of code are pretty small and don't handle much. The board in particular (with the search bar and add list) could very easily be merged into the App object. I decided to leave it for ease of future extensibility. If I wanted to add more UI I wouldn't necessarily want to clutter my app object which is responsible for holding global data such as templates, contructor functions and data. The App object fuels the app, provides a namespace, and global consumable data objects. I want to abstract business logic to the models and UI logic to views.

# Challenges
- Loads of features
- Not knowing a framework
- New features

# Dealing With Features
I basically prioritized and set stretch goals. Having lists and cards was a big deal so I got that going first. Next was being able to edit the card. I made a mistake here and went with adding comments instead of modifying the card data. The most common use is changing the card and moving it about on the board. I only partially implemented drag and drop. While you can drag and drop it doesn't update the data object. I was unsure about how to implement this and had to either redesign my DOM system to store references on the DOM and then read them and update the model and collection to reflect aggregrates from DOM traversal (something I thought was really inelegant) or I needed to figure out a way to access the data through my view. I chose Dragula for drag and drop for simplicity however this was a mistake as it didn't provide any methods for connecting my drag events to the relevant view. I ran out of time experimenting with a way of getting that event on my view and fizzled.

# Not Knowing a Framework
This was very UI intensive. Trello has tons of pop up menus, views, etc. The data side was simple so what hurt me was not having a quick way to mock up the CSS and HTML. Not to mention common JS events. I supplemented where I could with JQuery UI, simple grid, and plug ins as needed however this was a major problem as I had to refactor and generalize for behaviors throughout the site. I think this was the biggest time suck. If I was familiar with Bootstrap or Foundation then this would have gone much faster.

# New Features
I've never worked with drag and drop before and wasn't sure how to make it work with backbone. I also was new to jQuery UI and due to time pressure opted for a simpler drag & drop library that backfired. So, lack of experience was a real factor here in dragging things out. 
