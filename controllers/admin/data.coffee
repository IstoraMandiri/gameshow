
if Meteor.isClient

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

  Template.admin_data.events
    "click ul li.tab": -> 
      Session.set 'admin_data_subPage', @id

  Template.admin_data_players.players = -> admin.findPlayers().fetch()
  Template.admin_data_players.count = -> admin.findPlayers().count()


  Template.admin_data_forms.forms = -> admin.findForms().fetch()
  Template.admin_data_forms.count = -> admin.findForms().count()  

  Template.admin_data_games.games = -> admin.findGames().fetch()
  Template.admin_data_games.count = -> admin.findGames().count()  
  
  # Template.admin_data_games_players.players = -> 
  #   console.log @
  #   return @
  Template.game_player.player =  -> admin.getPlayer(@)

  Template.admin_questions.questions = -> admin.findQuestions().fetch()
  Template.admin_questions.count = -> admin.findQuestions().count()  
  


  Template.admin_data.events
    'click .btn.answers': ->
      helpers.showModal
        title: "Answers: #{@firstname} #{@lastname}"
        body: admin.renderTemplate('admin_data_players_answers', @).string

    'click .btn.fields': ->
      helpers.showModal
        title: "#{@title}: #{@player.firstname} #{@player.lastname}"
        body: admin.renderTemplate('admin_data_forms_fields', @).string        

    'click .btn.players': ->
      helpers.showModal
        title: "Game Results"
        body: admin.renderTemplate('admin_data_games_players', @).string


    # admin_data_games_players

