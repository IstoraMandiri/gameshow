@collections =
  Games : new Meteor.Collection 'games'
  Config : new Meteor.Collection 'config'
  Players : new Meteor.Collection 'players'
  Stages : new Meteor.Collection 'stages'
  Questions : new Meteor.Collection 'questions'
  Forms : new Meteor.Collection 'forms'


@commandStream = new Meteor.Stream 'commands'


collections.Players.before.insert (id,doc) -> doc.created = new Date()
collections.Games.before.insert (id,doc) -> doc.created = new Date()
collections.Forms.before.insert (id,doc) -> doc.created = new Date()
collections.Questions.before.insert (id,doc) -> doc.created = new Date()


@top10Players = -> collections.Players.find({},{sort:{score:-1},limit:10})

if Meteor.isServer
  Meteor.publish "currentGame", -> collections.Games.find({},{sort:{created:-1},limit:1})
  Meteor.publish "last20Players", -> collections.Players.find({},{sort:{created:-1},limit:16})
  Meteor.publish "games", -> collections.Games.find({})
  Meteor.publish "config", -> collections.Config.find({})
  Meteor.publish "players", -> collections.Players.find({})
  Meteor.publish "stages", -> collections.Stages.find({})
  Meteor.publish "questions", -> collections.Questions.find({})
  Meteor.publish "forms", -> collections.Forms.find({})
  Meteor.publish "top10Players", -> top10Players()


if Meteor.isClient
  Meteor.autorun ->
    Meteor.subscribe "currentGame"
    Meteor.subscribe "config"
    Meteor.subscribe "last20Players"
    Meteor.subscribe "stages"
    Meteor.subscribe "questions"
    Meteor.subscribe "top10Players", -> top10Players()

  # if admin
    
