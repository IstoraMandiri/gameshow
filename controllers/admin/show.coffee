


if Meteor.isClient

  Template.admin_show.defaultConfig = -> admin.defaultConfig()
  Template.admin_show.videos = -> admin.defaultConfig().videos

  Template.admin_show.events
    "change input": (e,t) ->
      key = $(event.target).attr('name')
      val = parseInt(e.target.value)
      update = {}
      update[key] = val
      admin.updateDefaultConfig
        $set: update

    "click .new-video": ->
      maxId = _.max admin.defaultConfig().videos, (video) ->
        video.id      
      newId = maxId.id + 1
      admin.updateDefaultConfig
        $push:
          videos: 
            title: 'New Video'
            id: newId

  Template.admin_video.events
    "change .video-title": (e,t) ->
      console.log @
      updatedVideos = []
      for video in admin.defaultConfig().videos
        if video.id is @id
          video.title = e.target.value
        updatedVideos.push video
      console.log updatedVideos
      admin.updateDefaultConfig
        $set:
          videos: updatedVideos


