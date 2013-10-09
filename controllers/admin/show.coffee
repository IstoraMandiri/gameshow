


if Meteor.isClient

  Template.admin_show.defaultConfig = -> collections.Config.findOne({_id:'defaultGame'})
  # Template.admin_show.videos = helpers.getVideos()

