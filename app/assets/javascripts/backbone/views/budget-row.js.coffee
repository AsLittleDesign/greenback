class Greenback.Views.BudgetRow extends Greenback.Views.Base
  template  : JST["backbone/templates/budgets/budgets_row"]
  className : "data-group--table-row"
  tagName   : "tr"
  id: ""

  initialize: =>
    @model.on("reset", @render, this)

  render: =>
    @$el.html @template({ budget: @model })

    this