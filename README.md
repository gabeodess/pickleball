# README

This is a base application that includes tooling for user authentication and push notifications.

## TODO
 - Update database names in `config/database.yml`
 - Update `.env`/`initializers/credentials.yml.enc` with appropriate values (Rollbar/SendGrid/etc.)

## Install OpenSSL gem

The `openssl` gem (dependency of WebPush) can't always locate it's dependencies.

If you are hitting issues bundling your gems try first installing `openssl` manually.

You'll first need to locate your installed version of the base `openssl` library.  
In my case it was installed by Homebrew at `/opt/homebrew/opt/openssl@3.2`

```
gem install openssl -- --with-openssl-dir=/opt/homebrew/opt/openssl@3.2
```