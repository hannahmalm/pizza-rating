***Update Readme***
Resources - apidoc.com
- rails new pizza-rating
- Run 'rails routes' to see the routes provided
- Class.find(id).destroy

Action Steps
1. Draw out models and relationships and create them and migrate
2. Add in any beggining validations
    - Pizza Model   
        - belongs to user
        - belongs to restaurant
        - has many ratings
        - has many ratings through users
        - Validates specialty name
        - Validates toppings
    - Rating Model
        - belongs to user
        - belongs to pizza
        - Validates title, rate, comment
    - Restaurant Model
        - has many pizzas
    - User Model
        - has_secure_password
        - Validates username
3. Create an index page within Sessions
    - Rails does all the session secret and session information for us so we dont have to specify in application controller
    - Create sessions controller
        a. Create the index method 
            - #GET / sessions#index
            - def index --> This will implicitly render the session/index view
    - Create sessions view file
        - Create index.html.erb *This is the main page that has the option to log in or sign up* 
            - Has link_to path was to login(login_path), signup(signup_path), and signup with oauth(not a path helper - custom)
    - Create route associated with index 
           - get '/' => 'sessions#index'
4. Create a login (new session) page within Sessions
    - Create new method in sessions controller
        - def new 
        -  In sinatra it would have been #GET /login - login action
    - Create new session (login) view file
        - Create new.html.erb *This is the login page* 
                - Use a form_for and pass in user params
                *** must pass in :user as a symbol instead of @user - doc here: https://www.reddit.com/r/rubyonrails/comments/21bfyf/difference_between_form_foruser_and_form_foruser/**
                - text field for username and password field for password
    - Create a route associated with new session (login)
        -   get '/login' => 'sessions#new' This starts a new session when a user logs in 
        - User does not actually get logged in until it posts to the create method
5. Create a login POST page within Sessions
    - Create new method in sessions controller
        - def create
        - In Sinatra it would have been POST /login(.:format) sessions#create
        **A user can log in two ways: through Oauth or Normal Way**
        *Normal Way*
            - params need to be specified as user
            - @user = User.find_by(username: params[:user][:username])
            - if @user.try(:authenticate, params[:user][:password]) then set the session and redirect to user path, else error and redirect to login
        *Oauth Way*
            - params need to be specified as provider (params[:provider] == 'google_oauth2')
            - add in omniauth gem
            - add in omniauth provider gem
            - add in dotenv gem to see secret information
            - add a new file under initilaizers - add omniauth.rb - this code will be different based on provider
            - add in .env file - you will need the id and secret keys 
                - https://console.cloud.google.com/projectselector2/apis/dashboard?pli=1&supportedpurview=project
                - create a new project
                - once in the project, add the credentials
                - Click credentials then click, create credentials, then click OAuth client id
                - add the url under authorized urls: http://localhost:3000/auth/google_oauth2/callback
                - click save and the credentials will appear 
            - add in link within the index page to give the option of signing in with google 
            - add in a route in routes file - receive request then send to sessions cotroller 
                - get '/auth/google_oauth2/callback' => 'sessions#omniauth'
                ** get '/auth/:provider/callback' => 'sessions#create' ** This is the updated dynamic route if you have multiple providers 
                - add in an omniauth method in sessions controller 
                - https://stackoverflow.com/questions/11485271/google-oauth-2-authorization-error-redirect-uri-mismatch
            - add in omniauth method within the sessions controller
                - this method links to a method in the User model called User.find_or_create_by_google(auth)
                    - This method is used to find or create a user based on the email that is brought back in the google authentication 
                    - there is also a private method created for auth on the sessions controller - this will be used to return the request .env 
                     def self.find_or_create_by_google(auth)
                    ** User.find_or_create_by(username: auth[:info][:email]) do |u|
                        u.password = SecureRandom.hex #set a random password when using omniauth and SecureRandom.hex
                    end **
            - @user = User.find_or_create_by_google(auth_hash) then set the session and redirect to user page
    - No new view needs to be created since this is a POST of the login form
    - Create a route associated with POSTing a new session and actually loggin in 
        - post '/login' => 'sessions#create' #post the login information to create the session
6. Create logout
    - Create sessions destroy (logout) method
        -  session.delete(:user_id) then redirect to the index page
        - In rails, use delete instead of .destroy when using sessions
    - Create logout button in view (within the partial "_header.html.erb")
        - <%= link_to "Logout", logout_path, method: :delete %>
    - Create logout route
        - delete '/logout' => 'sessions#destroy'
