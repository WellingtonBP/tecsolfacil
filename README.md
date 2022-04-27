## Tecsolfacil

### Requirements
- [X] Endpoint to send address by CEP
- [X] Generate CSV and send to user asynchronously
- [X] Ensure security providing authentication method

### How to use
Set SENDGRID_KEY and PHX_TOKEN_SALT env variables and type these commands:

```
mix deps.get
mix ecto.create
mix ecto.migrate
mix run apps/api/priv/repo/seeds.exs
mix phx.server
```
Or with docker (set variables in a .env file):

```
 docker-compose up --build
```

### Docs
|Endpoint |Params |Description
|---------|-------|-----------
|[post] /api/auth/login|body_params: email and password|Return status 200 and a token or 404/422
|[get] /api/zip/:zipcode|url_params: zipcode|Return status 200 and address or 404/422 (need authentication)
|[get] /api/zip|none|Send a csv file to email with all addresses on database (need authentication)
