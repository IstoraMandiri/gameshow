
if Meteor.isClient

  Template.modal.message = -> Session.get('modalData')

  Template.form_modal.events
    "click": (e,t) -> 
      helpers.showModal
        body: @content
        title: @text