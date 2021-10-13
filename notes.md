1. Create Models & Migrate - rails g resource User username:string password_digest:string 
    - repeat this until all models are created and run rake db migrate
2. Add in any basic validations, belongs_to, has_many and has_secure_password in User 
    - ensure you enable bcrypt app 
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