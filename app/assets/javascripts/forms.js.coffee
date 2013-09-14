//= require jquery_ujs
//= require jquery.geocomplete
//= require cocoon
//= require select2
//= require filepicker

jQuery ->

  $("input#geocomplete").geocomplete
    details: ".address"
    detailsAttribute: "data-geo"
    map: "#geocomplete-map"
    location: $('#geocomplete').data('latlng')
    markerOptions:
      draggable: true

  $("#geocomplete").bind "geocode:dragged", (event, latLng) ->
    $("input#lab_application_lab_attributes_latitude").val latLng.lat()
    $("input#lab_application_lab_attributes_longitude").val latLng.lng()

  $("select.enhanced").select2()

  $('#tools').on 'cocoon:after-insert', (e, insertedItem) ->
    filepicker.constructWidget $(insertedItem).find('input.photo-uploader')
    $(insertedItem).find("select").select2();

  $('#humans').on 'cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem).find("select").select2();