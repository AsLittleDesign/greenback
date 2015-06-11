#= require '_helpers'
#= require 'xdate'

$ ->
  # Navigation bar
  $(window).bind "mousewheel": (e) ->
    toggleNav(e)
  
  toggleNav = _.throttle (e) ->
    if e.originalEvent.wheelDelta > 0
      $("[js-nav-bar]").removeAttr "s-nav-up"

    else if $(window).scrollTop() > 150
      $("[js-nav-bar]").attr "s-nav-up", true

      if $("[js-navigation-dropdown]").attr "s-visible"
        $("[js-navigation-dropdown]").removeAttr  "s-visible"
  , 150
  
  $("[js-toggle-navigation-dropdown]").click ->
    dropdown = $("[js-navigation-dropdown]")
    toggleDropdown = $("[js-toggle-navigation-dropdown]")

    if dropdown.attr "s-visible"
      dropdown.toggleAttr "s-visible"
      toggleDropdown.toggleAttr "s-active"

    else
      dropdown.toggleAttr "s-visible"
      toggleDropdown.toggleAttr "s-active"

  url = window.location.href.split("/")
  url.splice(0, 3)
  url = "/#{url.toString()}"

  $(".navigation-bar--user-links").each ->
    if $(@).parent("a").attr("href") is url
      $(@).attr "s-active", true

  # Navigation drawer
  $("[js-toggle-drawer]").click ->
    $("[js-drawer]").toggleAttr "s-active"
    $("[js-overlay-drawer]").toggleAttr "s-visible"

  $("[js-close-drawer]").click ->
    $("[js-drawer]").toggleAttr "s-active"
    $("[js-overlay-drawer]").toggleAttr "s-visible"

  # Logo images modal toggle
  $("[js-logo]")[0].addEventListener 'contextmenu', (e) ->
    e.preventDefault()

    $("[js-context-menu]").attr "s-visible", false
    showModalContent $("#logo-modal[js-modal]")

  # Modals
  # Modal toggle button should have the 'rel' attribute 
  # set as a string that is the same as the modal ID.
  $("[js-show-modal]").click ->
    modalId = $(@).attr "rel"
    showModalContent $("##{modalId}[js-modal]")

  $("[js-hide-modal]").click ->
    hideModalContent()

  $(document).keyup (e) ->
    if e.keyCode == 27
      hideModalContent()

  hideModalContent = ->
    modalContent = $("[js-modal]").find(".modal--content")
    modalContent.css "top", ""
    $("body").css "overflow-y", "auto"
    $("[js-modal]").find(".modal--overlay").css "opacity", 0

    $(".input-helper").toggleAttr "s-visible", false

    setTimeout =>
      modalContent.toggleAttr "s-visible", false
    , 20

    setTimeout =>
      $("[js-modal]").removeAttr "s-visible"
    , 200

  showModalContent = (modal) ->
    if !modal.attr "s-visible"
      modalContent = $("[js-modal]").find(".modal--content")

      modal.attr "s-visible", true
      $("body").css "overflow-y", "hidden"
      
      # Initialize input helpers
      modal.find("input, textarea").each ->
        $(@).focus ->
          showHelperTooltip(@)
          
        $(@).blur ->
          hideHelperTooltip(@)

        note = $(@).attr "title"
        if note
          $(@).after(
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

  # Inputs
  $("form").submit ->
    $(@).find("input").each ->
      if $(@).attr("type") != "submit"
        $(@).attr "value", ""

    $(@).find("textarea").each ->
      $(@).text ""

  # Table display
  $(".data-group td").each ->
    $(this).prepend "
      <span class='data-group--edit' js-toggle-input data-icon='pencil' title='Edit'>
        Edit
      </span>"

  $("[js-toggle-input]").click ->
    $innerCell = $(this).siblings(".data-group--inner-cell")
    $(this).toggleAttr "s-hidden"
    $innerCell.children("input").toggleAttr "s-visible"
    $innerCell.children("span").toggleAttr "s-hidden"

  $("[js-parse-date]").each ->
    date = new XDate $(this).text()

    day =
      switch date.getDate()
        when 1 then "1st"
        when 2 then "2nd"
        when 3 then "3rd"
        when 21 then "21st"
        when 22 then "22nd"
        when 23 then "23rd"
        else date.getDate() + "th"

    if date.toString() is "Invalid Date"
      date = "No date entered."

    else
      date = date.toString("MMMM") + " #{day}, " + date.getFullYear()

    $(this).text date
