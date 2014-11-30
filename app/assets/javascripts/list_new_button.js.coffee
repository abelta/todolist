
class ListNewButton

    constructor: (@dom) ->
        @target = "##{ jQuery(@dom).data('target') }"
        jQuery(@dom).on 'click', @promptNewList

    
    listTemplate =
        "<li>
            <a class='list' href='#'>
              <span class='list_name'>New list</span>
              <span class='list_count'>(0)</span>
              <span class='list_destroy'>Remove</span>
            </a>
        </li>"


    promptNewList: =>
        template = jQuery(listTemplate)
        jQuery("#{ @target }").prepend template
        jQuery(template)
            .find('.list_name')
            .editable( ((value) => @saveNewList value, template), select: true )
            .click()


    updateNewList: (dom, data) =>
        jQuery(dom)
            .attr('data-id', data.id)
            .attr('href', "/lists/#{data.id}")
            .find('.list_name').off()
        new List dom


    saveNewList: (value, template) =>
        userId = jQuery(@target).data('user-id')
        data = name: value, user_id: userId
        jQuery
            .post( "/lists.json", list: data )
            .done( (data) => @updateNewList template, data )
            .fail( @alertFail )
        jQuery('.nothing_found').remove()
        jQuery(template).find('.list_name').text(value)
        value

    
    alertFail: ->
        new window.Flash "List could not be created.", "error"




# MAIN
jQuery('.list_new').each -> new ListNewButton this
