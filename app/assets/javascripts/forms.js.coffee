//= require jquery_ujs
//= require jquery.geocomplete
//= require cocoon
//= require select2
//= require filepicker

window.changeThumb = (url) ->
  $('fieldset.avatar img').attr(
    'src',
    "http://fugu.johnre.es/images/crop/200x200/#{url.replace(/.*?:\/\//g, '')}.jpg"
  )

jQuery ->

  $("input#geocomplete").geocomplete
    details: ".c-lab_applications .address"
    detailsAttribute: "data-geo"
    map: "#geocomplete-map"
    location: $('#geocomplete').data('latlng')
    markerOptions:
      draggable: true

  $("#geocomplete").bind "geocode:dragged", (event, latLng) ->
    $("input#lab_application_lab_attributes_latitude, input#lab_latitude").val latLng.lat()
    $("input#lab_application_lab_attributes_longitude, input#lab_longitude").val latLng.lng()

  $("select.enhanced").select2()

  $('#tools').on 'cocoon:after-insert', (e, insertedItem) ->
    filepicker.constructWidget $(insertedItem).find('input.photo-uploader')
    $(insertedItem).find("select").select2();

  $('#humans').on 'cocoon:after-insert', (e, insertedItem) ->
    $(insertedItem).find("select").select2();