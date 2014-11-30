
class List
    
   constructor: (@dom) ->
        @id = jQuery(@dom).data('id')
        jQuery(@dom).find('.list_name').editable( @editName, select: true )
        jQuery(@dom).find('.list_name').on 'click', (event) -> event.preventDefault()
        jQuery(@dom).find('.list_destroy').on 'click', => do @destroyRemote; false


    updateLocal: (data) =>
        jQuery(@dom).find('.list_content').text( data.content )


    updateRemote: (data) ->
        jQuery
            .ajax( "/lists/#{@id}.json", type:'PATCH', data: {list:data} )
            .done( @updateLocal )
            .fail( @alertFail )


    destroyLocal: =>
        jQuery(@dom).slideUp()


    destroyRemote: =>
        jQuery
            .ajax( "/lists/#{@id}.json", type:'DELETE' )
            .done( @destroyLocal )
            .fail( @alertFail )


    alertFail: ->
        new window.Flash "List could not be updated.", "error"


    editName: (value) =>
        jQuery(@dom).find('.list_name').text(value)
        @updateRemote content:value
        value




# EXPORT.
window.List = List

# MAIN.
jQuery('.list').each -> new List(this)
