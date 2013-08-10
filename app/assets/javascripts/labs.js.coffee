jQuery ->

  if $('#map').length > 0
    markers = new L.MarkerClusterGroup
    map = L.map('map', { scrollWheelZoom: false }).setView([$('#map').data('lat'), $('#map').data('lng')], $('#map').data('zoom'))
    L.tileLayer('http://{s}.tile.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png', {}).addTo(map)
    # L.marker([$('#map').data('lat'), $('#map').data('lng')]).addTo(map)

    $.get "/labs.json", (labs) ->
      for lab in labs
        if lab.latitude
          lab.marker = L.marker([lab.latitude, lab.longitude])
          markers.addLayer(lab.marker)
      map.addLayer(markers)

  $('#tools').on 'cocoon:after-insert', (e, insertedItem) ->
    filepicker.constructWidget $(insertedItem).find('input.photo-uploader')