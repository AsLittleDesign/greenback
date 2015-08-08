class Greenback.Views.BudgetShow extends Greenback.Views.Base
  template : JST["backbone/templates/budgets/show"]
  className: "container"
  id       : ""

  events:
    "click [js-edit-budget]": "toggleModal"

  initialize: =>
    @model.on "reset", @render, this
    @model.on "change", @render, this
    
    @collection.on "reset", @renderVersions, this
    @collection.on "change", @changeVersion, this

  clearViews: (views) =>
    if views
      for view in views
        view.remove()
        views.remove(view.cid)

  renderVersions: =>
    @clearViews(@budgetVersions)

    for model in @collection.models
      budgetVersion = new Greenback.Views.BudgetVersion(model: model)
      @$("[js-history-rows]").append budgetVersion.render().el

      @budgetVersions.add(budgetVersion)

  changeVersion: =>
    @clearViews(@budgetVersions)

    for model in @collection.models
      budgetVersion = new Greenback.Views.BudgetVersion(model: model)
      @$("[js-history-rows]").append budgetVersion.render().el
      
      @budgetVersions.add(budgetVersion)

  budgetVersions:
    length: 0

    add: (key) =>
      @[key.cid] = key
      @length = @length++

    remove: (key) =>
      delete @[key]
  
  render: =>
    @$el.html @template { model: @model }

    @renderVersions()
  
    this


