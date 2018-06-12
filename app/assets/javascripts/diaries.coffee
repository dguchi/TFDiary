# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class MenuTypesController
    select: ->
        $('#menu-types').on 'change', () ->
            $(@).parents('form').submit()
        return
this.menu_types = new MenuTypesController
