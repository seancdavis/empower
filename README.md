Empower
==========

Empower is a pre-configured OmniAuth solution for Ruby on Rails applications.
In contrast to something flexible, like
[OmniAuth](https://github.com/intridea/omniauth), Empower aims to create the
solution simply, quickly, and effectively.

To make this happen, you need to understand what's required from you prior to
using this gem. See below.

> **Note: At this time, there are no configuration options, and Empower only
> supports Facebook authentication.** This will change soon.

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

There are two major prerequisites to using Empower:

* Using/installing [Devise](https://github.com/plataformatec/devise)
* Creating a `User` model

Referencing [this section in the
README](https://github.com/plataformatec/devise#getting-started), this means
you should run the following commands:

```text
$ bundle exec rails g devise:install
$ bundle exec rails g devise User
```

Usage
----------

Once Devise is setup and Empower is installed, you can run its generator:

```text
$ bundle exec rails g empower:install
```

Before you begin, replace the `APP_ID` and `APP_SECRET` in
`config/initializers/devise.rb` with your Facebook's keys.

> *Note: I suggest NOT tracking these keys with Git and hiding them someone
> like an environment variable or a private settings file.*

Restart your server and you're ready to go.

Helpers
----------

There is one helper, and that is a Facebook sign in button.

```erb
<%= facebook_login_button %>
```

Otherwise, if you want to handle your own links, they would look like this:

```erb
<%= link_to 'Login', user_omniauth_authorize_path(:facebook) %>
```

Overriding Redirects
----------

When you are signed in successfully through Facebook, Empower uses Devise's
`after_sign_in_path_for` method. You can customize this method in your
application controller

[See this doc page](https://github.com/plataformatec/devise/wiki/How-To
:-redirect-to-a -specific-page-on-successful-sign-in#redirect-back-to-current-
page-after-oauth- signin) for more information.

Contributing
----------

1. Fork it ( https://github.com/[my-github-username]/empower/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
