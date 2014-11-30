
class Flash

    constructor: (message, level=warning) ->
        @dom = jQuery("<div class='#{level}'>#{message}</div>")
        jQuery('body').prepend @dom
        setTimeout @close, 2000

    close: =>
        jQuery(@dom).slideUp()


# Export.
window.Flash = Flash
