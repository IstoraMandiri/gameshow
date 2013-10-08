
findPlayers = ->
  collections.Players.find({},{sort:{created:-1}})

findForms = ->
  collections.Forms.find({},{sort:{created:-1}})

findGames = ->
  collections.Games.find({},{sort:{created:-1}})

findQuestions = ->
  collections.Questions.find({},{sort:{_id:-1}})

renderTemplate = (template, data) ->  new Handlebars.SafeString(Template[template](data))



if Meteor.isClient

  Handlebars.registerHelper 'if_even', (conditional, options) ->
    if((conditional % 2) == 0)
      options.fn(this)
    else
      options.inverse(this)

  Template.admin_content.render = -> 
    if Session.get('subPage')
      new Handlebars.SafeString(Template["admin_#{Session.get('subPage')}"]())

  Template.admin_data.render = -> 
    if Session.get('admin_data_subPage')
      new Handlebars.SafeString(Template["admin_data_#{Session.get('admin_data_subPage')}"]())

  Template.admin_navbar.active = (page) -> 
    if Session.equals('subPage', page) then 'active ' else ''

  Template.admin_data.active = (page) -> 
    if Session.equals('admin_data_subPage', page) then 'active ' else ''


  Template.admin_data.tabs = [
    name:'Players'
    id:'players'
  ,
    name:'Forms'
    id:'forms'
  ,
    name:'Games'
    id:'games'
  ]

  Session.setDefault 'subPage', 'data'
  Session.setDefault 'admin_data_subPage', 'players'


  Template.admin_data.events
    "click ul li.tab": -> 
      Session.set 'admin_data_subPage', @id

  Template.admin_data_players.players = -> findPlayers().fetch()
  Template.admin_data_players.count = -> findPlayers().count()

  Template.admin_data_forms.forms = -> findForms().fetch()
  Template.admin_data_forms.count = -> findForms().count()  

  Template.admin_data_games.games = -> findGames().fetch()
  Template.admin_data_games.count = -> findGames().count()  
  
  Template.admin_questions.questions = -> findQuestions().fetch()
  Template.admin_questions.count = -> findQuestions().count()  
  
  Template.admin_show.defaultConfig = -> collections.Config.findOne({_id:'defaultGame'})
  Template.admin_show.videos = [
    id: 1
    title:'The Internet'
    file:'test1.mp4'
  ,
    id: 2
    title:'Antivirus Software'
    file:'test2.mp4'
  ,
    id: 3
    title:'Data Security'
    file:'test3.mp4'
  ,
    id: 4
    title:'Backup Redundancy'
    file:'test4.mp4'
  ]


  Template.admin_data.events
    'click .btn.answers': ->
      helpers.showModal
        title: "Answers: #{@firstname} #{@lastname}"
        body: renderTemplate('admin_data_players_answers', @).string

    'click .btn.fields': ->
      helpers.showModal
        title: "#{@title}: #{@player.firstname} #{@player.lastname}"
        body: renderTemplate('admin_data_forms_fields', @).string        

    'click .btn.players': ->
      helpers.showModal
        title: "Game Results"
        body: renderTemplate('admin_data_games_players', @).string









