class Greenback.Views.BudgetRow extends Greenback.Views.Base
  template  : JST["backbone/templates/budgets/budgets_row"]
  className : "data-group--table-row"
  tagName   : "tr"
  id: ""
  events:
    "mouseenter": "ghostRow"

  initialize: =>
    @model.on("reset", @render, this)

  ghostRow: =>
    color =
      if @$el.css("background-color") != "rgba(0, 0, 0, 0)"
        @$el.css("background-color")
      else
        $("body").css "background-color"
    
    if color == @$el.css("background-color")
      isColored = true
    else
      isColored = false

    tdWidth = []
    @$el.find("td").each ->
      tdWidth.push $(this).width() + "px"

    @$ghost =
      $("<table class='ghost-data'>
          <tbody></tbody>
        </table>")
        .css
          "border-spacing": 0
          "top": @$el.offset().top
          "left": @$el.offset().left
          "width": @$el.width()
          "background-color": color

    $("#applicationWrapper").append @$ghost
    ghostRow = @$ghost.html @$el.clone().addClass "ghost-data--row"
    if isColored == true
      ghostRow.attr "m-background", true

    ghostRow.find("td").each (index) ->
      $(this)
        .css "width", tdWidth[index]
        .find(".data-group--inner-cell").append "boom"

    # ghostRow.find("tr").append "<td class='data-group-action--edit'></td><td class='data-group-action--delete'></td>"

    @$ghost.on "mouseleave", ->
      @remove()

  render: =>
    @$el.html @template({ budget: @model })
    
    this