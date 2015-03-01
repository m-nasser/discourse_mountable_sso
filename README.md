# DiscourseMountableSso

Discourse Mountable Sso is a mountable engine made to handle [Discourse](https://github.com/discourse/discourse/). single sign on technique,all you have to do is to configure your application .

##Getting started

Discourse mountable sso works with Rails 3.2.14 . You can add it to your Gemfile with:

```ruby
gem 'discourse_mountable_sso'
```

Run the bundle command to install it.

After you install Discourse mountable sso and add it to your Gemfile, you need to create a file in config/initializers in your application named discourse_config.rb filled with the below data


```ruby
DiscourseMountableSso.configuration.secret = "#{SECRET}"
DiscourseMountableSso.configuration.discourse_url = "#{DISCOURSE_URL}"	
DiscourseMountableSso.configuration.login_path = "#{LOGIN_PATH}"
DiscourseMountableSso.configuration.discourse_data_method = "{DISCOURSE_DATA_METHOD}"
DiscourseMountableSso.configuration.logged_in_check_method = "#{CHECK_LOGIN_METHOD}"
DiscourseMountableSso.configuration.store_return_to_url_method = "#{RETURN_TO_URL_METHOD}"
```
