
currentForm = -> admin.getStage Session.get('admin_currentForm')


if Meteor.isClient

  Template.forms_list.events
    "click li.tab": -> 
      Session.set 'admin_currentForm', @._id


  Template.forms_list.forms = -> admin.findFormModules()
  Template.current_form.form = -> currentForm()


  Template.form_field.events
    "change input, change select, change textarea": (event,target) -> 
      # get item index

      index = $(target.firstNode).index()

      key = $(event.target).attr('name')
      val = event.target.value
      update = currentForm().content
      update[index][key] = val
      
      collections.Stages.update {_id:currentForm()._id},
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