# Rails Engine

This e-commerce application allows a user to access various API endpoints.

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install Rails Engine](#how-to-install-rails-engine)
  - [Testing](#testing)
  - [Learning Goals](#learning-goals)
  - [Licenses](#licenses)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)
  
## What it does 
* This is an E-Commerce Application that is working in a service-oriented architecture. This means that there is a front-end app that communicates via an API with the back-end app. The back-end's role is to expose the API, while the front-end is consuming that API.  
 
 * To see a list of all the data that can returned, check out 
   ```
    RailsEngine.postman_collection.json
   ```
    in the file tree above. This shows the expected data structures for all the possible requests.
  
## How to Install Rails Engine
To install and run this application locally:

1. To setup the repository locally, from your command line:

  ```
  $mkdir rails-engine
  $cd rails-engine
  $git clone git@github.com:georgiegirl24/rails_engine.git
  $bundle
  $rails db:{drop,create,migrate,seed}
  $cd ..
  ```
  
  Fork and clone Rails Driver from this [link](https://github.com/turingschool-examples/rails_driver)

  ```
  $git clone git@github.com:turingschool-examples/rails_driver.git
  ```
  
  The file tree should look like: 

  ```
  rails-engine
     |
     |___rails_engine
     |
     |___rails_driver
   ```
   
2. Now we need to get our 'local host' up and running. Rails Engine is already set up to run on `localhost:3000`

  From inside `rails_driver`, hit the `'command' + 't'` to open another terminal window

  Execute: 
  
  ```
  rails s -p 3001
  ``` 
  
  Open another terminal window with `'command' + 't'`

  Navigate into rails_engine directory, then with the `'command' + 't'` open another terminal window (yes, 4 terminal windows should be open)

  Execute:
  ```
  rails s
  ```
  The Rails Driver will be running on `localhost:3001` and Rails Engine will be running on `localhost:3000`
  
3. Open your web browser adn navigate to http://localhost:3001

## Dependencies

* This application does use `jsonapi-serializer`. This steps up the serialization process. Please add this to the Gemfile.

  ```
  gem 'jsonapi-serializer'
  ```
  
* This application does use `rack-cors`. This allows the front-end and the back-end parts of the program to run servers at the same time. Please add this to the Gemfile.

  ```
  gem 'rack-cors'
  ```
  Then inside `config/initializers/cors.rb` add this snippet of code
  
  ```
  Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'example.com'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
  ```

## Testing 
This application uses the below test suit:

```
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'nyan-cat-formatter'
  gem 'rspec-rails'
  
```
### Model & PORO Tests
* These unit-level tests ensure that the smallest compontents are behaving in the expected manner
  
  *This is an example of a unit test*
  
  <p align="center">
 <img src="https://imgur.com/XA5ZSb9.png">
  </p>
  
### Request & Facade Tests

* These integration-level tests ensure that compontents interact together in the expected manner
  
  *This is an example of an integration test*
  
  <p align="center">
 <img src="https://imgur.com/kiS6BYg.png">
  </p>
 
 * All tests are passing and the coverage for this application is:
<p align="center">
 <img src="https://imgur.com/X4QPNOZ.png">
</p>


### Schema
  *A visual idea of how the tables are interacting together*
<p align="center">
 <img src="https://imgur.com/TeAclim.png">
</p>

## Learning Goals

* Expose an API

* Use Serializers to format JSON response

  <p align="center">
   <img src="https://imgur.com/FVjGJDa.png">
  </p>
  
* Test API exposure

* Compose advanced ActiveRecord queries to analyze information stored in SQL databases

   <p align="center">
     <img src="https://imgur.com/e1NRFSF.png">
   </p>

  <p align="center">
    <img src="https://imgur.com/66KdS9O.png">
  </p>

* Write basic SQL statements without the assistance of an ORM

## Licenses

* Ruby 2.5.3
* RSpec

## Resources

- [jsonapi-serializer](https://github.com/jsonapi-serializer/jsonapi-serializer)
- [factory-bot](https://medium.com/@JPLynch35/crank-out-tests-with-factory-bot-and-faker-e83a31a7693c)

## Contact 

George Soderholm (https://www.linkedin.com/in/george-soderholm-05776947/)
[RailsEngine](https://github.com/GeorgieGirl24/rails_engine)

## Acknowledgments
* My Instructors: Dione and Ian
* My 2008 cohort mates who answered questions and gave feedback









