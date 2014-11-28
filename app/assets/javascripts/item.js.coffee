
class Item
    
    constructor: (@dom) ->
        console.log 'Item', @dom

        clickContentHandler = (e) =>
            console.log 'clickContentHandler'
            do @editContent
            false

        clickStateHandler = (e) =>
            console.log 'clickStateHandler'
            do @toggleState
            false

        @id = jQuery(@dom).data('id')
        jQuery(@dom).find('.item_content').on 'click', clickContentHandler
        jQuery(@dom).find('.item_state').on 'click', clickStateHandler

    editContent: ->
        console.log 'editContent'

    toggleState: ->
        console.log 'toggleState'
        updateState = ->
            console.log 'updateState'
            newText = jQuery(@).find('item_state').text() == 'pending' ? 'done' : 'pending'
            jQuery(@dom).find('item_state')
                .toggleClass('done')
                .toggleClass('pending')
                .text(newText)
        done = jQuery(@dom).find('.item_state').hasClass('done')
        jQuery
            .when( jQuery.ajax("/items/#{@id}.json", type:'PATCH', data: {item:{pending:!done}}) )
            .then( do updateState )




# MAIN.
jQuery('.item').each -> new Item(this)
