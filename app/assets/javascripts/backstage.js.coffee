//= require jquery
//= require foundation
//= require placeholders

jQuery ->

  $(document).foundation()
  $('header .notice, header .alert').delay(1500).slideUp('fast')
