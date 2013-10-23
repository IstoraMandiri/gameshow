
if Meteor.isClient

  Template.admin_data.tabs = [
    name:'Players'
    id:'players'
  ,
    name:'Forms'
    id:'forms'
  ,
    name:'Form Fields'
    id:'allforms'
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
  
  Template.game_player.player =  -> admin.getPlayer(@)

  Template.admin_questions.questions = -> admin.findQuestions().fetch()
  Template.admin_questions.count = -> admin.findQuestions().count()  
  


  Template.admin_data.events
    'click .delete-all-data': ->
      if confirm 'Are you sure you wish to delete all data?'
        if confirm 'Please confirm again. You cannot recover the deleted data.'
          Meteor.call 'removeData'
          Alert 'Forms, Players and Games Deleted.'

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

  Template.admin_data_allforms.formtypes = ->
    formTypes = []
    for formItem in collections.Forms.find({}).fetch()
      if formTypes.indexOf(formItem.stage_id) is -1
        formTypes.push formItem.stage_id
    return formTypes

  Template.formtype.one = -> collections.Forms.findOne({stage_id:@.toString()})

  Template.formtype.form = -> 
    rowObjs = collections.Forms.find({stage_id:@.toString()}).fetch()
    rows = [['Created','Player ID','Name']]
    ## create top row
    for row, i in rowObjs
      if i is 0
        for field in row.fields
          rows[0].push field.title
      newRow = [row.created,row.player._id,"#{row.player.firstname} #{row.player.lastname}"]
      for field in row.fields
        newRow.push field.value
      rows.push newRow
    return rows


