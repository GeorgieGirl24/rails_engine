# Rails Engine

- [ ] Badges (of Software used)
- [ ] Intro

## Table of Contents
  - [What it does](#what-it-does)
  - [How to Install](#how-to-install)
  - [Testing](#testing)
  - [Example Usage](#feature-tests)
  - [Licenses](#licenses)
  - [Project Leads](#project-leads)
  - [Acknowledgments](#acknowledgments)
  
## What it does 
  RailsEngine is a front-end and back-end application that communicate through an API. RailsDriver is the front-end portion, while RailsEngine is the back-end portion. 
  [RailsEngine](https://github.com/GeorgieGirl24/rails_engine)
  
  

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
These unit-level tests ensure that the smallest compontents are behaving in the expected manner

### Request & Facade Tests
These integration-level tests ensure that compontents interact together in the expected manner


![](/read_me_folder/TestCoverage.png)
- [ ] How to set up the dev environment



## Example Usage

- [ ] Example Usage

## Acknowledgments

## Contact

George Soderholm [LinkedIn] (https://www.linkedin.com/in/george-soderholm-05776947/)








