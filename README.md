# Blizzard API proxy

This is a simple proxy for Blizzard's World of Warcraft API.

## Intended usage

The goal of this project is to provide a fast and simple solution for those who want to consume Blizzard's API from mobile device apps, or even client side Javascript code.

With this proxy your client credentials can be stored safely on the server and still power your other applications.

## Usage

**Heroku**

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

**Docker**

Create a `.env` file containing the following environment variables:

| Name | Description |
| --- | --- |
| REGION | The region for the API requests |
| BNET_APPLICATION_ID | Your client ID |
| BNET_APPLICATION_SECRET | Your client secret |
| PORT | The HTTP server port to bind |
| USE_CACHE | When this is set to "true" data will be cached to redis |

Run `docker-compose -f docker-compose.yml up -d --build` to create and run the instance.

**Ruby terminal**

Export the following variables to the environment: 

| Name | Description |
| --- | --- |
| REGION | The region for the API requests |
| BNET_APPLICATION_ID | Your client ID |
| BNET_APPLICATION_SECRET | Your client secret |
| PORT | The HTTP server port to bind |
| USE_CACHE | When this is set to "true" data will be cached to redis |
| REDIS_HOST | Redis host |
| REDIS_PORT | Redis port |

Simply run `ruby blizzard_api_proxy.rb`.

Now you can fetch any API resource by following the original uri from the docs:

Assuming you started your instance on port 3000:

`https://us.api.blizzard.com/data/wow/achievement-category/index?namespace=static-us`

becomes

`http://127.0.0.1:3000/data/wow/achievement-category/index`

**Profile endpoints**

For account endpoints a token created using the OAuth2 authorization flow must be supplied as a query string param:

`https://us.api.blizzard.com/profile/user/wow?namespace=profile-us`

becomes

`http://127.0.0.1:3000/profile/user/wow?token=<user_token>`

## Know issues

Those are some limitations for the first version that might get upgraded in the future.

* ~~Only supports one region per instance.~~ You can now specify the region as part of the query string: `&region=eu`
* ~~Always return data for all locales.~~ You can now specify the locale as part of the query string: `&locale=pt_BR`
* There is no security layer, if you expose the port to the web anyone can access. It should be used behind a reverse proxy with some kind of CORS policy or even a HTTP auth.
