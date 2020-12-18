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

Fork and clone this repo

Then your terminal, create a directory called `rails-engine` ('mkdir rails-engine')

Step inside the `rails-engine` directory ('cd rails-engine')

Now add the cloned version of this repo by typing in the terminal:

`git clone git@github.com:<your github_username>/rails_engine.git`

Inside the `rails-engine` directory, open you text editor ('cd rails-engine')

In the terminal run `bundle install`, then `rails db:{drop,create,migrate,see}`

Cool, now that the back-end portion of this project is install, you'll need the front-end portion as well!

Fork and clone Rails Driver from this [link](https://github.com/turingschool-examples/rails_driver)

Navigate yourself out of the directory `rails_engine` (cd ..), but still inside `rails-engine` 

Then type in the terminal:

`git clone git@github.com:turingschool-examples/rails_driver.git`

The file tree should look like 

```rails-engine
   |
   |___rails_engine
   |
   |___rails_driver
   ```
Great the two pieces of the project are in place. Now we need to get our 'local host' up and running.

Each repo will need a dedicated port to run on and be able to communicate with other repo. Rails Engine is already set up to run on `localhost:3000`

So in your terminal, navigate into the `rails_driver` (cd rails_driver), then hit the 'command' + 't' to open another terminal window

`rails s -p 3001` (great, let's do the same for the Rails Engine). First we need to open another terminal window. Hit 'command' + 't'

Navigate out of rails_driver and then back into rails_driver

Inside the rails_engine directory, hit the 'command' + 't' to open another terminal window (yes, 4 terminal windows should be open)

Type `rails s`

With this last command there should be a terminal window that is open for `rails_engine`, and it's running server. As well, as a terminal window for `rails_driver` and it's server









- [ ] How to set up the dev environment

## Testing 

## Example Usage

- [ ] Example Usage

## Acknowledgments

## Contact

George Soderholm [LinkedIn] (https://www.linkedin.com/in/george-soderholm-05776947/)








