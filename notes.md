***Update Readme***
Resources - apidoc.com
Run 'rails routes' to see the routes provided
1. Create Models & Migrate - rails g resource User username:string password_digest:string 
    - repeat this until all models are created and run rake db migrate
2. Add in any basic validations, belongs_to, has_many and has_secure_password in User 
    - ensure you enable bcrypt app - bcrypt will hash and salt the password so we cant see this in my database
3. Add in session controller 
    - The session is responsible for logging in/out a user
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