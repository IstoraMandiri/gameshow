if Meteor.isClient
  Meteor.Router.add
    '/': -> 'main'
    '/admin':'admin'
    '/admin/:sub': (sub) ->
      Session.set 'subPage', sub
      Meteor.autorun ->
        Meteor.subscribe "players"
        Meteor.subscribe "games"
        Meteor.subscribe "forms"
      return 'admin'

  Template.body.layoutName = ->
    if Meteor.Router.page() is 'admin'
      return 'adminLayout'
    else
      return 'mainLayout'
