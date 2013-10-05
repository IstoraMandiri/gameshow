tieBreakStages = ['tiebreakIntro','tiebreak','tiebreakResults']





@tiebreak = 
  begin : (winners) ->
    tiebreakConfig = 
      currentRound: 0
      phase: 1
      rounds: [
        players: winners
        numbers: generateNumbers()
        created: new Date()
      ]
    helpers.updateCurrentGame 
      tiebreak: tiebreakConfig
    # tieBreakers = winners 


tiebreakConfig = -> helpers.currentGame().tiebreak

currentRound = -> tiebreakConfig().currentRound

currentTiebreak = -> tiebreakConfig().rounds[currentRound()]

generateNumbers = -> 123466789

setPhase = (phase) -> helpers.updateCurrentGame {'tiebreak.phase' : phase}


# method, start tiebreak

if Meteor.isClient

  playing = ->
    currentPlayer = helpers.currentPlayer()
    match = false
    for player in currentTiebreak().players
      if currentPlayer._id is player._id
        match = true
    return match


  Template.tiebreak_numbers.created = -> 
    setPhase 1
    console.log 'Tiebreak started!'
    clock.startCountdown 2, ->
      setPhase 2
      clock.startCountdown 5, {big : true}, ->
        console.log 'time up!'


      

  Template.tiebreak_numbers.numbers = -> currentTiebreak().numbers
  Template.stage_results.playingTiebreak = -> tiebreakConfig().tiebreak?
  Template.tiebreak_phaseone.playing = -> playing()
  Template.stage_tiebreak.phaseOne = -> tiebreakConfig().phase is 1
  Template.stage_tiebreak.phaseTwo = -> currentTiebreak().phase is 2










