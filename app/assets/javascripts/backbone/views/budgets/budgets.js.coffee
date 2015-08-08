class Greenback.Views.Budgets extends Greenback.Views.Base
  template: JST["backbone/templates/budgets/budgets"]
  id: ""
  className: "container"

  initialize: =>
    @collection.on("reset", @render, this)
    @collection.on("change", @render, this)

  clearViews: (views) =>
    if views
      for view in views
        view.remove()
        views.remove(view.cid)

  budgetRows:
    length: 0

    add: (key) =>
      @[key.cid] = key
      @length = @length++

    remove: (key) =>
      delete @[key]
  
  render: =>
    @$el.html @template { collection: @collection }

    @clearViews(@budgetRows)

    for model in @collection.models
      budgetRow = new Greenback.Views.BudgetRow(model: model)
      @$("[js-budget-data]").append budgetRow.render().el
      
      @budgetRows.add(budgetRow)
 
    this

