jQuery ->
  $('input#email').on 'blur', ->
    $(this).mailcheck()