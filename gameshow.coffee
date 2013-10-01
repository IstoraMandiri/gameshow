
tieBreakStages = ['tiebreakInto','tiebreak']

insertFakeData = ->

  fakePlayers = [
    firstname: 'Chris'
    lastname: 'Hitchcott'
    company: 'TAPevents'
    position: 'CTO'
    email: 'chris@tapevents.net'
  ,
    firstname: 'Joe'
    lastname: 'Syntax'
    company: 'Hospital Records'
    position: 'Producer'
    email: 'joe@hospitalrecords.com'
  ,
    firstname: 'Bob'
    lastname: 'Jones'
    company: 'Company X'
    position: 'CEO'
    email: 'bob@company-x.com'
  ]

  # for player in fakePlayers
  #   createNewPlayer
  #     firstname: player.firstname
  #     lastname: player.lastname
  #     company: player.company
  #     position: player.position
  #     email: player.email

  
  Stages.insert
    title: 'Holding Slide'
    _id: 'home'
    type: 'static'
  
  Stages.insert
    title: 'Registration Form'
    _id: 'register'
    type: 'registration'
    content: 'form'

  Stages.insert
    title: 'More Info Form'  
    _id: 'form'
    type: 'form'
    content: 'form'

  Stages.insert
    _id: 'videoSelect'
    type: 'video_select'
    title: 'Selecting Video...'

  Stages.insert
    _id: 'videoPlay'
    type: 'video_play'
    title: 'Playing Video...'

  Stages.insert
    title: 'Question 1'
    _id: 'question'
    type: 'question'
    question_id: 'objId'

  Stages.insert
    title: 'Question 1 Answer' 
    _id: 'answer'
    type: 'answer'
    question_id: 'objId'

  Stages.insert
    title: 'Question 2'   
    _id: 'question2'
    type: 'question'
    question_id: 'objId2'

  Stages.insert
    title: 'Question 2 Answer'   
    _id: 'answer2'
    type: 'answer'
    question_id: 'objId2'

  Stages.insert
    title: 'Tiebreak Intro'   
    _id: 'tiebreakInto'
    type: 'static'
    content:
      default: '<h1>Tie Break Rules</h1><h2>Pres the buttons on the next screen...</h2>'
      screen: '<h1>Tie Break Rules (Screen)</h1>'

  Stages.insert
    title: 'Tiebreaker'   
    _id: 'tiebreak'
    type: 'static'
    content:
      default: '<h1>Tie Break Entry</h1><h2><div class="btn">1</div> <div class="btn">2</div> <div class="btn">3</div> <div class="btn">4</div> <div class="btn">5</div> <br/><div class="btn">6</div> <div class="btn">7</div> <div class="btn">8</div> <div class="btn">9</div> <div class="btn">10</div> </h2>'
      screen: '<h1>1 2 3 4 5<br/>6 7 8 9 10</h1><h2 class="countdown">Countdown Clock</h2>'

  Stages.insert
    title: 'This game results'  
    _id: 'results'
    type: 'results'

  Stages.insert
    title: 'Overall Leaderboard'  
    _id: 'leaderboard'
    type: 'leaderboard'


  Questions.insert
    _id: 'objId'
    text: 'Question Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'                    
    ]

  Questions.insert
    _id: 'objId2'
    text: 'Question 2 Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'                    
    ]    

# vars


correctAnswerPoints = 100


Games = new Meteor.Collection 'games'
Config = new Meteor.Collection 'config'
Players = new Meteor.Collection 'players'
Stages = new Meteor.Collection 'stages'
Questions = new Meteor.Collection 'questions'

currentGame = -> 
  Games.findOne({},{sort:{_id:-1}})

updateCurrentGame = (update) ->
  Games.update currentGame()._id,
    $set : update

currentStage = ->
  if currentGame()?
    pos = currentGame().position
    if Meteor.isClient  
      tempAdvance = Session.get 'temporaryAdvance'
      if pos < tempAdvance
        pos = tempAdvance
      else
        Session.set 'temporaryAdvance', false
    stage = Stages.findOne
      _id: currentGame().stages?[pos]
    return stage


currentPlayers = ->
  players = []
  if currentGame()?.players
    playerIds = currentGame().players
    for playerId in playerIds
      players.push Players.findOne playerId
  return players


