Empower
==========

Empower is a pre-configured OmniAuth solution for Ruby on Rails applications.
In contrast to something flexible, like
[OmniAuth](https://github.com/intridea/omniauth), Empower aims to create the
solution simply, quickly, and effectively.

Empower currently supports the following strategies:

* [Facebook](https://github.com/mkdynamic/omniauth-facebook)
* [Google (OAuth2)](https://github.com/zquestz/omniauth-google-oauth2)
* [Twitter](https://github.com/arunagw/omniauth-twitter)

To make this happen, you need to understand what's required from you prior to
using this gem. See below.

Installation
----------

Add this line to your application's Gemfile:

```text
gem 'empower'
```

And then execute:

```text
$ bundle
```

Or install it yourself as:

```text
$ gem install empower
```

Requirements
----------

There are three major prerequisites to using Empower:

* Using/installing [Devise](https://github.com/plataformatec/devise)
* Creating a `User` model
* Add `name` and `image` to your `User` model

Referencing [this section in Devise's
README](https://github.com/plataformatec/devise#getting-started), this means
you should run the following commands:

```text
$ bundle exec rails g devise:install
$ bundle exec rails g devise User
```

Meanwhile, the `empower:install` generator will take care of adding the
migration for the added columns. Just double check it.

Usage
----------

Once Devise is setup and Empower is installed, you can run its generator:

```text
$ bundle exec rails g empower:install
```

Before you begin, replace the `APP_ID` and `APP_SECRET` in
`config/initializers/devise.rb` for each of the strategies you wish to use. If
you don't want to use a strategy, delete it from the Devise config file.

> *Note: I suggest NOT tracking these keys with Git and hiding them someone
> like an environment variable or a private settings file.*

Restart your server and you're ready to go.

Helpers
----------

There is a helper for a sign in button for each of the strategies in the form
of `[strategy]_login_button`. Facebook's looks like this:

```erb
<%= facebook_login_button %>
```

Optionally, you can pass a custom message to the button helper:

```erb
<%= facebook_login_button "Sign In, Friendo!" %>
```

Otherwise, if you want to handle your own links, they would look like this:

```erb
<%= link_to 'Login', user_omniauth_authorize_path(:facebook) %>
```

The odd man out here is Google, which needs to be written like this:

```erb
<%= link_to 'Login', user_omniauth_authorize_path(:google_oauth2) %>
```

Overriding Redirects
----------

When you are signed in successfully through Facebook, Empower uses Devise's
`after_sign_in_path_for` method. You can customize this method in your
application controller

[See this doc page](https://github.com/plataformatec/devise/wiki/How-To
:-redirect-to-a -specific-page-on-successful-sign-in#redirect-back-to-current-
page-after-oauth- signin) for more information.

Gotcha!
----------

There are a handful of quirks in this gem, but I think there are two worthy of
noting over any others

### Consolidating User Accounts

Each individual user needs a unique email address with Devise, which makes
perfect sense. A common issue with OmniAuth is that users signed up for the
various services with different email addresses over the years.

The ways in which I've seen developers circumvent this is convoluted. I like to
keep things simple and so we say *if a social account uses a different email
address, then the user account within your app is a different account.*

That being said, we do consolidate accounts where we can. If, for example, your
Facebook and Google accounts use the same email address, the user account
within your app with be the same.

### No Twitter Email

Twitter, in all its infinite wisdom, will not share email addresses in their
OmniAuth solution. So, we have to create a separate form when the user signs in
so we can capture a real email address.

This solution has several holes in it. There isn't a simple way of ensuring
that they are entering a valid email address or an email address of someone
already using the app.

If this is a concern, I suggest opening a PR to force confirmable on Devise and
working it into this solution.

Contributing
----------

1. Fork it ( https://github.com/[my-github-username]/empower/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
