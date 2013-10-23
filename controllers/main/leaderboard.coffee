if Meteor.isClient

  Template.leaderboard.scores = -> 
    stageType = helpers.currentStage().type
    if helpers.currentStage()._id is 'leaderboard' 
      players = collections.Players.find({},{sort:{score:-1}}).fetch()
      for player in players
        player.time = filters.milisToSeconds helpers.totalAnswerTime player
      players.sort (a,b) ->
        return b.score - a.score  ||  a.time - b.time
      players = players.slice(0,10)
      return players
    else if stageType is 'tiebreakResults'
      tiebreak.results()
    else
      players = helpers.currentScores()
      for player in players
        player.time = filters.milisToSeconds helpers.totalAnswerTime player
      return players

  

  Template.leaderboard_player.isTiebreak = -> helpers.currentStage().type is 'tiebreakResults'

  Template.leaderboard_player.isLeaderboard = -> helpers.currentStage()._id is 'leaderboard'

  Template.leaderboard.text = -> 
    stageType = helpers.currentStage().type
    if helpers.currentStage()._id is 'leaderboard' 
      'Overall Leaders' 
    else if stageType is 'tiebreakResults' 
      'Tiebreak Results'
    else if stageType is 'results' 
      'Game Results'
    else
      'Scores'

