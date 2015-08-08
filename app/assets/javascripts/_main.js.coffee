#= require 'xdate'

$ ->
  # Navigation bar
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

  # Inputs
  $("form").submit ->
    $(@).find("input").each ->
      if $(@).attr("type") != "submit"
        $(@).attr "value", ""

    $(@).find("textarea").each ->
      $(@).text ""

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
