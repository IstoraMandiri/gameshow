
tieBreakStages = ['tiebreakInto','tiebreak']

# vars
# console.log collections
currentGame = -> 
  collections.Games.findOne({},{sort:{_id:-1}})

updateCurrentGame = (update) ->
  collections.Games.update currentGame()._id,
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
    stage = collections.Stages.findOne
      _id: currentGame().stages?[pos]
    return stage


currentPlayers = ->
  players = []
  if currentGame()?.players
    playerIds = currentGame().players
    for playerId in playerIds
      players.push collections.Players.findOne playerId
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
  newPlayer = collections.Players.insert options
  collections.Games.update currentGame()._id,
    $push :
      players : newPlayer
  return newPlayer

correctAnswer = (player) ->
  collections.Players.update {_id:player},
    $inc: 
      score: currentGame().correctPoints 
  # create new game class

currentCorrectAnswer = ->
  if currentQuestion()
    for option in currentQuestion().options
      if option.correct
        return option
  return false 


getPlayer = (player) -> collections.Players.findOne player

getScore = (player) ->
  score = 0
  if getPlayer(player)?.answers
    for answer in getPlayer(player).answers
      if answer.answer.correct
        score+= currentGame().correctPoints
  return score


currentQuestion = ->
  questionId = currentStage().question_id
  if questionId
    collections.Questions.findOne({_id:questionId})

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
    console.log 'new game being created'
    defaultGame = collections.Config.findOne({_id:'defaultGame'})

    if !defaultGame?
      defaultGame =
        _id:'defaultGame'
        correctPoints : 100
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

      collections.Config.insert defaultGame

    delete defaultGame._id
    collections.Games.insert defaultGame

  Meteor.startup ->
    if !currentGame()?
      createNewGame()
      insertFakeData()




if Meteor.isClient 
  # Session.delete()


  # pr
  $(document).on 'touchmove', (e) ->
    scrollable = false
    items = $(e.target).parents()
    $(items).each (i,o) ->
      if $(o).hasClass("scrollable")
        scrollable = true

    if !scrollable
        e.preventDefault()



  getURLParameter = (name) -> return decodeURIComponent((new RegExp("[?|&]#{name}=([^&;]+?)(&|##|;|$)").exec(location.search) || [null,""] )[1].replace(/\+/g, '%20'))||null;

  temporaryAdvance = ->
    inc = parseInt(Session.get('temporaryAdvance')) || 1
    Session.set 'temporaryAdvance', currentGame()?.position + inc
    console.log 'tempadv',Session.get('temporaryAdvance')

  quickTouch = if (@navigator.userAgent.match(/(iPhone|iPod|iPad)/) || @navigator.userAgent.match(/Android/)) then 'tap' else 'click'

  if getURLParameter 'view'
    Session.set 'view', getURLParameter('view')
  else
    Session.set 'view', 'player'

  currentPlayer = -> 
    if Session.get('currentPlayer')
      collections.Players.findOne Session.get('currentPlayer')
  
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
  Handlebars.registerHelper 'createForm', (formObj) -> createForm formObj

  Template.controller.position = -> currentGame()?.position

  # ugh
  eventsObj = {}
  eventsObj["#{quickTouch} #forward-btn"] = -> move 'forward'
  eventsObj["#{quickTouch} #back-btn"] = -> move 'back'
  eventsObj["#{quickTouch} #reset-btn"] = -> move 0
  Template.controller.events eventsObj


  processForm = (stage, template) ->
    fields = []
    $(template.findAll('.collect-data')).each ->
      $this = $(this)
      fieldTitle = $.trim($('label',this).text())
      if $("[type='checkbox']",$this).size() > 0
        fieldValue = $("[type='checkbox']",$this).attr('checked')?
      else
        fieldValue = $('.input', $this).val()
      fields.push
        title:fieldTitle
        value:fieldValue

    collections.Forms.insert
      player: currentPlayer()
      stage_id: stage._id
      title: stage.title
      fields: fields

  Template.stage.allowedToSee = ->
    (currentStage()?.registration is true or currentPlayer() or Session.equals('view','screen'))

  # Template.stage_form.events
  #   "click #submit" : (e,t) ->
  #     temporaryAdvance()
  #     e.preventDefault()

  Template.stage_form.content = -> currentStage().content
  
  Template.stage_form.rendered = ->
    if @rendered != currentStage()._id
      $.jqBootstrapValidation('destroy')
      @rendered = currentStage()._id
      t = @
      $form = $("input,select,textarea",$(t.find('form'))).not("[type=submit]")
      submitted = false
      $form.jqBootstrapValidation
          submitSuccess: (form, e) ->
            e.preventDefault()
            if !submitted
              submitted = true
              if currentStage().registration
                thisCurrentPlayer = createNewPlayer 
                  firstname: t.find('[name="firstname"]').value
                  lastname: t.find('[name="lastname"]').value
                Session.set 'currentPlayer', thisCurrentPlayer
              processForm currentStage(), t
              temporaryAdvance()

  Template.modal.message = -> Session.get('modalData')

  showModal = (data) -> 
    Session.set 'modalData', data
    Meteor.setTimeout ->
      $('#modal').modal
        fadeIn: true
        backdrop:false
    , 10

  Template.form_modal.events
    "click": (e,t) -> showModal @content
    

  # Template.controller_player_info.score = -> 
  #   getScore @._id
  # Template.question_content.voted = -> Session.equals 'voted', true
  # Template.question_content.created = -> Session.set 'voted', false
  # Template.player_info.myScore = ->
  #   getScore Session.get('currentPlayer')

  alreadyVoted = (playerId, questionId) ->
    if !getPlayer(playerId)?.answers
      return false
    for answer in getPlayer(playerId).answers
      if answer.question_id is questionId
        return true
    return false

  Template.question_content.voted = ->
    alreadyVoted Session.get('currentPlayer'), currentStage().question_id

    # return voted
  eventsObj = {}
  eventsObj["#{quickTouch}"] = (evt, template) ->
    question = collections.Questions.findOne currentStage().question_id
    playerId = Session.get('currentPlayer')
    # already voted?
    if !alreadyVoted Session.get('currentPlayer'), currentStage().question_id 

      collections.Players.update Session.get('currentPlayer'),
        $push:
          answers:
            question: question.text
            question_id: question._id
            answer: @
      
      collections.Players.update Session.get('currentPlayer'),
        $set:
          score: getScore playerId
    else
      console.log 'no multiple votes for you', Template.question_content.voted()

  Template.option.events eventsObj

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
      collections.Players.update Session.get('currentPlayer'),
        $set:
          video: @      
      Session.set 'votedOnVideo', true
      Meteor.call 'newVideoVote'
      # temporaryAdvance()


  Template.playing_video.created = ->
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


  Template.build_form.typeIs = (type) -> @.type is type

  Template.form_textbox.type = ->  @.validate || 'text'

  # Template.form_textbox.inputId = -> 


  # Template.form_textbox.required = -> if @.required then 'required' else ''


  Template.leaderboard.players = ->
    collections.Players.find {},
      sort:
        score: -1
        name: 1

  Template.stage_leaderboard.top10 = ->
    collections.Players.find({},{sort:{score:-1},limit:10})