7. Create a new user (GET Signup form)
    -  **IT IS THE JOB OF THE USER TO SIGN UP, NOT THE SESSION ****
    - Create users controller and new method
        - def new
        - must include @user = User.new 
        - This will implicitly render the sigup form (users/new.html.erb)
        - Will pass in instance variable @user into params form_for
    - Create users new view
        - users/new.html.erb
        - Create a form_for user and pass in @user 
        - Username text field and password Password field
    - Create users new route
        - get '/signup' => 'users#new'
8. Create new user (POST Signup)
    - Create users controller create method
        - def create
        -  @user = User.new(user_params) - initialize a new user with private method params
        - if the user saves, set the session and redirect to user show page
        - You do not need a post route
9. Create Users Show (Users/:id - Users homepage)
    - Create users controller 
        - def show
        - @user = User.find_by_id(params[:id])
    - Create users show view
        - users/show.html.erb
        - This page shows all the pizzas a user creates
        - it has a link to add new ratings and list the specailty name and the restaurant of the pizza (created in pizza model)
        - The Pizza path takes you to pizza/:id and shows a table of the Pizza details
    - Create users route
        -   resources :users
10. Create a new Pizza ()
    - Create Pizza controller and new method
        - def new
        -  @pizza = Pizza.new 
        -  @pizza.build_restaurant (Tell Pizza to also build a restaurant because its in a nested form)
        - When a user submits the original form, the controller action is to create a new instance of a Pizza
        - With the nested form, we also need to create a new instance of an restaurant, and associate that restaurant with the Pizza. This is accomplished with the build method.
        - Ensure that you accept nested attributes in the private method pizza_params
    - Create Pizza new view and form
        - Create a form with the normal specialty name and toppings
        - Create a nested form with restaurant options
        - Allow for a dropdown using collection select: <%= f.collection_select :restaurant_id, Restaurant.all, :id, :name, include_blank: 'Select Restaurant' %>
    - Create Pizza New route
        - resources pizza 
    - Update Pizza Model
        - accepts_nested_attributes_for :restaurant (need this to accept adding a restaurant in a nested form and allowed in the Pizza strong params)
        - Need to also update the attributes section by doing the following: This will allow you to save the dropdown value if not creating a new restaurant
            def restaurant_attributes=(attributes)
                self.restaurant = Restaurant.find_or_create_by(attributes) if !attributes['name'].empty?
                self.restaurant
            end
            - This says that Pizza associated with a restaurant is created or found by attributes by looking at the name field 
        - https://levelup.gitconnected.com/rails-nested-forms-in-three-steps-5580f0ad0e
11. Create all Pizza Index page
    - Create Pizza controller and index method
    - Create Pizza index view
    - Create Pizza index route
        
    

--------------------------------------------------------------------------------------
1. Create Models & Migrate - rails g resource User username:string password_digest:string 
    - repeat this until all models are created and run rails db migrate
    - you can also type 'rails g model User username:string'
2. Add in any basic validations, belongs_to, has_many and has_secure_password in User 
    - ensure you enable bcrypt app - bcrypt will hash and salt the password so we cant see this in my database
3. Add in session controller 
    - The session is responsible for logging in/out a user - These must be plural
    - rails g controller Pizzas
    - rails g controller Restaurants
4. Add in session(Login/Logout) routes 
    - It is the job of the session to view the index page
         get '/' => 'sessions#index'
    - It is the job of the session to login - Need to get and Post to login
        get '/login' => 'sessions#new' #this starts a new session when a user logs in 
        post '/login' => 'sessions#create' #post the login information to create the session
    - It is the job of the session to logout 
        delete '/logout' => 'sessions#destroy' #destroy the session when a user logs out
    -  **IT IS THE JOB OF THE USER TO SIGN UP, NOT THE SESSION ****
        get '/signup' => 'users#new'
5. Add in methods within session controller
    index - allows the index page to load --> correlates with sessions>index.html.erb
    destroy - allows a user to log out --> correlates with the layouts>application.html.erb (Logout is within the nav bar) **Remember that you do not create a specific logout OR create view**
    new - nothing within this method, but allows a user to login --> correlations with sessions>new.html.erb (login screen)
    create - correlates to the login
        - Here we try to find the user in the system
        - Did we find someone and did they put in the correct password? Authenticate them
        - If we cannot auhenticate them, give a flash error - **Reflect this flash error within the session new.html.erb** 
