

# vars


# console.log collections



 
createNewPlayer = (options) ->
  options.score = 0
  newPlayer = collections.Players.insert options
  collections.Games.update helpers.currentGame()._id,
    $push :
      players : newPlayer
  return newPlayer


currentCorrectAnswer = ->
  if currentQuestion()
    for option in currentQuestion().options
      if option.correct
        return option
  return false 


getScore = (player) ->
  score = 0
  if helpers.getPlayer(player)?.answers
    for answer in helpers.getPlayer(player).answers
      if answer.answer.correct
        score+= helpers.currentGame().correctPoints
  return score


currentQuestion = ->
  questionId = helpers.currentStage().question_id
  if questionId
    collections.Questions.findOne({_id:questionId})

bonusTimeToBeat = ->
  timeToBeat = null
  for player in helpers.currentPlayers()
    if player.answers?
      for answer in player.answers
        if answer.question_id is helpers.currentStage().question_id and answer.answer?.correct
          if !timeToBeat? or timeToBeat > answer.timeTaken
            timeToBeat = answer.timeTaken
  return timeToBeat

currentAnswer = (player) ->
  if helpers.getPlayer(player)?.answers
    for answer in helpers.getPlayer(player).answers
      if answer.question_id is helpers.currentStage().question_id
        return answer
  
wonBonus = (player) -> 
  console.log bonusTimeToBeat(), currentAnswer(player)?.timeTaken
  if bonusTimeToBeat() is currentAnswer(player)?.timeTaken then true else false


awardBonusPoints = (player) ->
  collections.Players.update {_id:player._id},
    $inc:
      score: helpers.currentGame().bonusPoints


# winningVideo = -> helpers.currentGame().winningVideo

getRandomQuestions = (number,category) ->
  allQuestions = collections.Questions.find({category:category}).fetch()
  result = _.shuffle allQuestions
  if number?
    result.splice(number, result.length)
  return result

winningVideo = -> helpers.currentWinningVideo()


