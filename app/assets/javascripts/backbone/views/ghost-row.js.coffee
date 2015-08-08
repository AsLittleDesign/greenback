class Greenback.Views.GhostRow extends Backbone.View
  template       : JST["backbone/templates/ghost-row"]
  className      : "ghost-data"

  initialize: =>
    @original  = @model.$el
    @data = @model.model

    @$el.html @template(model: @data)
    @$el.find("tbody").html @original.clone().addClass "ghost-data--row"
    @$el.css @styles()
    if @backgroundColor().striped
      @$el.find(".ghost-data--table").attr "m-background", true

    @render()

  styles: =>
    "border-spacing": 0
    "top": @original.offset().top
    "left": @original.offset().left
    "width": @original.width()
    "height": @original.height()
    "background-color": @backgroundColor().color

  backgroundColor: =>
    elementColor = @original.css("background-color")
    isStriped = false

    color = 
      if elementColor != "rgba(0, 0, 0, 0)"
        isStriped = true
        elementColor
      else
        $("body").css "background-color"

     color: color
     striped: isStriped

  setTdWidth: =>
    # Get the widths of the cloned tr's 'td's
    tdWidth = []
    @original.find("td").each ->
      tdWidth.push $(this).width() + "px"
    
    # Apply the widths
    @$el.find("td").each (i) ->
      $(this).css "width", tdWidth[i]
  
  render: =>
    $("#applicationWrapper").append @$el
    @setTdWidth()

    @$el.find("[js-toggle-slide]").attr "s-slide-in", true

    this
