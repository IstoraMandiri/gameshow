if Meteor.isClient

  Template.controller_info.position = -> helpers.currentGame()?.position

  Template.controller_info.winningVideo = ->  helpers.currentGame()?.winningVideo?.title

  Template.controller_player_info.totalAnswerTime = -> 
    filters.milisToSeconds helpers.totalAnswerTime @._id

  Template.controller_player_info.currentAnswerTime = -> 
    filters.milisToSeconds helpers.currentAnswerTime @._id

  Template.controller_player_info.caughtUp = -> 
    leadingPos = 0
    for player in helpers.currentPlayers()
      if player.position > leadingPos
        leadingPos = player.position
    if @position >= leadingPos then true else false

  # ugh
  forwardDisabled = -> 
    if helpers.currentStage()?
      if helpers.currentStage()?._id is 'register' and helpers.currentPlayers().length < 2
        return true
      if helpers.currentStage()?._id is 'videoSelect' and !helpers.currentGame()?.winningVideo?
        return true
    return Session.equals 'forwardDisabled', true


  Template.controller.forwardDisabled = -> forwardDisabled()


  Template.controller.backDisabled = -> Session.equals 'backDisabled', true
  
  eventsObj = {}
  eventsObj["#{helpers.quickTouch} #forward-btn"] = (e,t) ->
    if !forwardDisabled()
      Session.set 'forwardDisabled', true
      Meteor.setTimeout ->
        Session.set 'forwardDisabled', false
      , 1000
      helpers.move 'forward'

  eventsObj["#{helpers.quickTouch} #back-btn"] = ->
    if !Session.equals 'backDisabled', true
      Session.set 'backDisabled', true
      Meteor.setTimeout ->
        Session.set 'backDisabled', false
      , 1000
      helpers.move 'back'

  eventsObj["#{helpers.quickTouch} #reset-btn"] = -> 
    if confirm 'Are you sure you wish to reset the game?'
      Meteor.call 'reset'
  Template.controller.events eventsObj

