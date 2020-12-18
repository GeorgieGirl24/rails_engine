# Rails Engine

This e-commerce application allows a user to access various API endpoints.

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install](#how-to-install)
  - [Testing](#testing)
  - [Example Usage](#feature-tests)
  - [Licenses](#licenses)
  - [Contact](#contact)
  - [Acknowledgments](#acknowledgments)
  
## What it does 
* This is an E-Commerce Application that is working in a service-oriented architecture. This means that ther is a front-end app that communicates via an API with the back-end app. The back-end's role is to expose the API, while the front-end is consuming that API 
  
  
  
  

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
  
  

### Request & Facade Tests
* These integration-level tests ensure that compontents interact together in the expected manner
  
  This is an example of an integration test
  
<img scr="/read_me_folder/request_spec_image.png" width="400">
  




```
bundle exec rspec spec/features/harness_spec.rb

```
![](/read_me_folder/request_spec_image.png)


<img src="/read_me_folder/TestCoverage.png" width="600">

- [ ] How to set up the dev environment

![picture](read_me_folder/request_spec_image.png)
### Schema

<p align="center">
 <img src="/read_me_folder/schema_image.png">
</p>

## Example Usage

- [ ] Example Usage

## Licenses

* Ruby 2.5.3
* RSpec

## Contact 

George Soderholm (https://www.linkedin.com/in/george-soderholm-05776947/)
[RailsEngine](https://github.com/GeorgieGirl24/rails_engine)

## Acknowledgments
* My Instructors: Dione and Ian
* My 2008 cohort mates who answered questions and gave feedback









