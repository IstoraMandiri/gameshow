@collections =
  Games : new Meteor.Collection 'games'
  Config : new Meteor.Collection 'config'
  Players : new Meteor.Collection 'players'
  Stages : new Meteor.Collection 'stages'
  Questions : new Meteor.Collection 'questions'
  Forms : new Meteor.Collection 'forms'

collections.Players.before.insert (id,doc) -> doc.created = new Date()
collections.Games.before.insert (id,doc) -> doc.created = new Date()
collections.Forms.before.insert (id,doc) -> doc.created = new Date()
collections.Questions.before.insert (id,doc) -> doc.created = new Date()
