String.prototype.contains = (it) -> return this.toLowerCase().indexOf(it.toLowerCase()) != -1

(($) ->
  $.fn.hasAtLeastOneVisibleChild = (selector) ->
    $col = @children(selector)
    i = undefined
    elem = undefined
    i = 0
    while i < $col.length
      elem = $col[i]
      return true  if elem.offsetWidth isnt 0 or elem.offsetHeight isnt 0
      i++
    false
) jQuery

jQuery ->

  $('#q_name_or_city_cont').keyup ->
    q = $('#q_name_or_city_cont').val()
    if q == ""
      $('.lab, fieldset.country').show()
    else
      $('.lab').each ->
        $(this).toggle $(this).data('name').contains(q)
        # fieldset = $(this).parent('fieldset.country')
        # fieldset.toggle ($(this).siblings(':visible').length == 0)

    $('fieldset.country').each ->
      $(this).toggle ($(this).hasAtLeastOneVisibleChild('.lab'))

  # $('[data-date]').each ->
  #   $(this).text moment($(this).data('date')).calendar()

  $('input.datepicker').datepicker
    changeMonth: true
    dateFormat: 'm M yy'

  # $( "input.datepicker.from" ).datepicker( "option", "onClose", ((date)-> $( "input.to" ).datepicker( "option", "minDate", selectedDate )) )
  # $( "input.datepicker.to" ).datepicker( "option", "onClose", ((date)-> $( "input.from" ).datepicker( "option", "maxDate", selectedDate )) )

  date = new Date()
  d = date.getDate()
  m = date.getMonth()
  y = date.getFullYear()

  $('#calendar').fullCalendar({
    editable: true,
    events: [
      {
        title: 'All Day Event',
        start: new Date(y, m, 1)
      },
      {
        title: 'Long Event',
        start: new Date(y, m, d-5),
        end: new Date(y, m, d-2)
      },
      {
        id: 999,
        title: 'Repeating Event',
        start: new Date(y, m, d-3, 16, 0),
        allDay: false
      },
      {
        id: 999,
        title: 'Repeating Event',
        start: new Date(y, m, d+4, 16, 0),
        allDay: false
      },
      {
        title: 'Meeting',
        start: new Date(y, m, d, 10, 30),
        allDay: false
      },
      {
        title: 'Lunch',
        start: new Date(y, m, d, 12, 0),
        end: new Date(y, m, d, 14, 0),
        allDay: false
      },
      {
        title: 'Birthday Party',
        start: new Date(y, m, d+1, 19, 0),
        end: new Date(y, m, d+1, 22, 30),
        allDay: false
      },
      {
        title: 'Click for Google',
        start: new Date(y, m, 28),
        end: new Date(y, m, 29),
        url: 'http://google.com/'
      }
    ]
  })