if Meteor.isServer
  
  Meteor.methods  
    'endVideoVote' : ->
      console.log 'updating current game'
      helpers.updateCurrentGame
        winningVideo: helpers.currentWinningVideo()


    'randomizeQuestionOptions' : ->
      currentQuestions = collections.Questions.find().fetch()
      for question in currentQuestions
        collections.Questions.update {_id:question._id},
          $set: 
            options: _.shuffle question.options



    'generateQuestions': -> 
      questionsInsertPoint = helpers.currentGame().stages.indexOf('questions')
      if questionsInsertPoint >= 0 and winningVideo()
        categoryQuestions = getRandomQuestions helpers.currentGame().categoryQuestions, winningVideo().id
        gameQuestions = categoryQuestions.concat(getRandomQuestions()).splice(0,helpers.currentGame().questions)
        questionStages = []
        collections.Stages.remove {type:'question'}
        collections.Stages.remove {type:'answer'}
        for question in gameQuestions
        
          questionId = collections.Stages.insert
            title: question.text
            type: 'question'
            question_id: question._id
          
          answerId = collections.Stages.insert
            title: question.text
            type: 'answer'
            question_id: question._id
          
          questionStages.push questionId
          questionStages.push answerId
        
        postArr = helpers.currentGame().stages
        postArr.splice(0,questionsInsertPoint + 1)
        preArry = helpers.currentGame().stages
        preArry.splice(questionsInsertPoint,preArry.length - questionsInsertPoint + 1)
        gameStages  = preArry.concat(questionStages).concat(postArr)
        console.log 'whole show', gameStages
        helpers.updateCurrentGame
          stages: gameStages

        
    'removeData': ->
      collections.Players.remove({})
      collections.Forms.remove({})
      collections.Games.remove({})
      Meteor.call 'reset'

    'reset' : ->  createNewGame()

    'questionComplete': ->
      bonusWinner = null
      for player in helpers.currentPlayers()
        console.log player._id, 'won?', wonBonus(player._id)
        if wonBonus(player._id)
          awardBonusPoints(player)


    'quizComplete': ->
      winners = helpers.highestScorers helpers.currentPlayers()
      if winners.length is 1
        console.log 'We have one winner!'
        tiebreak.disable()
      else if winners.length > 1
        console.log 'Tiebreak situation'
        tiebreak.begin winners
        

  createNewGame = ->
    defaultGame = collections.Config.findOne({_id:'defaultGame'})
    delete defaultGame._id
    collections.Games.insert defaultGame
    Meteor.call 'randomizeQuestionOptions'

  Meteor.startup ->
    console.log 'questions', collections.Questions.find().count()
    if collections.Questions.find().count() is 0
      console.log 'inserting questions'
      insertFakeQuestions()
    if !helpers.defaultConfig()?
      insertFakeData()
    if !helpers.currentGame()?
      createNewGame()
      


    


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

  if getURLParameter('view')?
    helpers.clearSession()
    console.log 'cleared session'
    Session.set 'view', getURLParameter('view')
  else
    Session.set 'view', 'player'


  temporaryAdvance = ->
    inc = parseInt(Session.get('temporaryAdvance')) || 1
    Session.set 'temporaryAdvance', helpers.currentGame()?.position + inc


  Handlebars.registerHelper 'breakLines', (text) -> filters.breakLines text
  Handlebars.registerHelper 'bodyClass', -> Session.get 'view'
  Handlebars.registerHelper 'screenMode', -> Session.equals 'view', 'screen'
  Handlebars.registerHelper 'controllerMode', -> Session.equals 'view', 'control'
  Handlebars.registerHelper 'playerMode', -> Session.equals 'view', 'player'  
  Handlebars.registerHelper 'currentStage', -> helpers.currentStage()
  Handlebars.registerHelper 'nextStage', -> helpers.nextStage()
  Handlebars.registerHelper 'currentPlayers', -> helpers.currentPlayers()
  Handlebars.registerHelper 'currentCorrectAnswer', -> currentCorrectAnswer()
  Handlebars.registerHelper 'currentPlayer', -> helpers.currentPlayer()
  Handlebars.registerHelper 'currentQuestion', -> currentQuestion()
  Handlebars.registerHelper 'createForm', (formObj) -> createForm formObj
  Handlebars.registerHelper 'renderCurrentStage', ->   
    if helpers.currentStage()?.type
      new Handlebars.SafeString(Template["stage_#{helpers.currentStage()?.type}"](helpers.currentStage()));



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
      player: helpers.currentPlayer()
      stage_id: stage._id
      title: stage.title
      fields: fields

  Template.stage.allowedToSee = ->
    (helpers.currentStage()?.registration is true or helpers.currentPlayer() or Session.equals('view','screen'))


  convertLinesToArray = (content) -> content?.split '\n'

  Template.form_dropdown.options = -> convertLinesToArray @.content
  Template.form_radios.options = -> convertLinesToArray @.content

  Template.form_radios.events = 
    "change input": (e,t) ->
      $this = $(event.target)
      $('input',$this.parents('.radio-controls')).not($this).attr('checked',false)

  Template.stage_form.content = -> helpers.currentStage().content

  Template.stage_form.showLeaderboard = -> helpers.currentStage()._id is 'leaderboard'
  

  Template.stage_form.events =
    "submit form"  : (e,t) ->
      e.preventDefault()
      valid = true
      $('.has-value', $(event.target)).each ->
        $this = $(this)
        if $this.attr('required')? 
          if $.trim($this.val()) is '' or ($this.attr('type') is 'checkbox' and !$this.is(':checked'))
            valid = false
            $this.popover
              content: 'This field is required'
              delay:
                hide: 2000
            .popover 'show'
              
      if valid
        if helpers.currentStage().registration
          Session.set 'currentPlayer', createNewPlayer 
            firstname: t.find('[name="firstname"]').value
            lastname: t.find('[name="lastname"]').value
        processForm helpers.currentStage(), t
        temporaryAdvance()
        $('#stage')[0].scrollTop = 0;


  # Template.stage_form.rendered = ->
  #   if @rendered != helpers.currentStage()._id
  #     # $.jqBootstrapValidation('destroy')
  #     @rendered = helpers.currentStage()._id
  #     t = @
  #     # $form = $("input,select,textarea",$(t.find('form'))).not("[type=submit]")
  #     Session.set 'submitted', false
  #     $(t.find('form')).on 'submit', (e) ->
  #       e.preventDefault()
  #       alert ' you hit submit'
      # $form.jqBootstrapValidation
      #   submitSuccess: (form, e) ->
      #     e.preventDefault()
      #     if !Session.set 'submitted'
      #       Session.set 'submitted', true
      #       if helpers.currentStage().registration
      #         thisCurrentPlayer = createNewPlayer 
      #           firstname: t.find('[name="firstname"]').value
      #           lastname: t.find('[name="lastname"]').value
      #         Session.set 'currentPlayer', thisCurrentPlayer
      #       processForm helpers.currentStage(), t
      #       temporaryAdvance()
              
    
  alreadyVoted = (playerId, questionId) ->
    if !helpers.getPlayer(playerId)?.answers
      return false
    for answer in helpers.getPlayer(playerId).answers
      if answer.question_id is questionId and answer.answer
        return true
    return false


  Template.stage_question.created = ->
    Session.set 'startedQuestion', new Date()
    Session.set 'timeUp', false
    sizeObj = {}
    if Session.equals 'view', 'screen'
      sizeObj.med = true
    clock.startCountdown helpers.defaultConfig().timers.question, sizeObj, ->
      if Session.get('currentPlayer')
        # missed the vote
        if !alreadyVoted Session.get('currentPlayer'), helpers.currentStage().question_id
          question = collections.Questions.findOne helpers.currentStage().question_id
          collections.Players.update Session.get('currentPlayer'),
            $push:
              answers:
                question: question.text
                question_id: question._id
                answer: null
                timeTaken: helpers.defaultConfig().timers.question * 1000

      Session.set 'timeUp', true
      # alert 'voted'
      # Template.question_content.voted()
  Template.question_content.timeUp = -> Session.equals 'timeUp', true

  Template.question_content.voted = ->
    voted = alreadyVoted Session.get('currentPlayer'), helpers.currentStage().question_id
    return voted

    # return voted
  eventsObj = {}
  eventsObj[helpers.quickTouch] = (evt, template) ->
    question = collections.Questions.findOne helpers.currentStage().question_id
    playerId = Session.get('currentPlayer')
    # already voted?
    if !alreadyVoted Session.get('currentPlayer'), helpers.currentStage().question_id 

      started = Session.get('startedQuestion')
      timeTaken = new Date() - started

      collections.Players.update Session.get('currentPlayer'),
        $push:
          answers:
            question: question.text
            question_id: question._id
            answer: @
            timeTaken: timeTaken

      if @?.correct
        collections.Players.update Session.get('currentPlayer'),
          $inc: 
            score: helpers.currentGame().correctPoints 

      
    else
      console.log 'no multiple votes for you', Template.question_content.voted()

  Template.option.events eventsObj

  Template.stage_answer.correctPoints = -> helpers.currentGame().correctPoints
  Template.stage_answer.bonusPoints = -> helpers.currentGame().bonusPoints

  Template.stage_answer.answered = ->
    if Session.get('currentPlayer')?
      answers = helpers.getPlayer(Session.get('currentPlayer')).answers
      currentQuestionId = currentQuestion()._id
      if answers
        for answer in answers
          if answer.question_id is currentQuestionId and answer.answer
            return true
    return false


  Template.stage_answer.answeredCorrectly = ->
    answers = helpers.getPlayer(Session.get('currentPlayer')).answers?= []
    for answer in answers
      if answer.question_id is currentQuestion()._id
        if answer.answer?.correct
          return true
    return false

  Template.stage_answer.wonBonus = -> wonBonus(Session.get('currentPlayer'))

  Template.stage_video_select.videos = -> helpers.currentGame().videos

  Template.stage_video_select.voted = -> Session.get 'votedOnVideo', true

  Template.stage_video_select.created = -> Session.set 'startedVideoVote', new Date()

  eventsObj = {}
  eventsObj["#{helpers.quickTouch} .video"] = (event,template) ->
    video = @
    video.voteTime = new Date() - Session.get('startedVideoVote')
    if @id?
      collections.Players.update Session.get('currentPlayer'),
        $set:
          video: video
      # Session.set 'votedOnVideo', true

  Template.stage_video_select.events = eventsObj

  
  Template.video_buffer.videoBuffer = -> helpers.currentGame()?.winningVideo


  Template.playing_video.winningVideo = -> winningVideo()

  Template.playing_video.created = ->
    Meteor.setTimeout ->
      $video = $('#video_wrapper video')[0]
      $video.play()
      $video.addEventListener 'ended', ->
        helpers.move 'forward'
    , 2000


  Template.stage_results.iAmWinner = ->
    thisPlayerId = helpers.currentPlayer()._id 
    for winner in helpers.highestScorers helpers.currentPlayers()
      if winner._id is thisPlayerId
        return true
        break
    return false


  Template.build_form.typeIs = (type) -> @.type is type

  # Template.build_form.randomFormId = -> "form_item_"+Math.random()*100

  Template.form_textbox.type = ->  @.validate || 'text'

  # Template.form_textbox.inputId = -> 


  Template.form_textbox.required = -> if @.required then 'required' else ''

