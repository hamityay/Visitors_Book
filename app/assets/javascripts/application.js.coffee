# This is a manifest file that will be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap
#= require chosen-jquery
#= require jquery.maskedinput.min
#= require jquery.datetimepicker
#= require nprogress
#= require trix
#= require rails.validations
#= require rails.validations.simple_form
#= require jquery-ui
//= require jquery.raty
//= require ratyrate

class @App

  @tooltip = ->
    $('[data-toggle="tooltip"]').tooltip()
    $('[data-toggle="toolbar-tooltip"]').tooltip()

  @ready = ->
    App.tooltip()

    $('.datetimepicker').datetimepicker
      format: $('.datetimepicker').data('format')
      step: 60
      lang: 'tr'
      minDate: 0
      defaultTime: '12:00'

    $( "[data-mask]").each (index, element) ->
      $element = $(element)
      $element.mask($element.data('mask'))

    $('.chosen-select').chosen
      allow_single_deselect: true
      placeholder_text: $('.chosen-select').attr('include_blank')

    $('.chosen-select-with-width').chosen
      allow_single_deselect: true
      placeholder_text: $('.chosen-select-with-width').attr('include_blank')
      width: '370px'

    $('form[data-turboform]').on('submit', (e) ->
      Turbolinks.visit @action + (if @action.indexOf('?') == -1 then '?' else '&') + $(this).serialize()
      false
    )

$(document).ready(App.ready)
$(document).on('page:load', App.ready)
$(window).on('page:load', App.ready)

# Turbolinks events
$(document).on 'page:fetch', ->
  NProgress.start()
  return
$(document).on 'page:change', ->
  NProgress.done()
  return
$(document).on 'page:restore', ->
  NProgress.remove()
  return
# jQuery events
# Trigger whenever ajax start
$(document).ajaxStart ->
  NProgress.start()
  return
# Complete the NProcess when ajax end
$(document).ajaxComplete ->
  NProgress.done()
  return

jQuery(document).ready ($) ->
  $('#myCarousel1').carousel interval: 5000
  $('#carousel-text').html $('#slide-content-0').html()
  #Handles the carousel thumbnails
  $('[id^=carousel-selector-]').click ->
    `var i`
    i = @i.substr(@i.lastIndexOf('-') + 1)
    i = parseInt(i)
    $('#myCarousel1').carousel id
    return
  # When the carousel slides, auto update the text
  $('#myCarousel1').on 'slid.bs.carousel', (e) ->
    i = $('.item.active').data('slide-number')
    $('#carousel-text').html $('#slide-content-' + i).html()
    return
  return

$(document).ready ->
  $(window).scroll ->
    if $(this).scrollTop() > 50
      $('#back-to-top').fadeIn()
    else
      $('#back-to-top').fadeOut()
    return
  # scroll body to 0px on click
  $('#back-to-top').click ->
    $('#back-to-top').tooltip 'hide'
    $('body,html').animate { scrollTop: 0 }, 800
    false
  $('#back-to-top').tooltip 'show'
  return