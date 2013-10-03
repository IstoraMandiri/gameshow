if Meteor.isClient

  Template.clock.rendered = ->
    timer = 10 # seconds
    $clock = $('#clock .face')
    $clock.knob
      'readOnly':true
      'fgColor':'#000000'
      'thickness':.2
      'max':timer*100
      'draw': ->
        @$.val Math.ceil(@cv/100)
        a = @angle(@cv) # Angle
        sat = @startAngle # Start angle
        ea = undefined
        eat = sat + a # End angle
        r = 1
        @g.lineWidth = @lineWidth
        @g.beginPath()
        @g.strokeStyle = @fgColor
        @g.arc @xy, @xy, @radius - @lineWidth, sat, eat, false
        @g.stroke()
        false

    $({value: timer*100}).animate {value: -1},
    duration: timer*1000
    easing: 'linear'
    step: ->
      $clock.val(Math.floor(this.value)).trigger('change')
