App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    switch data["action"]
      when "started_typing" then @userIsTyping(data["user"])
      when "stopped_typing" then @userStoppedTyping(data["user"])
      when "new_message" then @newMessage(data["message"])

  speak: (message) ->
    @perform 'speak', message: message

  startedTyping: (user) ->
    @perform 'user_is_typing', message: user

  stoppedTyping: (user) ->
    @perform 'user_stopped_typing', message: user

  userEmail: () ->
    $('#user_email').data('userEmail')

  userIsTyping: (email) ->
    unless email == @userEmail()
      $('#typing-info').html(email + " is typing a message.")

  userStoppedTyping: (email) ->
    $('#typing-info').html("")

  newMessage: (message) ->
    $('#messages').append(message)
    $('#messages').prop('scrollTop', $('#messages').prop('scrollHeight'))
    active_user = @userEmail()
    message_user = $('.user-info').last().data('userEmail')
    if active_user == message_user
      $('.message').last().addClass("bubble-right pull-sm-right")
    else
      $('.message').last().addClass("bubble-left pull-sm-left")

$(document).on 'keypress', '[data-behavior~=room_speaker]', (event) ->
  if event.keyCode is 13
    App.room.speak event.target.value
    event.target.value = ''
    event.preventDefault()

typingTimer = undefined
doneTypingInterval = 10
finaldoneTypingInterval = 500
isTyping = false

$(document).on 'keydown', '#message-input', (event) ->
  clearTimeout typingTimer
  if $('#message-input').val
    typingTimer = setTimeout((->
      if !isTyping
        isTyping = true
        App.room.startedTyping(App.room.userEmail())

    ), doneTypingInterval)

$(document).on 'keyup', '#message-input', (event) ->
  clearTimeout typingTimer
  typingTimer = setTimeout((->
    isTyping = false
    App.room.stoppedTyping(App.room.userEmail())
  ), finaldoneTypingInterval)
