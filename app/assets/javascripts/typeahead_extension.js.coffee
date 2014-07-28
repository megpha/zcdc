jQuery ->
  bestPictures = new Bloodhound
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value')
    queryTokenizer: Bloodhound.tokenizers.whitespace
    remote: "/patients/suggestions?q=%QUERY"

  bestPictures.initialize()

  _.compile = (templ) ->
    compiled = @template(templ)
    compiled.render = (ctx) ->
        @ ctx
    compiled

  $("#typeahead-patients").typeahead null,
    name: 'best-pictures',
    displayKey: 'full_name'
    source: bestPictures.ttAdapter()

  $("#typeahead-patients").bind 'typeahead:selected', (obj, datum) ->
    window.location.href = datum.url
  $('#pickmydate').datetimepicker()
