
@admin = 
  renderTemplate : (template, data) ->  new Handlebars.SafeString(Template[template](data))
  findPlayers : ->  collections.Players.find({},{sort:{created:-1}})
  findForms : ->  collections.Forms.find({},{sort:{created:-1}})
  findGames : ->  collections.Games.find({},{sort:{created:-1}})
  findQuestions : ->  collections.Questions.find({},{sort:{created:-1}})
  findFormModules: -> collections.Stages.find({type:'form'},{sort:{_id:1}})
  defaultConfig: -> helpers.defaultConfig()
  updateDefaultConfig: (update) -> collections.Config.update {_id:'defaultGame'}, update
  getPlayer: (playerId) -> collections.Players.findOne({_id:playerId.valueOf()})
  getStage: (stageId) -> collections.Stages.findOne({_id:stageId})

if Meteor.isClient

  Handlebars.registerHelper 'if_even', (conditional, options) ->
    if((conditional % 2) == 0)
      options.fn(this)
    else
      options.inverse(this)



  Session.setDefault 'subPage', 'data'
  Session.setDefault 'admin_data_subPage', 'players'

  Template.admin_navbar.active = (page) -> 
    if Session.equals('subPage', page) then 'active ' else ''

  Template.admin_content.render = -> 
    if Session.get('subPage')
      new Handlebars.SafeString(Template["admin_#{Session.get('subPage')}"]())

  Template.admin_data.render = -> 
    if Session.get('admin_data_subPage')
      new Handlebars.SafeString(Template["admin_data_#{Session.get('admin_data_subPage')}"]())

  Template.admin_data.active = (page) -> 
    if Session.equals('admin_data_subPage', page) then 'active ' else ''

  Template.form_item.active = (page) -> 'active '