move = (position) ->

  if position is 'back'
    newPosition = currentGame().position - 1
  else if position is 'forward'
    newPosition = currentGame().position + 1
  else
    newPosition = position

  if newPosition >= 0 and newPosition < currentGame().stages.length # stages length
    updateCurrentGame 
      position: newPosition

    if currentGame().stages[newPosition] is 'results'
      Meteor.call 'quizComplete'


createNewPlayer = (options) ->
  options.score = 0
  newPlayer = Players.insert options
  Games.update currentGame()._id,
    $push :
      players : newPlayer
  return newPlayer

correctAnswer = (player) ->
  Players.update {_id:player},
    $inc: 
      score: correctAnswerPoints 
  # create new game class

currentCorrectAnswer = ->
  if currentQuestion()
    for option in currentQuestion().options
      if option.correct
        return option
  return false 


getPlayer = (player) -> Players.findOne player

getScore = (player) ->
  score = 0
  if getPlayer(player)?.answers
    for answer in getPlayer(player).answers
      if answer.answer.correct
        score+= correctAnswerPoints
  return score


currentQuestion = ->
  questionId = currentStage().question_id
  if questionId
    Questions.findOne({_id:questionId})

highgestScore = ->
  maxScore = _.max currentPlayers(), (player) ->
    player.score
  return maxScore.score

highestScorers = ->
  highScore = highgestScore()
  winners = []
  for player in currentPlayers()
    if player.score is highScore
      winners.push player
  return winners

# newVideoVote = ->
#   console.log 'voaaaat.'
#   if Meteor.isServer
#     console.log 'got a new video vote'

winningVideo = -> 1

if Meteor.isServer
  

  Meteor.methods
    'quizComplete': ->
      console.log 'Quiz Complete, Checking Results'
      winners = highestScorers()
      if winners.length is 1
        console.log 'We have one winner!'
        noTieBreakStages = _.filter currentGame().stages, (stage) ->
          !(tieBreakStages.indexOf(stage) >= 0)

        updateCurrentGame 
          stages: noTieBreakStages
      else if winners.length > 1
        console.log 'Tiebreak situation'
        tieBreakers = winners 

        
    'newVideoVote': ->
      
      ###
      # needs fixing with some real math
      ### 
      # haveresults?
      if !currentGame().winningVideo?
        potentialVotes = currentPlayers().length
        numberOfVideos = 3

        minForVictory = 3
        
        videoVotes = _.countBy currentPlayers(), (player) ->
          player.video?.id
      

        for key,value of videoVotes      
          if key isnt 'undefined'
            if value >= minForVictory
              updateCurrentGame 
                winningVideo:key
              move 'forward'
              break

  createNewGame = ->
    defaultGame = Config.findOne({_id:'defaultGame'})

    if !defaultGame?
      defaultGame =
        _id:'defaultGame'
        position: 0
        stages: ['home','register','form','home','videoSelect','home','videoPlay','home','question','answer','question2','answer2','home','results','tiebreakInto','tiebreak','leaderboard','home']
        videos: [
          id: 1
          title:'Video 1'
          file:'test1.mp4'
        ,
          id: 2
          title:'Video 2'
          file:'test2.mp4'
        ,
          id: 3
          title:'Video 3'
          file:'test3.mp4'
        ]

      Config.insert defaultGame

    delete defaultGame._id
    Games.insert defaultGame

  Meteor.startup ->
    if !currentGame()?
      createNewGame()
      insertFakeData()



