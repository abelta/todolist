
class Item
    
    constructor: (@dom) ->
        @id = jQuery(@dom).data('id')
        @done = jQuery(@dom).data('done')
        @listId = jQuery(@dom).parents('ul').first().data('list-id')
        jQuery(@dom).find('.item_content').editable( @editContent, event: 'dblclick', select: true )
        jQuery(@dom).find('.item_destroy').on 'click', => do @destroyRemote; false
        jQuery(@dom).find('.item_state').on 'click', => do @toggleState; false


    updateLocal: (data) =>
        @done = data.done
        jQuery(@dom).find('.item_content').text( data.content )
        jQuery(@dom).find('.item_state')
            .text( if @done then 'done' else 'pending' )
            .toggleClass('done')
            .toggleClass('pending')


    updateRemote: (data) ->
        jQuery
            .ajax( "/lists/#{@listId}/items/#{@id}.json", type:'PATCH', data: {item:data} )
            .done( @updateLocal )
            .fail( @alertFail )


    destroyLocal: =>
        jQuery(@dom).slideUp()


    destroyRemote: =>
        jQuery
            .ajax( "/lists/#{@listId}/items/#{@id}.json", type:'DELETE' )
            .done( @destroyLocal )
            .fail( @alertFail )


    alertFail: ->
        new window.Flash "Item could not be updated.", "error"


    toggleState: ->
        @updateRemote done:!@done


    editContent: (value) =>
        jQuery(@dom).find('.item_content').text(value)
        @updateRemote content:value
        value




# EXPORT.
window.Item = Item

# MAIN.
jQuery('.item').each -> new Item(this)
