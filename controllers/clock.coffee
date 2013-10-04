if Meteor.isClient

  Template.clock.rendered = ->

    timer = 15 # seconds
    fps = 40
    $clock = $('#clock .face')
    $clock.knob
      'readOnly':true
      'fgColor':'#000000'
      'width':150
      'height':150
      'thickness':.35
      'max':timer*fps
      'draw': ->
        a = @angle(@cv) # Angle
        sat = -1.57 # Start angle
        ea = undefined
        eat = sat + a # End angle
        @g.lineWidth = @lineWidth
        @g.beginPath()
        @g.strokeStyle = @fgColor
        @g.arc @xy, @xy, @radius+18 - @lineWidth, sat, eat, true
        @g.stroke()
        @$.val Math.floor(timer - (@cv/fps))
        false

    $({value: -1}).animate {value: timer*fps},
    duration: timer*1000
    easing: 'linear'
    step: ->
      $clock.val(Math.floor(this.value)).trigger('change')
