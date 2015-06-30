class Greenback.Models.User extends Backbone.Model
  url: "/api/users"
  parse: (response) ->
    response
    