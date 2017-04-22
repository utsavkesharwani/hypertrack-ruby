[![Gem Version](https://badge.fury.io/rb/hypertrack.svg)](https://badge.fury.io/rb/hypertrack) [![Build Status](https://travis-ci.org/utsavkesharwani/hypertrack-ruby.svg)](https://travis-ci.org/utsavkesharwani/hypertrack-ruby) [![Code Coverage](https://img.shields.io/codecov/c/github/utsavkesharwani/hypertrack-ruby.svg)](https://codecov.io/gh/utsavkesharwani/hypertrack-ruby)

# HyperTrack RubyGem
A RubyGem for [HyperTrack](https://www.hypertrack.io/)'s [Backend API](http://docs.hypertrack.io/docs/getting-started-with-backend-integration)

## Installation

Add this line to your application's Gemfile:
```ruby
gem 'hypertrack', '~> 0.1.0'
```

And then run `bundle install` on command line.

Or install it yourself as: `gem install hypertrack -v 0.1.0`

## Initialization:
```ruby
require 'hypertrack'
HyperTrack.secret_key = "<YOUR_SECRET_KEY>"
```

## HyperTrack - API and Resources

- [User](https://docs.hypertrack.com/v3/api/entities/user.html)
  - [Create](https://docs.hypertrack.com/v3/api/entities/user.html#create-a-user)
    ```ruby
    HyperTrack::User.create(name: "SomeDriver", vehicle_type: "car")
    ```
    
  - [Retrieve](https://docs.hypertrack.com/v3/api/entities/user.html#retrieve-a-user)
    ```ruby
    HyperTrack::User.retrieve(user_id)
    ```
  
  - [List all](https://docs.hypertrack.com/v3/api/entities/user.html#list-all-users)
    ```ruby
    HyperTrack::User.list
    ```

  - [Assign Actions to User](https://docs.hypertrack.com/v3/api/entities/user.html#assign-actions-to-a-user)
    ```ruby
    user = HyperTrack::User.retrieve(user_id)
    user.assign_actions({action_ids: [action_id_1, action_id_2]})
    ```

- [Action](https://docs.hypertrack.com/v3/api/entities/action.html)
  - [Create](https://docs.hypertrack.com/v3/api/entities/action.html#create-an-action)

    ```ruby
    HyperTrack::Action.create(type: 'pickup')
    ```
    
  - [Retrieve](https://docs.hypertrack.com/v3/api/entities/action.html#retrieve-an-action)

    ```ruby
    HyperTrack::Action.retrieve(action_id)
    ```
  
  - [List](https://docs.hypertrack.com/v3/api/entities/action.html#list-all-actions)

    ```ruby
    HyperTrack::Action.list
    ```

  - [Complete](https://docs.hypertrack.com/v3/api/entities/action.html#complete-an-action)

    ```ruby
    action = HyperTrack::Action.retrieve(action_id)
    action.complete()
    ```

  - [Cancel](https://docs.hypertrack.com/v3/api/entities/action.html#cancel-action)

    ```ruby
    action = HyperTrack::Action.retrieve(action_id)
    action.cancel()
    ```
