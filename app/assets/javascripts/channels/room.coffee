App.room = App.cable.subscriptions.create "RoomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    window.reader = new FileReader

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    feed = ""
    if data["name"] isnt ""
      feed = '<p>'+data["name"]+' :'
      if data["message"] isnt "" then feed += data["message"]
      feed += '</p>'
    　if data["image"] isnt null then feed += '<a href="'+data["image"]+'" target="blank_"><img width="240px" src="'+data["image"]+'"></a>'
     $('#messages').prepend(feed)
    
  speak: (name, message, result) ->
    @perform 'speak', name: name, message: message, image: result

  $(document).on 'click', '[data-behavior~=room_speaker]', (event) ->
  	nameForm = $('#name_form')
  	messageForm = $('#message_form')
  	fileForm = $('#file_form')
  	App.room.speak nameForm.val(), messageForm.val(), window.reader.result
  	messageForm.val('')
  	fileForm.val('')
  	window.reader = null
  	window.reader = new FileReader
    
  $(document).on 'change', '[data-behavior~=image_loader]', (event) ->
    window.reader.readAsDataURL(event.target.files[0])