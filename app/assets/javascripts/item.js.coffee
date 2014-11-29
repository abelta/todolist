
class Item
    
    constructor: (@dom) ->

        @id = jQuery(@dom).data('id')
        @done = jQuery(@dom).data('done')
        jQuery(@dom).find('.item_content').editable( @editContent )
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
            .ajax( "/items/#{@id}.json", type:'PATCH', data: {item:data} )
            .done( @updateLocal )
            .fail( @alertFail )


    destroyLocal: =>
        console.log 'destroyLocal'
        jQuery(@dom).slideUp()


    destroyRemote: =>
        console.log 'destroyRemote'
        jQuery
            .ajax( "/items/#{@id}.json", type:'DELETE' )
            .done( @destroyLocal )
            .fail( @alertFail )


    alertFail: ->
        new window.Flash "Item could not be updated.", "error"


    toggleState: ->
        @updateRemote done:!@done


    editContent: (value) =>
        jQuery(@dom).find('.item_content').text('moco')
        @updateRemote content:value
        value




# MAIN.
jQuery('.item').each -> new Item(this)
