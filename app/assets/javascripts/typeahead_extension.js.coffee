jQuery ->
  _.compile = (templ) ->
    compiled = @template(templ)
    compiled.render = (ctx) ->
        @ ctx
    compiled

  $("#typeahead-patients").typeahead
    remote: "/patients/suggestions?q=%QUERY"
    valueKey: 'full_name'
    updater: (item) ->
      console.log item
    templates:
      empty: [
        '<div class="empty-message">',
        'unable to find any Best Picture winners that match the current query',
        '</div>'
      ].join('\n'),
      suggestion: (data)->
        _.compile('
                <div class="col-xs-12 col-sm-9">
                            <span class="name">Scott Stevens</span><br/>
                            <span class="glyphicon glyphicon-map-marker text-muted c-info" data-toggle="tooltip" title="5842 Hillcrest Rd"></span>
                            <span class="visible-xs"> <span class="text-muted">5842 Hillcrest Rd</span><br/></span>
                            <span class="glyphicon glyphicon-earphone text-muted c-info" data-toggle="tooltip" title="(870) 288-4149"></span>
                            <span class="visible-xs"> <span class="text-muted">(870) 288-4149</span><br/></span>
                            <span class="fa fa-comments text-muted c-info" data-toggle="tooltip" title="scott.stevens@example.com"></span>
                            <span class="visible-xs"> <span class="text-muted">scott.stevens@example.com</span><br/></span>
                        </div>

        ')


  $("#typeahead-patients").bind 'typeahead:selected', (obj, datum) ->
    window.location.href = datum.url
