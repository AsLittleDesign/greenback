class Greenback.Models.User extends Backbone.Model
  url: "/api/users"

  parse: (response) =>
    if response.body || !response
      null
    else if response
      response
