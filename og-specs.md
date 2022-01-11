# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes) 
    - User has many ratings, User has many pizzas through ratings, restaurant has_many pizzas, pizza has many ratings, pizza has many users through ratings
- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)
    - pizza belongs_to restaurant
    - pizza belongs_to user
- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)
    - User has many pizzas through ratings 
    - Pizza has many Users through ratings 
- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)
    - User has many pizzas through ratings 
    - Pizza has many Users through ratings 
- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)
    - Rating has a title, rate, comment, and URL (youtube link)
- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
    - Username Required & Unique
    - Password Required & Unique (Done through has_secure_password)
    - Restaurant name is requied
    - Restaurant City is required 
    - Restaurnat State is required
    - Pizza specialty_name is required 
    - Rating rate is required - only valid 1-10 decimals
    - Rating title is required
    - Rating comment is required
- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
- [x] Include signup
- [x] Include login
- [x] Include logout
- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
    - Google
- [x] Include nested resource show or index (URL e.g. users/2/recipes)
    -/pizzas/1/ratings/1
    -/pizzas/1/ratings
- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)
    - /pizzas/1/ratings/new
- [x] Include form display of validation errors (form URL e.g. /recipes/new)

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
- [x] Updated Readme 