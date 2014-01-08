
mapParent = (parent, child) ->
  _.map child, (p) ->
    p.parent = parent
    return p  

deleteQuestion = (questionId) -> collections.Questions.remove {_id:questionId}
createOption = (questionId) -> 
  collections.Questions.update {_id:questionId},
    $push:
      options:
        'text':'New Option'


createQuestion = -> 
  collections.Questions.insert
    text: 'New Question'
    options: [
      'text':'Correct Answer'
      'correct':true
    , 
      'text':'Incorrect Answer'
    ]

sanitizeOptions = (update) ->
  newOptions = []
  for option in update
    newOptions.push
      text: option.text
      correct: option.correct
  return newOptions

if Meteor.isClient
  # Template.admin_questions.defaultConfig = -> collections.Config.findOne({_id:'defaultGame'})
  # Template.admin_show.videos = helpers.getVideos()

  Template.admin_questions.events
    "click .create-question": -> createQuestion()
    "change input.upload-questions": (event,template) ->
      if confirm 'WARNING: THIS WILL REPLACE ALL QUESTIONS.\nAre you sure you wish to continue?'
        file = event.target.files[0]
        reader = new FileReader();
        unless reader
          alert 'please use chrome'

        reader.readAsText file
        reader.onload = (event) ->
          newQuestions = helpers.CSVToArray(event.target.result)
          newQuestions.splice(0,1)
          Meteor.call 'uploadNewQuestions', newQuestions
          window.location.reload()

  Template.admin_question.events
    "click .delete-question": -> deleteQuestion @._id
    "click .create-option": -> createOption @._id
    "change .question-title": (e,target) -> 
      collections.Questions.update {_id:@_id},
        $set: 
          text: e.target.value
    "change .category-select": (e,target) -> 
      category = if e.target.value isnt "" then parseInt(e.target.value) else undefined
      console.log 'setting ', category
      if category?
        collections.Questions.update {_id:@_id},
          $set:
            category: category
      else
        collections.Questions.update {_id:@_id},
          $unset: 
            'category':1

  Template.admin_question.augOptions = -> mapParent @, @options

  Template.admin_question.augVideos = -> mapParent @, admin.defaultConfig().videos

  Template.video_category.selected = -> @id is @parent.category


  Template.question_option.events

    "change .option-title": (e,target) ->
      index = $(target.firstNode).index()
      text = event.target.value
      update = _.clone @parent.options
      for option, i in update
        if i is index 
          option.text = text
        
      collections.Questions.update {_id:@parent._id},
        $set: 
          options: sanitizeOptions update

    "change .correct-box": (e,target) ->
      index = $(target.firstNode).index()
      checked = if $(e.target).attr('checked') then true else undefined
      update = _.clone @parent.options
      for option, i in update
        if i is index 
          option.correct = checked
      collections.Questions.update {_id:@parent._id},
        $set: 
          options: sanitizeOptions update


    "click .delete-option": (e,target) -> 
      index = $(target.firstNode).index()
      update = _.clone @parent.options
      update.splice(index,1)
      collections.Questions.update {_id:@parent._id},
        $set: 
          options: sanitizeOptions update



      # key = $(event.target).attr('name')
      # val = event.target.value
      # update = currentForm().content
      # update[index][key] = val
      
      # updateCurrentForm
      #   $set: 
      #     content: update

