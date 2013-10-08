if Meteor.isClient

  Template.leaderboard.scores = -> 
    stageType = helpers.currentStage().type
    if stageType is 'leaderboard' 
      collections.Players.find({},{sort:{score:-1},limit:10})
    else if stageType is 'tiebreakResults'
      tiebreak.results()
    else
      helpers.currentScores()
    
  Template.leaderboard.text = -> 
    stageType = helpers.currentStage().type
    console.log 'STAGE', stageType
    if stageType is 'leaderboard' 
      'Overall Leaders' 
    else if stageType is 'tiebreakResults' 
      'Tiebreak Results'
    else if stageType is 'results' 
      'Game Results'
    else
      'Scores'

