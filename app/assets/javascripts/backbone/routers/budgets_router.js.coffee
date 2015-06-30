class Greenback.Routers.Budgets extends Backbone.Router

  routes:
    "budgets": "budgets"

  initialize: ->
  	@collection = new Greenback.Collections.Budgets()
  	@collection.fetch
  	  reset: true

  budgets: =>
    view = new Greenback.Views.Budgets(budgets: @collection)
    $("#applicationWrapper").append view.render().el
