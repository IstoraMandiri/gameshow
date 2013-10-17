if Meteor.isClient

  Template.controller.position = -> helpers.currentGame()?.position

  Template.controller_info.winningVideo = ->  helpers.currentGame()?.winningVideo?.title

  Template.controller_player_info.totalAnswerTime = -> 
    filters.milisToSeconds helpers.totalAnswerTime @._id

  Template.controller_player_info.currentAnswerTime = -> 
    filters.milisToSeconds helpers.currentAnswerTime @._id

  # ugh
  eventsObj = {}
  eventsObj["#{helpers.quickTouch} #forward-btn"] = -> helpers.move 'forward'
  eventsObj["#{helpers.quickTouch} #back-btn"] = -> helpers.move 'back'
  eventsObj["#{helpers.quickTouch} #reset-btn"] = -> Meteor.call 'reset'
  Template.controller.events eventsObj

