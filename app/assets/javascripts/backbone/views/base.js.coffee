class Greenback.Views.Base extends Backbone.View
  template: JST["backbone/templates/base"]
  id: "applicationWrapper"
  events:
    "click [js-show-modal]"  : "toggleModal"
    "click [js-hide-modal]"  : "hideModal"
    "keyup"                  : "escapeModal"
    "submit [m-edit]"        : "editItem"
    "submit [m-create]"      : "createItem"
  
  initialize: =>
    @$el.keyup(@handleKeyup)
  
  user: =>
    if @model.toJSON().id
      @model.toJSON()
    else
      false

  createItem: (e) =>
    e.preventDefault()
    
    options = {}
    @$("input, textarea").each ->
      if $(this).attr "name"
        options[$(this).attr "name"] = $(this).val()
    
    options["owner_id"] = @user().id
    budget = new Greenback.Models.Budget()
    budget.set options
    budget.save()

    @hideModal()

  editItem: (e) =>
    e.preventDefault()
    
    options = {}
    @$("input, textarea").each ->
      if $(this).attr "name"
        options[$(this).attr "name"] = $(this).val()
    
    @model.set options
    @model.save()

    @hideModal()

  showModal: (modal) =>
    if !modal.attr "s-visible"
      modalContent = $("[js-modal]").find ".modal--content"

      modal.attr "s-visible", true
      $("body").css "overflow-y", "hidden"
      
      # Initialize input helpers
      modal.find("input, textarea").each ->
        @focus ->
          showHelperTooltip this
          
        @blur ->
          hideHelperTooltip this

        note = $(this).attr "title"
        if note
          $(this).after(
            "<div class='input-helper'>
              <div class='input-helper--container'>
                #{note}
              </div>
            </div>")

      modal.find("[js-autofocus]").focus()

      setTimeout =>
        modal.find(".modal--overlay").css "opacity", 1
      , 20

      setTimeout =>
        modalContent.toggleAttr "s-visible", true
      , 200

    showHelperTooltip = (input) ->
      helper = $(input).next()
      if helper.attr "s-visible", false
        $(".input-helper").removeAttr "s-visible"
        helper.toggleAttr "s-visible", true

    hideHelperTooltip = (input) ->
      helper = $(@).next()
      if helper.attr "s-visible", true
        helper.next().toggleAttr "s-visible", false

  hideModal: =>
    modalContent = @$("[js-modal]").find(".modal--content")
    modalContent.css "top", ""
    $("body").css "overflow-y", "auto"
    @$("[js-modal]").find(".modal--overlay").css "opacity", 0

    @$(".input-helper").toggleAttr "s-visible", false

    setTimeout =>
      modalContent.toggleAttr "s-visible", false
    , 20

    setTimeout =>
      @$("[js-modal]").removeAttr "s-visible"
    , 200
  
  toggleModal: (e) =>
    modalId = $(e.currentTarget).attr "rel"
    @showModal $("##{modalId}[js-modal]")

  handleKeyup: (e) =>
    if e.keyCode == 27
      @hideModal()

  render: =>
    nav = new Greenback.Views.Nav(model: @model)
    @$el.prepend nav.render().$el

    this
