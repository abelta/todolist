
class ItemNewButton

    constructor: (@dom) ->
        @target = "##{ jQuery(@dom).data('target') }"
        jQuery(@dom).on 'click', @promptNewItem

    
    itemTemplate =
        "<li class='item' data-done='false'>
            <a href='#' class='item_content'>New item</a> -
            <a href='#' class='item_state pending'>pending</a>
            <a href='#' class='item_destroy'>Remove</a>
        </li>"


    promptNewItem: =>
        template = jQuery(itemTemplate)
        jQuery("#{ @target }").prepend template
        jQuery(template)
            .find('.item_content')
            .editable( (value) => @saveNewItem value, template )
            .click()


    updateNewItem: (dom, data) =>
        jQuery(dom).attr('data-id', data.id)
        jQuery(dom).find('.item_content').off()
        new Item dom


    saveNewItem: (value, template) =>
        data = {content: value}
        listId = jQuery(@target).data('list-id')
        jQuery
            .post( "/lists/#{listId}/items.json", {item: data} )
            .done( (data) => @updateNewItem template, data )
            .fail( @alertFail )
        jQuery(template).find('.item_content').text(value)
        value

    
    alertFail: ->
        new window.Flash "Item could not be created.", "error"




# MAIN
jQuery('.item_new').each -> new ItemNewButton this
