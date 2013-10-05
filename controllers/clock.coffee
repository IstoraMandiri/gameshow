

@clock = 
  startCountdown : (timer, options, completed) -> 
    timer?= 10
    completed?= options
    fps = 40
 
    $clockParent = $("#clock").empty().addClass('showing')
    if options?.big
      big = true
      $clockParent.addClass('big')
    
    $clock = $('<input class="face">').appendTo $clockParent

    $clock.knob
      'readOnly':true
      'fgColor':'#000000'
      'width': if big? then 350 else 150
      'height': if big? then 350 else 150
      'thickness':if big? then .45 else .35 
      'max':timer*fps
      'draw': ->
        a = @angle(@cv) # Angle
        sat = -1.57 # Start angle
        ea = undefined
        eat = sat + a # End angle
        @g.lineWidth = @lineWidth
        @g.beginPath()
        @g.strokeStyle = @fgColor
        @g.arc @xy, @xy, @radius, sat, eat, true
        @g.stroke()
        @$.val Math.floor(timer - (@cv/fps))
        false

    $({value: -1}).stop(false,true).animate {value: timer*fps},
    duration: timer*1000
    easing: 'linear'
    step: ->
      $clock.val(Math.floor(this.value)).trigger('change')
    complete: ->
      $clockParent.removeClass('showing big')
      completed() if completed?
      


  stopCountdown: ->
    Session.set "showingCountdown", false


