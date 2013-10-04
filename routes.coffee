if Meteor.isClient
  Meteor.Router.add
    '/':'main'
    '/admin':'admin'

  Template.body.layoutName = ->
    console.log Meteor.Router.page()
    if Meteor.Router.page() is 'admin'
      return 'adminLayout'
    else
      return 'mainLayout'

