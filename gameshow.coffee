Config = new Meteor.Collection 'cofnig'
Players = new Meteor.Collection 'players'
Stages = new Meteor.Collection 'stages'
Questions = new Meteor.Collection 'questions'


getConfig = -> Config.findOne({_id:'config'}) || {}

updateConfig = (update) ->
  Config.update 'config',
    $set: update

currentStage = ->
  Stages.findOne
    _id: getConfig().stages?[getConfig().position]

move = (position) ->

    currentPosition = getConfig().position

    if position is 'back'
      newPosition = currentPosition - 1
    else if position is 'forward'
      newPosition = currentPosition + 1
    else
      newPosition = position

    if newPosition >= 0 and newPosition < getConfig().stages.length # stages length
      updateConfig 
        position: newPosition



if Meteor.isServer
  Meteor.startup ->
    if Players.find().count() is 0
      names = ["Ada Lovelace","Grace Hopper","Marie Curie"]
      for name, i in names
        Players.insert
          name: name
          score: Math.floor(Random.fraction()*10)*5

    if Config.find().count() is 0
      Config.insert
        _id:'config'
        position: 0
        stages: ['home','register','home','form','home','videoSelect','videoPlay','question','answer','question','answer','question','answer','tiebreakInto','tiebreak','home','results','leaderboard']
        # stages: ['home']
      
      Stages.insert
        title: 'home'
        _id: 'home'
        type: 'static'
        content: 'home'
      
      Stages.insert
        _id: 'register'
        type: 'registration'
        content: 'register'

      Stages.insert
        _id: 'form'
        type: 'static'
        content: 'form'

      Stages.insert
        _id: 'videoSelect'
        type: 'static'
        content: 'videoSelect'

      Stages.insert
        _id: 'videoPlay'
        type: 'static'
        content: 'videoPlay'

      Stages.insert
        _id: 'question'
        type: 'question'
        question_id: 1

      Stages.insert
        _id: 'answer'
        type: 'answer'
        question_id: 1

      Stages.insert
        _id: 'tiebreakInto'
        type: 'static'
        content: 'tiebreakInto'

      Stages.insert
        _id: 'tiebreak'
        type: 'static'
        content: 'tiebreak'

      Stages.insert
        _id: 'results'
        type: 'results'

      Stages.insert
        _id: 'leaderboard'
        type: 'leaderboard'

      # Stages.insert
      #   _id: 'home'
      #   title: 'Home Screen'
      #   content: '<b>Content<br>here</b>'
      #   type: 'static'
      #   classes: 'home'
      #   # classes, etc

      # Stages.insert
      #   _id: 'b'
      #   title: 'Question'
      #   content: '<b>Content<br>here</b>'

      # Stages.insert
      #   _id: 'c'
      #   title: 'Form'
      #   content: '<b>Content<br>here</b>'        

    # Meteor.setInterval ->
    #   setPosition Math.random()*20
    # , 2000

if Meteor.isClient 

  quickTouch = if (@navigator.userAgent.match(/(iPhone|iPod|iPad)/) || @navigator.userAgent.match(/Android/)) then 'tap' else 'click'

  Handlebars.registerHelper 'currentStage', -> currentStage()
  
  Handlebars.registerHelper 'renderCurrentStage', ->   
    if currentStage()?.type
      new Handlebars.SafeString(Template["stage-#{currentStage()?.type}"](currentStage()));
  

  Template.controls.events
    "click #forward-btn" : -> move 'forward'
    "click #back-btn" : -> move 'back'

  Template.stage.position = -> getConfig()?.position

  # Template.stage.events
  #   'click span': ->
  #     updateConfig 
  #       position: !Template.stage.getConfig().position
    # 'keydown #test': (evt,template) ->
    #   Meteor.setTimeout ->
    #     updateConfig
    #       text: evt.currentTarget.value
    #   , 20

if Meteor.isClient
  Template.leaderboard.players = ->
    Players.find {},
      sort:
        score: -1
        name: 1


  Template.leaderboard.selected_name = ->
    player = Players.findOne(Session.get("selected_player"))
    player and player.name

  Template.player.selected = ->
    (if Session.equals("selected_player", @_id) then "selected" else "")

  Template.leaderboard.events "click input.inc": ->
    Players.update Session.get("selected_player"),
      $inc:
        score: 5


  Template.player.events click: ->
    Session.set "selected_player", @_id


# On server startup, create some players if the database is empty.
# if Meteor.isServer
  # Meteor.startup ->
  #   if Players.find().count() is 0
  #     names = ["Ada Lovelace", "Grace Hopper", "Marie Curie", "Carl Friedrich Gauss", "Nikola Tesla", "Claude Shannon"]
  #     i = 0

  #     while i < names.length
  #       Players.insert
  #         name: names[i]
  #         score: Math.floor(Random.fraction() * 10) * 5

  #       i++


