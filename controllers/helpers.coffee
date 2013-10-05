@helpers = 
  showModal : (data) -> 
    Session.set 'modalData', data
    Meteor.setTimeout ->
      $('#modal').modal
        backdrop:false
    , 10

    # false
  
  currentPlayer : -> 
    if Session.get('currentPlayer')
      collections.Players.findOne Session.get('currentPlayer')

  currentGame : -> 
    collections.Games.findOne({},{sort:{_id:-1}})

  updateCurrentGame : (update) ->
    collections.Games.update helpers.currentGame()._id,
      $set : update
