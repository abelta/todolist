
class Item
    
    constructor: (@dom) ->
        console.log 'Item', @dom

        clickContentHandler = (e) =>
            do @editContent
            false

        clickStateHandler = (e) =>
            do @toggleState
            false

        @id = jQuery(@dom).data('id')
        @done = jQuery(@dom).data('done')
        jQuery(@dom).find('.item_content').on 'click', clickContentHandler
        jQuery(@dom).find('.item_state').on 'click', clickStateHandler


    update: (data, state) =>
        @done = data.done
        jQuery(@dom).find('.item_content').text( data.content )
        jQuery(@dom).find('.item_state')
            .text( if @done then 'done' else 'pending' )
            .toggleClass('done')
            .toggleClass('pending')


    alertUpdateFail: ->
        new window.Flash "Item could not be updated.", "error"


    editContent: ->
        console.log 'editContent'


    toggleState: ->
        jQuery
            .ajax( "/items/#{@id}.json", type:'PATCH', data: {item:{done:!@done}} )
            .done( @update )
            .fail( @alertUpdateFail )




# MAIN.
jQuery('.item').each -> new Item(this)
