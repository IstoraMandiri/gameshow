@insertFakeData = ->
  
  collections.Config.insert
    _id:'defaultGame'
    correctPoints : 100
    bonusPoints : 50
    questions : 6
    categoryQuestions : 2
    timers:
      question: 15
      watch_tiebreak: 16
      input_tiebreak: 17
    position: 0
    stages: ['home',
    'register',
    'form',
    'home',
    'videoSelect',
    'home',
    'videoPlay',
    'home',
    'questions',
    'home',
    'results',
    'tiebreakIntro',
    'tiebreak',
    'tiebreakResults',
    'leaderboard',
    'home'],
    videos: [
      id: 1
      title:'Internet'
    ,
      id: 2
      title:'IP Law'
    ,
      id: 3
      title:'Antivirus'
    ,
      id: 4
      title:'Backup and Recovery'
    ,
      id: 5
      title:'Data Security'
    ,
      id: 6
      title:'Enterprise'
    ]

  collections.Stages.insert
    title: 'Holding Slide'
    _id: 'home'
    type: 'static'
    class: 'holding_slide'
  
  collections.Stages.insert
    title: 'Registration Form'
    _id: 'register'
    type: 'form'
    class: 'form-horizontal'
    registration: true
    content: [
        text:'First Name'
        type:'textbox'
        name:'firstname'
        # required:true
      ,
        text:'Last Name'
        type:'textbox'
        name:'lastname'
        # required:true
      ,
        text:'Profession'
        type:'dropdown'
        options:['Please select','Graphic Design','Programming','Sysadmin']
        # required:true
      ,
        text:'Company'
        type:'textbox'
      ,
        text:'Email'
        type:'textbox'
        validate:'email'
        # required:true
      , 
        text:'T&C'
        type:'modal'
        class:'inline'
        content:"""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vitae gravida velit. Nam sit amet dapibus nunc. Donec ultricies posuere mattis. Donec tincidunt, purus ac scelerisque convallis, dolor velit volutpat massa, et vestibulum tellus lacus vitae nibh. Cras rutrum ipsum id justo posuere, id fringilla sem faucibus. Nulla vehicula eros pellentesque, mattis elit sit amet, venenatis nisi. Pellentesque porta luctus mauris eu lobortis. Nulla ac risus velit. Mauris vestibulum congue orci, eu malesuada metus iaculis ac. Suspendisse potenti. Sed cursus felis lorem, sed varius mi interdum fringilla.

Vestibulum bibendum odio sit amet nisl hendrerit, id iaculis elit mollis. Pellentesque eu condimentum metus. Vestibulum adipiscing purus ac arcu lacinia tempor. In nulla dolor, convallis at sodales non, volutpat sit amet metus. Suspendisse potenti. Integer aliquet, mi id eleifend vulputate, turpis felis porttitor mauris, et adipiscing ipsum eros et est. Mauris at nulla eget odio mattis sollicitudin ac a orci. Nunc non eros non dolor euismod dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum accumsan ligula in fringilla adipiscing. Curabitur ac odio orci. Maecenas tempor justo ac commodo posuere. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et rhoncus eros.

Suspendisse tristique lectus id metus placerat, eu laoreet felis aliquam. Proin facilisis tempor consequat. Nullam fermentum sed velit eget volutpat. Etiam ut elit in enim laoreet tristique eu in nisl. Donec lorem turpis, vestibulum eu euismod vitae, convallis id ipsum. Sed odio augue, egestas a fringilla malesuada, condimentum interdum augue. Morbi vestibulum pellentesque aliquet. Fusce posuere turpis et sollicitudin luctus.

Nam a elit dolor. Integer malesuada scelerisque orci, nec malesuada lacus dictum et. Maecenas id mi quis magna tempor consectetur. Aenean ut leo sit amet neque sagittis euismod. Proin dapibus in nisi quis posuere. Praesent quis lectus ultricies, bibendum lorem et, dignissim purus. Nam vel condimentum mauris. Cras vulputate at elit quis venenatis. Integer vel est ut nunc fringilla interdum quis at purus.

Curabitur egestas lacus non magna lacinia, id malesuada massa facilisis. Sed ultricies enim et orci bibendum placerat. Aliquam non mauris sed nulla suscipit interdum. Etiam porta augue vel ante tempor, non consectetur ligula mollis. Etiam pulvinar metus nec turpis lacinia aliquet. Donec sed adipiscing mi. Suspendisse at libero sit amet erat tincidunt placerat non eu risus. Nunc condimentum tellus ac arcu blandit pulvinar. Morbi lorem purus, lacinia vitae malesuada et, elementum non nibh. In quis massa vel mauris molestie blandit. In sodales vel dolor vehicula aliquam. Donec odio purus, varius nec risus sit amet, dictum feugiat ligula. Fusce dui tortor, vulputate quis varius et, pellentesque at tortor. Etiam sit amet justo orci.
          """
      ,
        text:'Privacy'
        type:'modal'
        class:'inline'
        content:'Blah blah blah'
      ,
        text:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor.'
        type:'checkbox'
        content:''
        # required:true
      ]

  collections.Stages.insert
    title: 'More Info Form'  
    _id: 'form'
    type: 'form'
    content: [
        text:'Custom Fields'
        type:'textbox'
        # required:true
      ,
        text:'Textarea'
        type:'textarea'
        # required:true
    ]


  collections.Stages.insert
    _id: 'videoSelect'
    type: 'video_select'
    title: 'Pick a Topic'

  collections.Stages.insert
    _id: 'videoPlay'
    type: 'video_play'
    title: 'Playing Video...'

  collections.Stages.insert
    title: 'Question 1'
    _id: 'question'
    type: 'question'
    question_id: 'objId'

  collections.Stages.insert
    title: 'Question 1 Answer' 
    _id: 'answer'
    type: 'answer'
    question_id: 'objId'

  collections.Stages.insert
    title: 'Question 2'   
    _id: 'question2'
    type: 'question'
    question_id: 'objId2'

  collections.Stages.insert
    title: 'Question 2 Answer'   
    _id: 'answer2'
    type: 'answer'
    question_id: 'objId2'

  collections.Stages.insert
    title: 'Question 3'   
    _id: 'question3'
    type: 'question'
    question_id: 'objId3'

  collections.Stages.insert
    title: 'Question 3 Answer'   
    _id: 'answer3'
    type: 'answer'
    question_id: 'objId3'
  collections.Stages.insert
    title: 'Question 4'   
    _id: 'question4'
    type: 'question'
    question_id: 'objId4'

  collections.Stages.insert
    title: 'Question 4 Answer'   
    _id: 'answer4'
    type: 'answer'
    question_id: 'objId4'

  collections.Stages.insert
    title: 'Question 5'   
    _id: 'question5'
    type: 'question'
    question_id: 'objId5'

  collections.Stages.insert
    title: 'Question 5 Answer'   
    _id: 'answer5'
    type: 'answer'
    question_id: 'objId5'
  collections.Stages.insert
    title: 'Question 6'   
    _id: 'question6'
    type: 'question'
    question_id: 'objId6'

  collections.Stages.insert
    title: 'Question 6 Answer'   
    _id: 'answer6'
    type: 'answer'
    question_id: 'objId6'


  collections.Stages.insert
    title: 'Tiebreak Intro'   
    _id: 'tiebreakIntro'
    type: 'tiebreakIntro'

  collections.Stages.insert
    title: 'Tiebreaker'   
    _id: 'tiebreak'
    type: 'tiebreak'

  collections.Stages.insert
    title: 'Tiebreak Results'   
    _id: 'tiebreakResults'
    type: 'tiebreakResults'

  collections.Stages.insert
    title: 'This game results'  
    _id: 'results'
    type: 'results'

  collections.Stages.insert
    title: 'Overall Leaderboard'  
    _id: 'leaderboard'
    type: 'form'


  collections.Questions.insert
    _id: 'objId'
    text: 'Question Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'
    ]

  collections.Questions.insert
    _id: 'objId2'
    text: 'Question 2 Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'
    ]

  collections.Questions.insert
    _id: 'objId3'
    text: 'Question 3 Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'
    ]

  collections.Questions.insert
    _id: 'objId4'
    text: 'Question 4 Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'
    ]

  collections.Questions.insert
    _id: 'objId5'
    text: 'Question 5 Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'
    ]



  collections.Questions.insert
    _id: 'objId6'
    text: 'Question 6 Text Here'
    options: [
      text: 'Answer 1'
      correct: true
    ,
      text: 'Answer 2'
    ,
      text: 'Answer 3'
    ,
      text: 'Answer 4'
    ]
