# dns-manager

`dns-manager` is a Rails 6.0 application allowing you to create DNS zones and records through the [NS1 API](https://ns1.com/).

## Requirements

In order to get this project up and running, you'll need the following:

* Ruby 2.5.x+
* PostgreSQL
  * (This app was created with 9.4 because that's evidently what I had on my personal computer.)
* NS1 API credentials

Note: I deliberately skipped adding Webpacker/Javascript to this application (they come with Rails 6 by default) in order to reduce system requirements. This application is only meant to be an MVP of the DNS service, so a fully interactive UI isn't necessary at this phase of the project.

## Setup

To get going, clone this repository, then run:

```
bin/setup
```

This will install the necessary dependencies and prepare your database.

## Testing

To run the test suite, run:

```
bundle exec rake
```

This application uses RSpec for testing (this is the Ruby testing framework that I'm most familiar with).
