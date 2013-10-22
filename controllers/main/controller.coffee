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
  eventsObj = {}
  eventsObj["#{helpers.quickTouch} #forward-btn"] = -> helpers.move 'forward'
  eventsObj["#{helpers.quickTouch} #back-btn"] = -> helpers.move 'back'
  eventsObj["#{helpers.quickTouch} #reset-btn"] = -> 
    if confirm 'Are you sure you wish to reset the game?'
      Meteor.call 'reset'
  Template.controller.events eventsObj

