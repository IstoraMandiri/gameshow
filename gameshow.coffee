
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

  for player in fakePlayers
    createNewPlayer
      firstname: player.firstname
      lastname: player.lastname
      company: player.company
      position: player.position
      email: player.email

  # Config.insert
  #   _id:'config'
  #   position: 0
  #   stages: ['home','register','home','form','home','videoSelect','videoPlay','home','question','answer','question','answer','question','answer','tiebreakInto','tiebreak','home','results','leaderboard','home']
    # stages: ['home']
  
  Stages.insert
    title: 'Holding Slide'
    _id: 'home'
    type: 'static'
  
  Stages.insert
    _id: 'register'
    type: 'registration'

  Stages.insert
    _id: 'form'
    type: 'form'
    content: 'form'

  Stages.insert
    _id: 'videoSelect'
    type: 'static'
    content: 
      default: """<h1>Select Video</h1>
        <hr>
        <div class='btn btn-video'>Video 1</div>
        <div class='btn btn-video'>Video 2</div>
        <div class='btn btn-video'>Video 3</div>
        <div class='btn btn-video'>Video 4</div>  
      """
      screen: """<h1>Select Video</h1>
        <hr>
        <div class='btn btn-video'>Video 1</div>
        <div class='btn btn-video'>Video 2</div>
        <div class='btn btn-video'>Video 3</div>
        <div class='btn btn-video'>Video 4</div>  
      """


  Stages.insert
    _id: 'videoPlay'
    type: 'static'
    content:
      default: '<h1>Holding Slide</h1>'
      screen: '<h1>Playing Video</h1><div class="btn btn-video">Video Full Screen</div>'          

  Stages.insert
    _id: 'question'
    type: 'question'
    question_id: 'objId'

  Stages.insert
    _id: 'answer'
    type: 'answer'
    question_id: 'objId'

  Stages.insert
    _id: 'tiebreakInto'
    type: 'static'
    content:
      default: '<h1>Tie Break Rules</h1><h2>Pres the buttons on the next screen...</h2>'
      screen: '<h1>Tie Break Rules (Screen)</h1>'

  Stages.insert
    _id: 'tiebreak'
    type: 'static'
    content:
      default: '<h1>Tie Break Entry</h1><h2><div class="btn">1</div> <div class="btn">2</div> <div class="btn">3</div> <div class="btn">4</div> <div class="btn">5</div> <br/><div class="btn">6</div> <div class="btn">7</div> <div class="btn">8</div> <div class="btn">9</div> <div class="btn">10</div> </h2>'
      screen: '<h1>1 2 3 4 5<br/>6 7 8 9 10</h1><h2 class="countdown">Countdown Clock</h2>'

  Stages.insert
    _id: 'results'
    type: 'results'

  Stages.insert
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
    # pos = pos + 1 if Session.equals 'temporaryAdvance', true
    Stages.findOne
      _id: currentGame().stages?[pos]

currentPlayers = ->
  if currentGame()?
    playerIds = currentGame().players
    players = []
    for playerId in playerIds
      players.push Players.findOne playerId
    return players

topTenOverallPlayers = ->
  Players.find({},{sort:{score:-1},limit:10})

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

      
alreadyVoted = (playerId, questionId) ->
  if !getPlayer(playerId)?.answers?
    return false
  for answer in getPlayer(playerId).answers
    if answer.question_id is questionId
      return true
  return false


getPlayer = (player) -> Players.findOne player

getScore = (player) ->
  score = 0
  if getPlayer(player)?.answers
    for answer in getPlayer(player).answers
      if answer.answer.correct
        score+= correctAnswerPoints
  return score



# if Meteor.isServer
  # pick up from from prevous game

if Meteor.isServer

  createNewGame = ->
    defaultGame = Config.findOne({_id:'defaultGame'})

    if !defaultGame?
      defaultGame =
        _id:'defaultGame'
        position: 0
        stages: ['home','register','home','form','home','videoSelect','videoPlay','home','question','answer','question','answer','question','answer','tiebreakInto','tiebreak','home','results','leaderboard','home']

      Config.insert defaultGame

    delete defaultGame._id
    Games.insert defaultGame

  Meteor.startup ->
    if !currentGame()?
      createNewGame()
      insertFakeData()



if Meteor.isClient 

  getURLParameter = (name) -> return decodeURIComponent((new RegExp("[?|&]#{name}=([^&;]+?)(&|##|;|$)").exec(location.search) || [null,""] )[1].replace(/\+/g, '%20'))||null;

  quickTouch = if (@navigator.userAgent.match(/(iPhone|iPod|iPad)/) || @navigator.userAgent.match(/Android/)) then 'tap' else 'click'

  if getURLParameter 'view'
    Session.set 'view', getURLParameter('view')
  else
    Session.set 'view', 'player'

  Handlebars.registerHelper 'screenMode', -> Session.equals 'view', 'screen'
  Handlebars.registerHelper 'controllerMode', -> Session.equals 'view', 'control'
  Handlebars.registerHelper 'playerMode', -> Session.equals 'view', 'player'  
  Handlebars.registerHelper 'currentStage', -> currentStage()
  Handlebars.registerHelper 'currentPlayers', -> currentPlayers()
  Handlebars.registerHelper 'topTenOverallPlayers', -> topTenOverallPlayers()


  Handlebars.registerHelper 'currentPlayer', -> Players.findOne Session.get('currentPlayer')


  Handlebars.registerHelper 'currentQuestion', ->
    questionId = currentStage().question_id
    if questionId
      Questions.findOne({_id:questionId})

  Handlebars.registerHelper 'renderCurrentStage', ->   
    if currentStage()?.type
      new Handlebars.SafeString(Template["stage_#{currentStage()?.type}"](currentStage()));
  
  Template.controller.position = -> currentGame()?.position

  Template.controller.events
    "click #forward-btn" : -> move 'forward'
    "click #back-btn" : -> move 'back'
    "click #reset-btn" : -> move 0

  Template.stage_form.events
    "click #submit" : (e,t) ->
      alert 'Submitted'
      e.preventDefault()

  Template.stage_registration.events
    "click #submit" : (e,t) ->
      # do some validation first
      currentPlayer = createNewPlayer 
        firstname: t.find('#firstname').value
        lastname: t.find('#lastname').value
        company: t.find('#company').value
        position: t.find('#position').value
        email: t.find('#email').value
      
      Session.set 'currentPlayer', currentPlayer  
      
      e.preventDefault()
      
      # temporary advance

    "click .tandc" : (e,t) -> correctAnswer Session.get 'currentPlayer'


  # Template.controller_player_info.score = -> 
  #   getScore @._id
  # Template.stage_question.voted = -> Session.equals 'voted', true
  # Template.stage_question.created = -> Session.set 'voted', false
  # Template.player_info.myScore = ->
  #   getScore Session.get('currentPlayer')

  Template.option.events
    "click" : (evt, template) ->
      question = Questions.findOne currentStage().question_id
      playerId = Session.get('currentPlayer')

      
      # already voted?
      if !alreadyVoted playerId, currentStage().question_id 

        Players.update playerId,
          $push:
            answers:
              question: question.text
              question_id: question._id
              answer: @
        
        Players.update playerId,
          $set:
            score: getScore playerId
      else
        console.log 'no multiple votes for you'
          # submitAnswer

  Template.leaderboard.players = ->
    Players.find {},
      sort:
        score: -1
        name: 1

