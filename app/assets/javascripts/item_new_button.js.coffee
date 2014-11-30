
class ItemNewButton

    constructor: (@dom) ->
        @target = "##{ jQuery(@dom).data('target') }"
        jQuery(@dom).on 'click', @promptNewItem

    
    itemTemplate =
        "<li>
            <a href='#' class='item' data-done='false'>
              <span class='item_content'>New item</span>
              <span class='item_destroy'>Remove</span>
              <span class='item_state pending'>Pending</span>
            </a>
        </li>"


    promptNewItem: =>
        template = jQuery(itemTemplate)
        jQuery("#{ @target }").prepend template
        jQuery(template)
            .find('.item_content')
            .editable( ((value) => @saveNewItem value, template), select: true )
            .click()


    updateNewItem: (dom, data) =>
        jQuery(dom)
            .attr('data-id', data.id)
            .find('.item_content').off()
        new Item dom


    saveNewItem: (value, template) =>
        data = content: value
        listId = jQuery(@target).data('list-id')
        jQuery
            .post( "/lists/#{listId}/items.json", item: data )
            .done( (data) => @updateNewItem template, data )
            .fail( @alertFail )
        jQuery('.nothing_found').remove()
        jQuery(template).find('.item_content').text(value)
        value

    
    alertFail: ->
        new window.Flash "Item could not be created.", "error"




# MAIN
jQuery('.item_new').each -> new ItemNewButton this
