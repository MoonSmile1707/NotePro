# Rails Internationalization (I18n) API

<hr/>

## How I18n in Ruby on Rails Works

The Rails I18n API focuses on:

- Providing support for English and similar languages out of the box.
- making it easy to customize and extend everything for other languages.

As part of this solution, **every static string in the Rails framework** -e.g Active Record validation messages, time and date formats - **has been internationalized.** _Localization_ of a Rails application means defining translated values for these strings in desired languages.

### The Overall Architecture of the Library

Thus, the Ruby I18n gem is split into two parts:

- The public API of the i18n framework - a Ruby module with public methods that define how the library works.
- A default backend(which is intentionally named Simple backend) that implements these methods.

### The Public I18n API

The most important methods of the I18n API are:

    translate # Lookyp text translations
    lacalize # Localize Date and Time objects to local formats

These have the aliases #t and #l so you can use them like this:

    I18n.t 'store.title'
    I18n.l Time.now

There are also attribute readers and writers for the following attributes:

    load_path                 # Announce your custom translation files
    locale                    # Get and set the current locale
    default_locale            # Get and set the default locale
    available_locales         # Whitelist locales available for the application
    enforce_available_locales # Enforce locale whitelisting (true or false)
    exception_handler         # Use a different exception_handler
    backend                   # Use a different backend

## Setup the Rails Application for Internationalization

### Configure the I18n Module

Rails add all .rb and .yml files from the config/locales directory to the **translations load path**, automatically.

The default en.yml locale in this directory contains a sample pair of translationn strings:

```yml
en:
  hello: "Hello world"
```

The **translation load path**(I18n.load_path) is an array of paths to files that will be loaded automatically.You can change the default locale as well as configure the translations load paths in config/application.rb as follows:

```ruby
# config/initializers/locale.rb

# Where the I18n library should search for translation files
I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]

# Whitelist locales available for the application
I18n.available_locales = [:en, :pt]

# Set default locale to something other than :en
I18n.default_locale = :pt
```

### Managing the Locale across Requests

The default locale is used for all translations unless I18n.locale is explicitly set.

The locale can be set in a before_action in the ApplicationController:

```ruby
before_action :set_locale

def set_locale
  I18n.locale = params[:locale] || I18n.default_locale
end
```

This example illustrates this using a URL query parametr to set the locale(e.g: http://example.com/books?locale=pt)

#### Setting the Locale from the Domain Name

This has several advantages:

- The locale is an obvious part of the URL.
- Peoplee intuitively grasp in which language the content will be displayed.
- It is very trivial to implement in Rails.
- Search engines seem to like that content in different languages lives at different, inter-linked domains.

You can implement it like this in your ApplicationController:

```ruby
before_action :set_locale

def set_locale
  I18n.locale = extract_locale_from_tld || I18n.default_locale
end

# Get locale from top-level domain or return +nil+ if such locale is not available
# You have to put something like:
#   127.0.0.1 application.com
#   127.0.0.1 application.it
#   127.0.0.1 application.pl
# in your /etc/hosts file to try this out locally
def extract_locale_from_tld
  parsed_locale = request.host.split('.').last
  I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
end
```

We can also set the locale from the subdomain in a very similar way:

```ruby
# Get locale code from request subdomain (like http://it.application.local:3000)
# You have to put something like:
#   127.0.0.1 gr.application.local
# in your /etc/hosts file to try this out locally
def extract_locale_from_subdomain
  parsed_locale = request.subdomains.first
  I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
end
```

if your application includes a locale switching menu, you would then have something like this in it:

```ruby
link_to("Deutsch", "#{APP_CONFIG[:deutsch_website_url]}#{request.env['PATH_INFO']}")
```

assuming you would set APP_CONFIG[:deutsch_website_url] to some value like http://www.application.de

#### Setting the Locale from URL Params

We can include something like this in our ApplicationController then:

```ruby
# app/controllers/application_controller.rb
def default_url_options
  { locale: I18n.locale }
end
```

Every helper method dependent on url_for will now **automatically include the locale in the query string.** like this: http://localhost:3001/?locale=ja.

You probably want URLs to look like this: http://www.example.com/en/books, you just have o set up your routes with [scope](http://api.rubyonrails.org/v5.2.3/classes/ActionDispatch/Routing/Mapper/Scoping.html):

```ruby
# config/routes.rb
scope "/:locale" do
  resources :books
end
```

If you don't want to force the use of a locale in your routes you can use an optional path scope(denoted by the parentheses) like so:

```ruby
# config/routes.rb
scope "(:locale)", locale: /en|nl/ do
  resources :books
end
```

You would probably neef to map URLs like these:

```ruby
# config/routes.rb
get '/:locale' => 'dashboard#index'
```

#### Setting the Locale from User Preferences

A User's selected locale preference is persisted in the database and used to set the locale for authenticated requests by that user.

```ruby
def set_locale
  I18n.locale = current_user.try(:locale) || I18n.default_locale
end
```

#### Choosing an Implied Locale

When an explicit locale has not been set for a request, an application should attempt to infer the desired locale.

##### Inferring Locale from the Language Header

A trivial implementation of using an Accept-Language header would be:

```ruby
def set_locale
  logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
  I18n.locale = extract_locale_from_accept_language_header
  logger.debug "* Locale set to '#{I18n.locale}'"
end

private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
```

##### Inferring the Locale from IP Geolocation

The IP address of the client making the request can be used to unfer the client's region and thus their locale. Services such as [GeoIP Lite Country](http://www.maxmind.com/app/geolitecountry) or gems like [geocoder](https://github.com/alexreisner/geocoder) can be used to implement this approach.

#### Storing the locale from the Session or Cookies

You may the tempted to store the chosen locale in a sesseion or a cookie. However, **do not do this**. The locale should be transparent and a part of the URL. This way you won't break people's basic assumptions about the web itself: if you send a URL to a friend, they should see the same page and content as you. A fancy word for this would be that you're being [RESTful](https://en.wikipedia.org/wiki/Representational_State_Transfer). Read more about the RESTful approach in [Stefan Tilkov's articles](https://www.infoq.com/articles/rest-introduction). Sometimes there are exceptions to this rule and those are discussed below.

<hr/>

To be continued.
Get information at [here](https://guides.rubyonrails.org/i18n.html).
