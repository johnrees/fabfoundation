update = ->
  $('fieldset.country').each ->
    $(this).toggle ($(this).hasAtLeastOneVisibleChild('.lab'))


jQuery ->

  $('.c-labs.a-index input').change ->
    # alert ".lab[data-#{$(this).parents('fieldset').data('type')}='#{$(this).val()}']"
    $('fieldset').show()
    $(".lab[data-#{$(this).parents('fieldset').data('type')}='#{$(this).val()}']").toggle $(this).is(':checked')
    update()

  $('.c-labs.a-index form').submit ->
    return false

  count = 0
  $('#q_name_or_city_cont').keyup ->
    q = $('#q_name_or_city_cont').val()

    if q == ""
      $('.lab, fieldset.country').show()
      count = 1
    else
      $('.lab').each ->
        if $(this).data('name').contains(q)
          count++
          $(this).show()
        else
          $(this).hide()

    $('#no-results').toggle(~count)

  # hide flash messages
  $('#flash_notice').delay(2000).slideUp('fast')

  $("select.enhanced").select2()

  # map details
  if $('#map').length > 0
    markers = new L.MarkerClusterGroup
    map = L.map('map', { scrollWheelZoom: false }).setView([50, 0], 2 )
    L.tileLayer('http://{s}.tile.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png', {}).addTo(map)
    if $('#map').data('lat')
      map.setView([$('#map').data('lat'), $('#map').data('lng')], $('#map').data('zoom') )
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

  $('#humans').on 'cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem).find("select").select2();

  $('tr .closed').change ->
    $(this).parents('tr').find('.hide-if-closed *').toggle( !$(this).is(":checked") )
  .trigger('change')

  # GeoComplete

  $("input#geocomplete").geocomplete
    details: ".address"
    detailsAttribute: "data-geo"
    map: "#geocomplete-map"
    location: $('#geocomplete').data('latlng')
    markerOptions:
      draggable: true

  $("#geocomplete").bind "geocode:result", (event, result) ->
    console.log result

  $("#geocomplete").bind "geocode:dragged", (event, latLng) ->
    $("input#lab_latitude").val latLng.lat()
    $("input#lab_longitude").val latLng.lng()
