class Greenback.Routers.Base extends Backbone.Router
  routes:
    "" : "index"
    "budgets" : "budgets"
    "budgets/:id" : "budgetShow"

  initialize: =>
    @user = new Greenback.Models.User()
    @user.fetch
      reset: true
    
    view = new Greenback.Views.Base(model: @user)
    $("body").prepend view.render().$el

  index: =>
    @resetView()

  budgets: =>
    @budgets = new Greenback.Collections.Budgets()
    @budgets.fetch
      reset: true
    
    @resetView()

    @currentView = new Greenback.Views.Budgets { collection: @budgets }
    $("#applicationWrapper").append @currentView.render().$el

  budgetShow: (id) =>
    budget = new Greenback.Models.Budget
      id: id

    budget.fetch
      reset: true

    @resetView()

  resetView: =>
    if @currentView
      @currentView.remove()
