# Attribute setting function
$.fn.toggleAttr = (attribute, state) ->
  # 'elementState' should be true if element doesn't have 'attribute'
  elementState = @attr attribute

  if (elementState is "false" or elementState is undefined) or state is "true"
    @attr attribute, true

  else if elementState or state is "false"
    @removeAttr attribute
