jQuery ->
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
      suggestion: Handlebars.compile('<p><strong>{{full_name}}</strong> – </p>')



  $("#typeahead-patients").bind 'typeahead:selected', (obj, datum) ->
    window.location.href = datum.url
