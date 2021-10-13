1. Create Models & Migrate - rails g resource User username:string password_digest:string 
    - repeat this until all models are created and run rake db migrate
2. Add in any basic validations, belongs_to, has_many and has_secure_password in User 
    - ensure you enable bcrypt app 
3. Add in session controller 
    - The session is responsible for logging in/out a user
4. Add in 