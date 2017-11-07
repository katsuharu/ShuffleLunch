App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#messages').append data['message']
    if $('form.form-horizontal').attr('id') is data['message'].match(/user_id_\d+/)[0]
      $('.chat_box').scrollTop($('.chat_box')[0].scrollHeight)

  speak: (content) ->
    @perform 'speak', {content: content}

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    App.room.speak($('.js-content').val())
    $('.js-content').val('')
    return false

$ ->
  if $('.chat_box').length
    $('.chat_box').scrollTop($('.chat_box')[0].scrollHeight)