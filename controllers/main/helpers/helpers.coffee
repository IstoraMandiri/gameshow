
prevGame = null

@filters =
  milisToSeconds : (number) ->
    seconds = number / 1000
    Math.round(seconds*100)/100
  
  breakLines : (text) ->
    if text?
      text = text.replace(/(\r\n|\n|\r)/gm, '<br>')
      return new Handlebars.SafeString(text)


@helpers = 
  
  getPlayer : (player) -> 
    if player?
      collections.Players.findOne player

  defaultConfig: -> collections.Config.findOne({_id:'defaultGame'})

  showModal : (data) -> 
    Session.set 'modalData', data
    Meteor.setTimeout ->
      $('#modal').modal
        backdrop:false
    , 10

    # false
  clearSession : ->
    for key,val of Session.keys
      if key isnt 'view'
        Session.set key, undefined

  currentStage : ->
    if helpers.currentGame()?
      pos = helpers.currentGame().position
      if Meteor.isClient  
        tempAdvance = Session.get 'temporaryAdvance'
        if pos < tempAdvance
          pos = tempAdvance
        else
          Session.set 'temporaryAdvance', false
      stage = collections.Stages.findOne
        _id: helpers.currentGame().stages?[pos]
      return stage

  nextStage : ->
    if helpers.currentGame()?
      pos = helpers.currentGame().position + 1
      collections.Stages.findOne
        _id: helpers.currentGame().stages?[pos]

  
  currentPlayer : -> 
    if Session.get('currentPlayer')
      collections.Players.findOne Session.get('currentPlayer')

  currentGame : ->
    newCurrentGame = collections.Games.findOne({},{sort:{created:-1}})
    if Meteor.isClient 
      if prevGame? and newCurrentGame? and (prevGame._id isnt newCurrentGame._id)
        helpers.clearSession()
      prevGame = newCurrentGame

    return newCurrentGame

  currentPlayers : ->
    players = []
    if helpers.currentGame()?.players
      playerIds = helpers.currentGame().players
      for playerId in playerIds
        players.push collections.Players.findOne playerId
    return players

  currentScores: ->
    arr = helpers.currentPlayers().sort (a,b) ->
      a.score - b.score
    return arr.reverse()

  updateCurrentGame : (update) ->
    collections.Games.update helpers.currentGame()._id,
      $set : update

  highgestScore : (players) ->
    maxScore = _.max players, (player) ->
      player.score
    return maxScore.score

  highestScorers : (players) ->
    highScore = helpers.highgestScore players
    winners = []
    for player in players
      if player.score is highScore
        winners.push player
    return winners

  totalAnswerTime : (player) ->
    timeTaken = 0
    thisPlayer = helpers.getPlayer player
    if thisPlayer.answers?
      for answer in thisPlayer.answers
        timeTaken+= answer.timeTaken
    return timeTaken


  currentAnswerTime : (player) ->
    timeTaken = 0
    currentQuestionId = helpers.currentStage().question_id
    thisPlayer = helpers.getPlayer player
    if thisPlayer.answers?
      for answer in thisPlayer.answers
        if answer.question_id is currentQuestionId
         timeTaken = answer.timeTaken
    return timeTaken


  move : (position) ->

    if position is 'back'
      newPosition = helpers.currentGame().position - 1
    else if position is 'forward'
      newPosition = helpers.currentGame().position + 1
    else
      newPosition = position

    if newPosition >= 0 and newPosition < helpers.currentGame().stages.length # stages length
      if helpers.currentGame().stages[newPosition] is 'leaderboard' and helpers.currentGame().tiebreak and !helpers.currentGame().tiebreak.complete
        Meteor.call 'tiebreakComplete'
      else
        helpers.updateCurrentGame 
          position: newPosition

        if helpers.currentStage().type is 'answer'
          Meteor.call 'questionComplete'

        if helpers.currentGame().stages[newPosition] is 'results'
          Meteor.call 'quizComplete'

        if helpers.currentGame().stages[newPosition] is 'videoPlay'
          Meteor.call 'generateQuestions'


if Meteor.isClient

  helpers.quickTouch = if (@navigator.userAgent.match(/(iPhone|iPod|iPad)/) || @navigator.userAgent.match(/Android/)) then 'touchstart' else 'click'