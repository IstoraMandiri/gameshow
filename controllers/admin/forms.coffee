
currentForm = -> admin.getStage Session.get('admin_currentForm')

updateCurrentForm = (update) -> 
  if update.$set?.content?
    for field, i in update.$set.content
      field.id = "#{currentForm()._id}_field_#{i}" 
  collections.Stages.update {_id:currentForm()._id}, update

if Meteor.isClient

  Template.admin_forms.currentForm = -> currentForm()

  Template.admin_forms.events
    "click .new-field": ->
      updateCurrentForm
        $push:
          content:
            text:'New Form Item'
            type:'textbox'

  Template.forms_list.events
    "click li.tab": -> 
      Session.set 'admin_currentForm', @._id

  Template.form_item.active = -> currentForm()?._id is @._id


  Template.forms_list.forms = -> admin.findFormModules()
  Template.current_form.form = -> currentForm()

  Template.form_field.selectedType = (type) -> @.type is type
  Template.form_field.selectedValidation = (validate) -> @.validate is validate

  Template.current_form.events
    "change .form_title": (event,target) ->
      updateCurrentForm
        $set:
          title: event.target.value
    
    "change .form_class": (event,target) ->
      updateCurrentForm
        $set:
          class: event.target.value


  getField = (target) -> currentForm().content[$(target.firstNode).index()]

  Template.form_field.events
    "click .delete-field": (event,target) ->
      index = $(target.firstNode).index()
      update = currentForm().content
      update.splice(index, 1)
      updateCurrentForm
        $set: 
          content: update


    "change input, change select, change textarea": (event,target) -> 

      # get item index

      index = $(target.firstNode).index()

      key = $(event.target).attr('name')
      if $(event.target).attr('type') is 'checkbox'
        val = $(event.target).is(':checked')
      else
        val = event.target.value

      console.log key, val
      update = currentForm().content
      update[index][key] = val

      updateCurrentForm
        $set: 
          content: update
      # collections.Stages
      # make update
      # console.log newVal, currentForm().content[index]
  
      # prevArr[index] = data
      # console.log 'new', prevArr

      # save form 

      # console.log key, val, index

    # newForm = []
    # console.log t
    # for field in t.findAll('.form-item')
    #   console.log field

  # Template.current_form.events
  #   "change input, change select, change textarea": (e,t) -> saveForm e,t


  
  # saveForm = (e,t) -> 

  #   newForm = []
  #   console.log t
  #   for field in t.findAll('.form-item')
  #     console.log field



#   forms_list


# current_form