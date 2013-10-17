

@clock = 
  startCountdown : (timer, options, completed) -> 
    timer?= 10
    completed?= options
    fps = 40
 
    $clockParent = $("#clock").empty().addClass('showing')
    
    bigEffect = 1

    if options?.big
      bigEffect = 6
      $clockParent.addClass('big')
    else if options?.med
      bigEffect = 1.8
      $clockParent.addClass('med')
    
    $clock = $('<input class="face">').appendTo $clockParent

    
    $clock.knob
      'readOnly':true
      'fgColor':'#333333'
      'width': 80 * bigEffect
      'height': 80 * bigEffect
      'thickness': .35
      'max':timer*fps
      'draw': ->
        a = @angle(@cv) # Angle
        sat = -1.57 # Start angle
        ea = undefined
        eat = sat + a # End angle
        @g.lineWidth = @lineWidth
        @g.beginPath()
        @g.strokeStyle = "#f7bb33"
        @g.arc @xy, @xy, @radius-(3*bigEffect), sat, eat, true
        @g.stroke()
        @g.beginPath();
        @g.fillStyle = 'white'
        @g.arc @xy, @xy, @radius-(6*bigEffect), 0, Math.PI*2, true
        @g.closePath();
        @g.shadowColor = "rgba( 0, 0, 0, 0.3 )";
        @g.shadowOffsetX = 0;
        @g.shadowOffsetY = 1*bigEffect;
        @g.shadowBlur = 4*bigEffect;
        @g.fill();

        @$.val Math.floor(timer - (@cv/fps))
        false

    $({value: -1}).stop(false,true).animate {value: timer*fps},
    duration: timer*1000
    easing: 'linear'
    step: ->
      $clock.val(Math.floor(this.value)).trigger('change')
    complete: ->
      $clockParent.removeClass('showing big med')
      completed() if completed?
      


  stopCountdown: ->
    Session.set "showingCountdown", false


