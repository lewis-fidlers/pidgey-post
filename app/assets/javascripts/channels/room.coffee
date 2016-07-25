App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('#messages').append(data['message'])
    $('#messages').prop('scrollTop', $('#messages').prop('scrollHeight'))
    active_user = $('#user_email').data('userEmail')
    message_user = $('.user-info').last().data('userEmail')
    if active_user == message_user
      $('.message').last().addClass("bubble-right pull-sm-right")
    else
      $('.message').last().addClass("bubble-left pull-sm-left")

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()

