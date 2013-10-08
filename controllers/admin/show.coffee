


if Meteor.isClient

  Template.admin_show.defaultConfig = -> collections.Config.findOne({_id:'defaultGame'})
  Template.admin_show.videos = [
    id: 1
    title:'The Internet'
    file:'test1.mp4'
  ,
    id: 2
    title:'Antivirus Software'
    file:'test2.mp4'
  ,
    id: 3
    title:'Data Security'
    file:'test3.mp4'
  ,
    id: 4
    title:'Backup Redundancy'
    file:'test4.mp4'
  ]

