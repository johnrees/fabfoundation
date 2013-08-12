# filterInit = ->
#   template = Mustache.compile($.trim($("#template").html()))
#   view = (service) ->
#     return template(service)
#   settings = {
#     filter_criteria: {
#       amount: ['#price_filter .TYPE.range', 'amount'],
#       status: ['#status :checkbox', 'status']
#     },
#     search: {input: '#search_box' },
#     and_filter_on: true,
#   }
#   FilterJS(services, "#service_list", view, settings)

jQuery ->

  $(".c-labs select").select2();

  $('#flash_notice').delay(2000).slideUp('fast')

  # fJS = filterInit()

  if $('#map').length > 0 and $('#map').data('lat')
    markers = new L.MarkerClusterGroup
    map = L.map('map', { scrollWheelZoom: false }).setView([$('#map').data('lat'), $('#map').data('lng')], $('#map').data('zoom'))
    L.tileLayer('http://{s}.tile.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png', {}).addTo(map)
    L.marker([$('#map').data('lat'), $('#map').data('lng')]).addTo(map)

    $.get "/labs.json", (labs) ->
      for lab in labs
        if lab.latitude
          lab.marker = L.marker([lab.latitude, lab.longitude])
          lab.marker.bindPopup("<a href='/labs/#{lab.id}'>#{lab.name}</a>")
          markers.addLayer(lab.marker)
      map.addLayer(markers)

  $('#tools').on 'cocoon:after-insert', (e, insertedItem) ->
    filepicker.constructWidget $(insertedItem).find('input.photo-uploader')
    $(insertedItem).find("select").select2();


  $('tr .closed').change ->
    $(this).parents('tr').find('.hide-if-closed *').toggle( !$(this).is(":checked") )
  .trigger('change')

  $("input#geocomplete").geocomplete
    details: ".address"
    detailsAttribute: "data-geo"
    map: "#geocomplete-map"
    markerOptions:
      draggable: true

  $("#geocomplete").bind "geocode:result", (event, result) ->
    console.log result
  $("#geocomplete").bind "geocode:dragged", (event, latLng) ->
    $("input#lab_latitude").val latLng.lat()
    $("input#lab_longitude").val latLng.lng()

  # $('.filter-button').hide()
  # $('input').change ->
  #   $(this).parents('form').submit()
