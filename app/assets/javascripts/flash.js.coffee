
class Flash

    constructor: (message, level=warning) ->
        console.log 'Flash', message, level
        @dom = jQuery("<div class='#{level}'>#{message}</div>")
        jQuery('body').prepend @dom
        setTimeout @close, 2000

    close: =>
        console.log 'Flash#close'
        jQuery(@dom).slideUp()


# Export.
window.Flash = Flash
