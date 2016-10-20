App.mouse = App.cable.subscriptions.create "MouseChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    window.receivedPointData = data

  speak: (time, mousex, mousey) ->
    @perform 'speak', timestamp: time, mousex: mousex, mousey: mousey

  $(document).on 'mousemove', (event) ->
  	App.mouse.speak (new Date()).getTime(), event.clientX, event.clientY