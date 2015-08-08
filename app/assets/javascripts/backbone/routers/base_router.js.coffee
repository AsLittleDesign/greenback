class Greenback.Routers.Base extends Backbone.Router
  routes:
    "" : "index"
    "budgets" : "budgets"
    "budgets/:id" : "budgetShow"

  initialize: =>
    @user = new Greenback.Models.User()
    @user.fetch
      reset: true

    base = new Greenback.Views.Base(model: @user)
    $("body").prepend base.render().$el

  index: =>
    @resetView()

  budgets: =>
    budgets = new Greenback.Collections.Budgets()
    budgets.fetch
      reset: true
    
    @resetView()

    @currentView = new Greenback.Views.Budgets { collection: budgets, model: @user }
    $("#applicationWrapper").append @currentView.render().$el

  budgetShow: (id) =>
    budget = new Greenback.Models.Budget { id: id }
    budget.fetch { reset: true }

    history = new Greenback.Collections.BudgetHistory()
    history.fetch
      url: "/api/budgets/#{id}/history",
      reset: true

    @resetView()

    @currentView = new Greenback.Views.BudgetShow { collection: history, model: budget }
    $("#applicationWrapper").append @currentView.render().$el

  resetView: =>
    # Clears any potential ghosted rows from the view.
    $(".ghost-data").remove()

    if @currentView
      @currentView.remove()
