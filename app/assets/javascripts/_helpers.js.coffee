# Attribute setting function
$.fn.toggleAttr = (attribute, state) ->
  # 'elementState' should be true if element doesn't have 'attribute'
  elementState = this.attr attribute

  if (elementState == "false" or elementState == undefined) or state == "true"
    this.attr attribute, true

  else if elementState != undefined || state == "false"
    this.removeAttr attribute