if Meteor.isClient 

  getURLParameter = (name) -> return decodeURIComponent((new RegExp("[?|&]#{name}=([^&;]+?)(&|##|;|$)").exec(location.search) || [null,""] )[1].replace(/\+/g, '%20'))||null;

  temporaryAdvance = ->
    inc = parseInt(Session.get('temporaryAdvance')) || 1
    Session.set 'temporaryAdvance', currentGame()?.position + inc

  quickTouch = if (@navigator.userAgent.match(/(iPhone|iPod|iPad)/) || @navigator.userAgent.match(/Android/)) then 'tap' else 'click'

  if getURLParameter 'view'
    Session.set 'view', getURLParameter('view')
  else
    Session.set 'view', 'player'


  currentPlayer = ->
    Players.findOne Session.get('currentPlayer')

  Handlebars.registerHelper 'screenMode', -> Session.equals 'view', 'screen'
  Handlebars.registerHelper 'controllerMode', -> Session.equals 'view', 'control'
  Handlebars.registerHelper 'playerMode', -> Session.equals 'view', 'player'  
  Handlebars.registerHelper 'currentStage', -> currentStage()
  Handlebars.registerHelper 'currentPlayers', -> currentPlayers()
  Handlebars.registerHelper 'currentCorrectAnswer', -> currentCorrectAnswer()
  Handlebars.registerHelper 'currentPlayer', -> currentPlayer()
  Handlebars.registerHelper 'currentQuestion', -> currentQuestion()
  Handlebars.registerHelper 'renderCurrentStage', ->   
    if currentStage()?.type
      new Handlebars.SafeString(Template["stage_#{currentStage()?.type}"](currentStage()));
  
  Template.controller.position = -> currentGame()?.position

  Template.controller.events
    "click #forward-btn" : -> move 'forward'
    "click #back-btn" : -> move 'back'
    "click #reset-btn" : -> move 0

  Template.stage.allowedToSee = ->
    (currentStage()?.type is 'registration' or currentPlayer() or Session.equals('view','screen'))

  Template.stage_form.events
    "click #submit" : (e,t) ->
      temporaryAdvance()
      e.preventDefault()

  Template.stage_registration.events
    "click #submit" : (e,t) ->
      # do some validation first
      e.preventDefault()

      @currentPlayer = createNewPlayer 
        firstname: t.find('#firstname').value
        lastname: t.find('#lastname').value
      
      Session.set 'currentPlayer', @currentPlayer
      
      # process the form

      temporaryAdvance()

    "click .tandc" : (e,t) -> correctAnswer Session.get 'currentPlayer'


  # Template.controller_player_info.score = -> 
  #   getScore @._id
  # Template.stage_question.voted = -> Session.equals 'voted', true
  # Template.stage_question.created = -> Session.set 'voted', false
  # Template.player_info.myScore = ->
  #   getScore Session.get('currentPlayer')

  alreadyVoted = (playerId, questionId) ->
    if !getPlayer(playerId)?.answers
      console.log 'no answers'
      return false
    for answer in getPlayer(playerId).answers
      if answer.question_id is questionId
        return true
    return false

  Template.stage_question.voted = ->
    alreadyVoted Session.get('currentPlayer'), currentStage().question_id

    # return voted

  Template.option.events
    "click" : (evt, template) ->
      question = Questions.findOne currentStage().question_id
      playerId = Session.get('currentPlayer')
      # already voted?
      if !alreadyVoted Session.get('currentPlayer'), currentStage().question_id 

        Players.update Session.get('currentPlayer'),
          $push:
            answers:
              question: question.text
              question_id: question._id
              answer: @
        
        Players.update Session.get('currentPlayer'),
          $set:
            score: getScore playerId
      else
        console.log 'no multiple votes for you', Template.stage_question.voted()
          # submitAnswer

  Template.stage_answer.answered = ->
    if Session.get('currentPlayer')?
      answers = getPlayer(Session.get('currentPlayer')).answers
      currentQuestionId = currentQuestion()._id
      if answers
        for answer in answers
          console.log answer.question_id, currentQuestionId
          if answer.question_id is currentQuestionId
            console.log answer
            return true
    return false


  Template.stage_answer.answeredCorrectly = ->
    answers = getPlayer(Session.get('currentPlayer')).answers?= []
    for answer in answers
      if answer.question_id is currentQuestion()._id
        if answer.answer.correct
          return true
    return false


  Template.stage_video_select.videos = -> currentGame().videos

  Template.stage_video_select.voted = -> Session.get 'votedOnVideo', true

  Template.video_button.events = 
    "click" : (evt, template) ->
      Players.update Session.get('currentPlayer'),
        $set:
          video: @      
      Session.set 'votedOnVideo', true
      Meteor.call 'newVideoVote'
      # temporaryAdvance()




  Template.playing_video.created = (template) ->
    Meteor.setTimeout ->
      $video = $('video')[0]
      $video.play()
      $video.addEventListener 'ended', ->
        move 'forward'
    , 100


  Template.stage_results.iAmWinner = ->
    thisPlayerId = currentPlayer()._id 
    for winner in highestScorers()
      if winner._id is thisPlayerId
        return true
        break
    return false


  Template.leaderboard.players = ->
    Players.find {},
      sort:
        score: -1
        name: 1

  Template.stage_leaderboard.top10 = ->
    Players.find({},{sort:{score:-1},limit:10})



