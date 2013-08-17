jQuery ->
  # map details
  if $('#minimap').length > 0
    markers = new L.MarkerClusterGroup
    map = L.map('minimap', { scrollWheelZoom: false }).setView([50, 0], 2 )
    L.tileLayer('http://{s}.tile.cloudmade.com/384aceabcd0942189d0e93cf0e98cd31/90734/256/{z}/{x}/{y}.png', {}).addTo(map)
    navigator.geolocation.getCurrentPosition((position)->
      map.setView([position.coords.latitude, position.coords.longitude], 6)
    )

    $.get "/labs.json", (labs) ->
      for lab in labs
        if lab.latitude
          lab.marker = L.marker [lab.latitude, lab.longitude]
          markers.addLayer(lab.marker)

      map.addLayer(markers)