6. Add in Views within the session views
    - sessions>index.html.erb (correlates with session controller index method - shows basic welcome page)
    - sessions>new.html.erb (correlates with session controller new method - shows login form)

7. Add in methods within the User controller
    - new 
    - create 
    - show 
    - private methods: Only public methods are callable as actions. It is a best practice to lower the visibility of   methods (with private or protected) which are not intended to be actions
        - user_params
            - 2 kinds of params in rails:
            -  query string params (sent as part of url - everything after the ? in the url)
            - POST data params (comes from an HTML form which has been filled in by the user sent as part of an HTTP   POST request)

8. Add in Views within the user views
        - users > new.html.erb
            - Sign up *It is the job as the User to sign up and create a new user*
        - users > show.html.erb 
            - Shows the user name and user account 
9. Add in new Pizza link into the navbar on the layout application  
    - To see the correct link_to path that you need, type in rails routes
    - Add in the path 

10. Add in methods within the pizza controller
  - Create a "new" method 
  - Create an "index" method 
11. Add in pizza views
    - pizza > index.html.erb 
        - create a new form_for :pizza 
            - Use form_for instead of form tag
                - Use form_for when you are creating a form for a model object - CRUD
        - create a nested form within pizza to create a restaurant within the pizza form    
            - use form_for
    - pizza > new.html.erb 
12. Add in Restaurnat Controllers/Views
13. Add in Ratings Controllers/Views
    - The rating will be within the nested form
14. Add appropriate error messages
    - Add a partial to the layouts view for create error views 
    - Added in a standard error boiler plate that is saying the number of errors and what the error was.
    - render the error partial in the views 
        <%= render '/layout/errors, locals: {zone: @zone}>'
    - Remember that validations happen when something is saved using .save
    - https://guides.rubyonrails.org/active_record_validations.html#performing-custom-validations
15. Omniauth
    
    - Trying Omniauth with GitHub
        - https://github.com/settings/applications/new
        - register a new OAuth Application
        - Homepage url: http://127.0.0.1:3000/
        - Authorization Callback URL: http://127.0.0.1:3000/auth/github/callback
        - add in omniauth-github gem and bundle install
        - add in link within index page to sign in via github
        - The omniauth.auth key in the environment hash provides an Authentication Hash which will contain information about the just authenticated user including a unique id, the strategy they just used for authentication, and personal details such as name and email address as available. 
        * Behind the scense with Omniauth 
            1. Goes to root route or index route (wherever is logging in from)
            2. Follows /auth/:provider/callback route (callback just tells the server where to go after authenticating)
            3. User is logged in via the SESSION. Remember that is the job of the session to log someone in.
            4. After logged in, it takes user back to root route
            5. erb file is rendered 
16. Adding in Photos
    - Run commands in terminal
    - rails active_storage:install - creates a new migration which allows to store pics 
    - run rake db:migrate
    - tell app where to store information 
    - activestorage is the way to add in photos and images - newer piece of rails 
    - Add images to Pizza class using 'has_one_attatched :image'
    - add in label within pizza new form to give user a place to put image 
    - add in a new param within the pizza controller - add :image into params for pizza 
    - add in an image tag within show.html.erb for pizza - add an if statement to see if an image is attatched 
    - IF YOU WANT TO DO THIS IN AMAZON:
        - Set up AWS account - S3 Storage - Create a Bucket
        - change config/production.rb to config.active_storage.service = :amazon
        - in storage.yml, uncomment out the amazon file service information 
        - ensure region matches the region in your bucket 
        - ensure the bucket name matches your bucket 
        - change access_key_id credentials - this only works with Rails5, credentials file is encrypted - you can push to github but noone can see it. 
        - add in gem 'aws-sdk-s3', require: false 
        - bundle install 
        - master.key is the encyrption key to unmask the file - master key cannot get pushed to github
        - add in access key and secret access key in the credentials.yml
        - in amazon, it will only show you credentials once 

     <!-- <a href="/users/<%=current_user.id%>">Back to account</a>-->


     <!--Example of using a form tag-->
<!--Form tags are used when you dont have a model or want to make custom URLS-->
<!--<%= form_tag("/useres") do -->
<!-- label_tag "Username:" %> -->
<!-- text_field_tag "username" %> -->
<!-- <%= submit_tag "Sign Up" %> -->
<!-- <%end%>  -->