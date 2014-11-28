
class List
    
    constructor: (@dom) ->
        console.log 'List', @dom
        clickHandler = (e) ->
            console.log 'clickHandler'
            # LIST CLICK BEHAVIOR.
        jQuery(@dom, '.list_name').on 'click', clickHandler



# MAIN.
jQuery('.list').each -> new List(this)
