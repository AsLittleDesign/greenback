class Greenback.Views.BudgetRow extends Greenback.Views.Base
  template  : JST["backbone/templates/budgets/budgets_row"]
  className : "data-group--table-row"
  tagName   : "tr"
  id: ""
  events:
    "click [js-options-button]": "ghostRow"

  initialize: =>
    @model.on("reset", @render, this)

  ghostRow: (e) =>
    @$el.siblings().find("[js-options-button]").removeAttr "s-active"
    $(e.target).toggleAttr "s-active"

    if @ghost and @ghost.$el
      @ghost.$el.find("[js-toggle-slide]").removeAttr "s-slide-in"
      setTimeout =>
        @ghost.$el.remove()
        @ghost.remove()
        @ghost = undefined
      , 250

    else
      @ghost = new Greenback.Views.GhostRow { model: this }
      @ghost.$el.siblings().each ->
        if $(this).is ".ghost-data"
          $(this).find("[js-toggle-slide]").removeAttr "s-slide-in"
          setTimeout =>
            $(this).remove()
          , 250

  render: =>
    @$el.html @template { budget: @model }
    
    this
