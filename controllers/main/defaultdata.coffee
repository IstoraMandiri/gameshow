

@insertFakeData = ->
  
  collections.Config.insert
    _id:'defaultGame'
    correctPoints : 100
    bonusPoints : 50
    questions : 6
    categoryQuestions : 6
    timers:
      question: 15
      watch_tiebreak: 10
      input_tiebreak: 15
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
    'tiebreakSlide',
    'tiebreakIntro',
    'tiebreak',
    'tiebreakResults',
    'leaderboard',
    'home'],
    videos: [
      id: 1
      title:'Malware Protection'
    ,
      id: 2
      title:'Malicious Insiders'
    ,
      id: 3
      title:'Business Continuity'
    ,
      id: 4
      title:'Mobile Protection'
    ]

  collections.Stages.insert
    title: 'Tiebreak Slide'
    _id: 'tiebreakSlide'
    type: 'static'
    class: 'holding_slide'

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
        id:'regsitration_field_1'
        text:'First Name'
        type:'textbox'
        name:'firstname'
        required:true
      ,
        id:'regsitration_field_2'
        text:'Last Name'
        type:'textbox'
        name:'lastname'
        required:true
      ,
        id:'regsitration_field_3'
        text:'Profession'
        type:'dropdown'
        content:"Prof1\nProf2"
        required:true
      ,
        id:'regsitration_field_4'
        text:'Company'
        type:'textbox'
      ,
        id:'regsitration_field_5'
        text:'Email'
        type:'textbox'
        validate:'email'
        required:true
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
        content:"""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vitae gravida velit. Nam sit amet dapibus nunc. Donec ultricies posuere mattis. Donec tincidunt, purus ac scelerisque convallis, dolor velit volutpat massa, et vestibulum tellus lacus vitae nibh. Cras rutrum ipsum id justo posuere, id fringilla sem faucibus. Nulla vehicula eros pellentesque, mattis elit sit amet, venenatis nisi. Pellentesque porta luctus mauris eu lobortis. Nulla ac risus velit. Mauris vestibulum congue orci, eu malesuada metus iaculis ac. Suspendisse potenti. Sed cursus felis lorem, sed varius mi interdum fringilla.

Vestibulum bibendum odio sit amet nisl hendrerit, id iaculis elit mollis. Pellentesque eu condimentum metus. Vestibulum adipiscing purus ac arcu lacinia tempor. In nulla dolor, convallis at sodales non, volutpat sit amet metus. Suspendisse potenti. Integer aliquet, mi id eleifend vulputate, turpis felis porttitor mauris, et adipiscing ipsum eros et est. Mauris at nulla eget odio mattis sollicitudin ac a orci. Nunc non eros non dolor euismod dictum. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum accumsan ligula in fringilla adipiscing. Curabitur ac odio orci. Maecenas tempor justo ac commodo posuere. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et rhoncus eros.

Suspendisse tristique lectus id metus placerat, eu laoreet felis aliquam. Proin facilisis tempor consequat. Nullam fermentum sed velit eget volutpat. Etiam ut elit in enim laoreet tristique eu in nisl. Donec lorem turpis, vestibulum eu euismod vitae, convallis id ipsum. Sed odio augue, egestas a fringilla malesuada, condimentum interdum augue. Morbi vestibulum pellentesque aliquet. Fusce posuere turpis et sollicitudin luctus.

Nam a elit dolor. Integer malesuada scelerisque orci, nec malesuada lacus dictum et. Maecenas id mi quis magna tempor consectetur. Aenean ut leo sit amet neque sagittis euismod. Proin dapibus in nisi quis posuere. Praesent quis lectus ultricies, bibendum lorem et, dignissim purus. Nam vel condimentum mauris. Cras vulputate at elit quis venenatis. Integer vel est ut nunc fringilla interdum quis at purus.

Curabitur egestas lacus non magna lacinia, id malesuada massa facilisis. Sed ultricies enim et orci bibendum placerat. Aliquam non mauris sed nulla suscipit interdum. Etiam porta augue vel ante tempor, non consectetur ligula mollis. Etiam pulvinar metus nec turpis lacinia aliquet. Donec sed adipiscing mi. Suspendisse at libero sit amet erat tincidunt placerat non eu risus. Nunc condimentum tellus ac arcu blandit pulvinar. Morbi lorem purus, lacinia vitae malesuada et, elementum non nibh. In quis massa vel mauris molestie blandit. In sodales vel dolor vehicula aliquam. Donec odio purus, varius nec risus sit amet, dictum feugiat ligula. Fusce dui tortor, vulputate quis varius et, pellentesque at tortor. Etiam sit amet justo orci.
          """
      ,
        id:'regsitration_field_6'
        text:'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor.'
        type:'checkbox'
        content:''
        required:true
      ]

  collections.Stages.insert
    title: 'More Info Form'  
    _id: 'form'
    type: 'form'
    content: [
        id:'form_field_1'
        text:'Custom Fields'
        type:'textbox'
        # required:true
      ,
        id:'form_field_2'
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
    title: 'Tiebreak - Random Number Generator'   
    _id: 'tiebreakIntro'
    type: 'tiebreakIntro'

  collections.Stages.insert
    title: 'Tiebreak - Number Entry'   
    _id: 'tiebreak'
    type: 'tiebreak'

  collections.Stages.insert
    title: 'Tiebreak - Results'   
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
    content: [
        id:'leaderboard_field_1'      
        text:'Custom Fields'
        type:'textbox'
        # required:true
      ,
        id:'leaderboard_field_2'            
        text:'Textarea'
        type:'textarea'
        # required:true
    ]

@insertFakeQuestions = ->
  symantecQuesitons = [
    [
      "1",
      "Symantec solutions\n  for Malware are:",
      "All of these",
      "Faster ",
      "Stronger",
      "To anticipate\n  threats"
    ],
    [
      "1",
      "Symantec's solution for Cyber Attacks is called?",
      "Global Intelligence Network",
      "Global Attack Network",
      "Global Eye Network",
      "Global Data Network"
    ],
    [
      "1",
      "What does Symantec have built into their\n  products?",
      "Multiple technologies",
      "Nice colours",
      "Great designs",
      "Pleasing patterns"
    ],
    [
      "1",
      "Symantec Insight uses",
      "Reputation Security Technology",
      "Media reports",
      "Crystal ball",
      "Musical notes"
    ],
    [
      "1",
      "Companies using Symantec Protection Policies are\n  reporting improved:",
      "All of these",
      "Detection",
      "Performance",
      "Accuracy",
      ""
    ],
    [
      "1",
      "Symantec Insight tracks millions of files and\n  billions of data to:",
      "Identify new threats being created",
      "Identify trends ",
      "Identify ideas",
      "Identify people"
    ],
    [
      "1",
      "Symantec collects and deciphers",
      "Global Intelligence",
      "Weather Patterns",
      "Constellations",
      "Volcanic activity"
    ],
    [
      "1",
      "Symantec can help businesses ",
      "Of all sizes",
      "Only on a small scale",
      "Only on a medium scale",
      "Only on a large scale"
    ],
    [
      "1",
      "Symantec knows",
      "How to interpret all the data",
      "Distribute the data",
      "Upload the data",
      "Collect the data"
    ],
    [
      "1",
      "Symantec Insight resolves Malware issues",
      "In time",
      "In a week",
      "In a month",
      "In a year",
      ""
    ],
    [
      "1",
      "Symantec takes the data and",
      "Builds the right defence",
      "Ignores it",
      "Files it",
      "Gives it back"
    ],
    [
      "1",
      "Symantec gives all its partners",
      "Real Solutions",
      "Good advice",
      "Good prizes",
      "Good support"
    ],
    [
      "1",
      "Symantec is the Leader in collecting and\n  deciphering Global Intelligence",
      "TRUE",
      "FALSE",
      ""
    ],
    [
      "1",
      "Symantec helps businesses recover from attacks\n  and also",
      "Avoid them completely",
      "Ignore them",
      "Send them away",
      "Understand them"
    ],
    [
      "1",
      "Advanced Malware is responsible for",
      "Cyber Attack",
      "Verbal attack",
      "Art attack",
      "Panic attack"
    ],
    [
      "1",
      "Cyber Attacks only happen to big corporations",
      "FALSE",
      "TRUE",
      ""
    ],
    [
      "1",
      "Cyber Attacks target",
      "All of these",
      "Employees",
      "Customers",
      "Critical information"
    ],
    [
      "1",
      "Cyber Attacks can be present in",
      "All of these",
      "Spam",
      "Website attacks",
      "Malvertising"
    ],
    [
      "1",
      "Anti Virus solutions are sufficient against\n  Cyber Attacks",
      "FALSE",
      "TRUE",
      ""
    ],
    [
      "1",
      "Security is ",
      "Knowledge",
      "A Guard dog",
      "A Fence",
      "A Wall",
      ""
    ],
    [
      "1",
      "Knowledge is",
      "Power",
      "Strength",
      "Physical Fitness",
      "Agility",
      ""
    ],
    [
      "1",
      "Protection is about real time",
      "Security Intelligence",
      "Higher Intelligence",
      "Basic Intelligence",
      "Average Intelligence"
    ],
    [
      "1",
      "What do Cyber criminals want",
      "Valuable Information",
      "Television listings",
      "Clever sayings",
      "Football statistics"
    ],
    [
      "1",
      "Targeted attacks and data breaches are",
      "Rising",
      "Falling",
      "Staying the same",
      "Non existent"
    ],
    [
      "1",
      "The gentleman newsreader is",
      "Sitting in a studio",
      "Jogging",
      "Kneeling down",
      "Standing",
      ""
    ],
    [
      "1",
      "What colour is the blouse of the small\n  business lady?",
      "Pink",
      "Yellow",
      "Blue",
      "Black",
      ""
    ],
    [
      "1",
      "How does the video blogger end his 'speech'",
      "Peace out",
      "Peace to the world",
      "Global peace",
      "Peace be with you"
    ],
    [
      "1",
      "What is the name of the news channel?",
      "10 Action News",
      "Newsbeat",
      "Cyber news",
      "News for you"
    ],
    [
      "1",
      "What colour is the handheld microphone that\n  the lady newsreader is holding?",
      "Grey",
      "Black",
      "Red",
      "White",
      ""
    ],
    [
      "1",
      "How many monitors are on the desk of the Small\n  Business lady?",
      "Two",
      "One",
      "Three",
      "None",
      ""
    ],
    [
      "1",
      "According to the young lady from Georgia,\n  companies need someone who",
      "Has all of these",
      "Has the tools",
      "Recognises the problem",
      "Acts on the data"
    ],
    [
      "2",
      "Which Symantec product can provide the\n  solution you need?",
      "Symantec Net Backup",
      "Norton 360",
      "Asset Management Suite",
      "Back Up Exec"
    ],
    [
      "2",
      "Which Symantec product can provide the\n  solution you need?",
      "Veritas Cluster Server",
      "ApplicationHA",
      "Norton 360",
      "Enterprise Vault"
    ],
    [
      "2",
      "Symantec means availability you can",
      "Count on",
      "Count up",
      "Do without",
      "Measure",
      ""
    ],
    [
      "2",
      "Symantec Net Back Up and Veritas Cluster\n  Server",
      "Know where the problems are",
      "Don’t have any problems",
      "Know where your office is",
      "Know your company"
    ],
    [
      "2",
      "Symantec's business continuity solution offers",
      "Virtual business services",
      "Virtual support",
      "Online business services",
      "Virtual assistants"
    ],
    [
      "2",
      "Symantec's solution makes sure your business is always",
      "Up and running",
      "Safe from fire",
      "Aware of intruders",
      "Active",
      ""
    ],
    [
      "2",
      "Symantec's solutions mean minimal downtime and ",
      "Faster recovery",
      "No recovery",
      "Better recovery",
      "Faster employees"
    ],
    [
      "2",
      "With Veritas Cluster Server testing is no\n  longer",
      "Risky or expensive",
      "Possible",
      "Risky",
      "Expensive",
      ""
    ],
    [
      "2",
      "This video is about Business",
      "Continuity",
      "Contingency",
      "Collaboration",
      "Climate",
      ""
    ],
    [
      "2",
      "What percentage of decision-makers think\n  improving Business Continuity a priority?",
      "0.6",
      "0.7",
      "0.25",
      "0.06",
      ""
    ],
    [
      "2",
      "What percentage of IT budget is planned for\n  Business Continuity/Disaster Recovery?",
      "0.066",
      "0.086",
      "0.26",
      "none",
      ""
    ],
    [
      "2",
      "The average enterprise uses how many virtual\n  and back up applications?",
      "7",
      "17",
      "0",
      "8",
      ""
    ],
    [
      "2",
      "What is the name of the new plague?",
      "Data Center Down",
      "Watership Down",
      "Data Deduplication",
      "Data Center Up"
    ],
    [
      "2",
      "What contributes to system downtime as well as\n  mother nature?",
      "Human error & System Failure",
      "Human error",
      "System failure",
      "None of these"
    ],
    [
      "2",
      "What application has Fire Drill capability\n  built in?",
      "Veritas Cluster",
      "Virtual Store",
      "DLP",
      "Desktop Email Encryption"
    ],
    [
      "2",
      "With Veritas Cluster all testing can be done\n  whilst applications remain",
      "On line",
      "On stand by",
      "Off line",
      "Hibernating"
    ],
    [
      "2",
      "What needs to be done before disaster happens?",
      "Testing",
      "Power off",
      "Run for cover",
      "Boarding windows"
    ],
    [
      "2",
      "Keeping your data up and running is about",
      "Real time solutions",
      "Reality shows",
      "Quick solutions",
      "Real software"
    ],
    [
      "2",
      "Symantec provides solutions for applications\n  running on different",
      "Physical and virtual tiers",
      "Physical tiers",
      "Virtual tiers",
      "Physical workouts"
    ],
    [
      "2",
      "What threatens the entire coast?",
      "A Storm",
      "A Swarm",
      "A stampede",
      "A Tidal wave"
    ],
    [
      "2",
      "How many hurricanes occur per year on average?",
      "6",
      "7",
      "16",
      "75",
      ""
    ],
    [
      "2",
      "How many earthquakes happen per year on\n  average?",
      "150",
      "155",
      "200",
      "550",
      ""
    ],
    [
      "2",
      "How many tornadoes happen per year on average?",
      "1253",
      "2523",
      "253",
      "1000",
      ""
    ],
    [
      "2",
      "The video feed was unexpectedly",
      "Terminated",
      "Decontaminated",
      "Broken",
      "Interrupted"
    ],
    [
      "2",
      "How many hours warning did we have of the\n  storm?",
      "24",
      "48",
      "4",
      "36",
      ""
    ],
    [
      "2",
      "Where was the video blogger situated",
      "San Francisco CA",
      "Palo Alto CA",
      "Silicone Valley",
      "Salt Lake City, UT"
    ],
    [
      "2",
      "How much cost in damage due to natural\n  disasters has there been over the past 30 years?",
      "$8.22 billion",
      "$8.22 million",
      "$5 hundred thousand",
      "Not recorded"
    ],
    [
      "2",
      "Which research company provided the facts?",
      "Forrester Research",
      "Gartner",
      "MORI",
      "Clarion Research"
    ],
    [
      "2",
      "The female employee can't work if she can't get to her",
      "Email",
      "Office",
      "Desk",
      "Home",
      ""
    ],
    [
      "2",
      "How many dollars are lost for every lost hour\n  of business?",
      "Millions",
      "Hundreds",
      "Thousands",
      "Five",
      ""
    ],
    [
      "3",
      "Symantec know the ……?.….. of malicious\n  insiders",
      "Demographics",
      "Names",
      "Number",
      "Dimensions"
    ],
    [
      "3",
      "Symantec products have the ability to …..?……\n  malicious insiders ",
      "Lock out",
      "Look up",
      "Like",
      "Remember",
      ""
    ],
    [
      "3",
      "Security is",
      "Knowledge",
      "Happiness",
      "Cool",
      "Smart",
      ""
    ],
    [
      "3",
      "Knowledge is ",
      "Power",
      "Perfect",
      "People",
      "Vital",
      ""
    ],
    [
      "3",
      "Protection is about ",
      "Real time security data",
      "Knowing the math",
      "Double locking doors",
      "Finger print access"
    ],
    [
      "3",
      "No-one collects and deciphers more real time\n  data than",
      "Symantec",
      "Children",
      "Santa Claus",
      "Employees",
      ""
    ],
    [
      "3",
      "Symantec recommend building a team made up\n  of ",
      "HR, Security & Legal",
      "The best players",
      "Technical engineers",
      "Senior managers"
    ],
    [
      "3",
      "Symantec's solution provides dashboards with",
      "A business view",
      "A sea view",
      "Colour options",
      "HR reviews"
    ],
    [
      "3",
      "Symantec recommends using a security\n  technology like",
      "Data Loss Prevention (DLP)",
      "Data Recovery",
      "Data Validation",
      "Norton 360"
    ],
    [
      "3",
      "Symantec deploy technology to find\n  incriminating evidence ",
      "Quickly and easily",
      "Slowly and surely",
      "Fast and furiously",
      "Nice and quietly"
    ],
    [
      "3",
      "This video identifies malicious insider",
      "Protection",
      "Identification",
      "Manipulation",
      "Manifestation"
    ],
    [
      "3",
      "Gangsters, Hackers, Malcontents and …?... engage in\n  organised crime",
      "The Competition",
      "The Employees",
      "The Police",
      "The Customers"
    ],
    [
      "3",
      "A recent report states employees consider\n  intellectual property",
      "Fair game",
      "A fair gain",
      "Free",
      "Protected",
      ""
    ],
    [
      "3",
      "Other potential risks include Customers,  Contractors, Vendors and ",
      "Partners",
      "Players",
      "Staff",
      "Friends",
      ""
    ],
    [
      "3",
      "Many stealing intellectual property are people\n  you ",
      "Trust",
      "Know",
      "Love",
      "Hate",
      ""
    ],
    [
      "3",
      "The majority of malicious insiders are ",
      "Male",
      "Female",
      "Old",
      "Young",
      ""
    ],
    [
      "3",
      "What are ex-employees taking to their new\n  employers?",
      "Intellectual Property",
      "IT",
      "Personnel Files",
      "Colleagues"
    ],
    [
      "3",
      "Removing a company's Intellectual Property\n  is ",
      "Both illicit and illegal",
      "Acceptable",
      "Illicit",
      "Illegal",
      ""
    ],
    [
      "3",
      "Employees can be",
      "Sued",
      "Rewarded",
      "Sacked",
      "Framed",
      ""
    ],
    [
      "3",
      "Many employees think that Managers ",
      "Do not care",
      "Do not know",
      "Report the problem",
      "Do not think"
    ],
    [
      "3",
      "Companies lack a culture of ",
      "Security",
      "Casual dressing",
      "Social networking",
      "Protection",
      ""
    ],
    [
      "3",
      "What is IP",
      "Intellectual Property",
      "Identity Point",
      "Information Protection",
      "Intellectual Priority"
    ],
    [
      "3",
      "Which company does Linda Newquist worked for?",
      "TNC",
      "BBC",
      "NBC",
      "Google",
      ""
    ],
    [
      "3",
      "Which exit does the CCTV camera cover?",
      "M1 North Lobby",
      "M1 South Lobby",
      "M6 North Lobby",
      "M6 South Lobby"
    ],
    [
      "3",
      "Which Channel is making the outdoor broadcast?",
      "10 Action News",
      "NBC",
      "Fox",
      "News 24",
      ""
    ],
    [
      "3",
      "How many circles are there on the opening shot",
      "3",
      "5",
      "2",
      "0",
      ""
    ],
    [
      "3",
      "Which news station is broadcasting the\n  breaking news story?",
      "iNCN",
      "iCNC",
      "BBC",
      "NBC",
      ""
    ],
    [
      "3",
      "Intellectual Property \n  was taken out of the building on a ",
      "Tablet",
      "Mobile phone",
      "Mac air",
      "Pallet truck"
    ],
    [
      "3",
      "What was the name if the IT analyst",
      "Jeff Hinson",
      "Jeff Taylor",
      "Brian Hinson",
      "Brian Taylor"
    ],
    [
      "3",
      "The narrator ends saying ",
      "Peace out",
      "Pace out",
      "Make out",
      "Work out",
      ""
    ],
    [
      "3",
      "What is the name of the video blogger's company?",
      "Tech Mayhem",
      "Tech Know How",
      "Tech Data",
      "Data Mayhem"
    ],
    [
      "4",
      "Mobility without …..?……",
      "Vulnerability",
      "Mutiny",
      "Desirability",
      "Susceptibility"
    ],
    [
      "4",
      "According to Symantec reports what is the\n  percentage increase in Malware during the last 9 months of 2012?",
      "2.1",
      "1.5",
      "0.25",
      "0.5",
      ""
    ],
    [
      "4",
      "Security is ……?…….",
      "Knowledge",
      "Power",
      "Smart",
      "Sensible",
      ""
    ],
    [
      "4",
      "Knowledge is ……?……",
      "Power",
      "Knowledge",
      "Intimidating",
      "Safe",
      ""
    ],
    [
      "4",
      "The average mobile connection speed will\n  surpass how many Mbps in 2014?",
      "1",
      "2",
      "0.5",
      "0",
      ""
    ],
    [
      "4",
      "What percentage of companies give network\n  access through their employees own devices?",
      "0.65",
      "0.52",
      "0.17",
      "0.87",
      ""
    ],
    [
      "4",
      "How often does Symantec meet all Regulatory\n  Compliance Requirements",
      "All the time",
      "On a tuesday",
      "Only after lunch",
      "When CTO is visiting"
    ],
    [
      "4",
      "Symantec has backup and recovery and ….?....\n  to control mobile apps ",
      "Encryption",
      "Decryption",
      "Deduplication",
      "Dedication",
      ""
    ],
    [
      "4",
      "Symantec's logo is  ",
      "Yellow and black",
      "Yellow and Grey",
      "Grey and Black",
      "Orange and Yellow"
    ],
    [
      "4",
      "What does BYOD stand for?",
      "Bring your own device",
      "Bring your own desk",
      "Bring your own dog",
      "Bring your own design"
    ],
    [
      "4",
      "What do companies need to also consider in\n  order to protect data?",
      "Unsecure apps",
      "Unsecure flaps",
      "Unsecure maps",
      "Unsecure bats"
    ],
    [
      "4",
      "What might be happening whilst connected to a\n  unsecure network?",
      "Phishing for data",
      "Fishing for compliments",
      "Draining your battery",
      "Viewing your Facebook "
    ],
    [
      "4",
      "How many mobile apps has Symantec been\n  tracking?",
      " 1.5 million",
      "1500",
      "150000",
      "125000",
      ""
    ],
    [
      "4",
      "How many connections per person do companies\n  now need to make provision for?",
      "2 or 3 secure connections",
      "1 secure connection",
      "Unlimited secure connections",
      "No secure connections"
    ],
    [
      "4",
      "What do users insist on being untouched?",
      "Personal information",
      "Movie selections",
      "Playlists ",
      "Photos",
      ""
    ],
    [
      "4",
      "Connecting to an unsecure network leaves your\n  data….",
      "Wide open for viewing",
      "Vulnerable",
      "Not saved",
      "Decoded",
      ""
    ],
    [
      "4",
      "Companies do not want to be liable for a users …?...",
      "Personal data",
      "Personal preferences",
      "Personal choices",
      "Personal affairs"
    ],
    [
      "4",
      "In what year did the number of mobile\n  connected devices, exceed the worlds population?",
      "2012",
      "2011",
      "2000",
      "1999",
      ""
    ],
    [
      "4",
      "In what year will global mobile data traffic\n  surpass 10 exabytes?",
      "2016",
      "2020",
      "2018",
      "2014",
      ""
    ],
    [
      "4",
      "What are users moving into consumer grade\n  cloud accounts?",
      "Company data",
      "Company cars",
      "Company reputation",
      "Company employees"
    ],
    [
      "4",
      "What should business communications be\n  encrypted with?",
      "SSL",
      "BRB",
      "FYI",
      "XXL",
      ""
    ],
    [
      "4",
      "Mobile productivity must come without\n  compromising .....?....",
      "Protection",
      "Reaction",
      "Transactions",
      "Reputations"
    ],
    [
      "4",
      "What did the employee leave at the airport?",
      "Tablet",
      "Laptop",
      "Mobile phone",
      "Credit Card"
    ],
    [
      "4",
      "What percentage of people regularly use three\n  or more devices?",
      "0.52",
      "0.94",
      "0.34",
      "0.48",
      ""
    ],
    [
      "4",
      "What was the IT Analyst's name?",
      "Jeff Hinson",
      "Jeff Hansen",
      "Geoff Honsen",
      "Seth Hanson"
    ],
    [
      "4",
      "What colour is the anchor-man's tie?",
      "Brown",
      "Yellow",
      "Blue",
      "Red",
      ""
    ],
    [
      "4",
      "Symantec is trying to do what to BYOD?",
      "Embrace",
      "Reject",
      "Remember",
      "Postpone",
      ""
    ],
    [
      "4",
      "What is the news channel's name?",
      "10 Action news",
      "5 local news",
      "7 Serious news",
      "SYM News",
      ""
    ],
    [
      "4",
      "What colour is the IT analyst's shirt?",
      "Blue",
      "White ",
      "Black",
      "Beige",
      ""
    ],
    [
      "4",
      "What did the employee leave on her tablet?",
      "Financial Projections",
      "Personnel Data",
      "Whitepapers",
      "Blueprints",
      ""
    ]
  ]
  helpers.batchInsertQuestions symantecQuesitons





    # collections.Questions.insert
    #   text: 'Category 6 Question 1'
    #   category: 6
    #   options: [
    #     text: 'Correct Answer 1'
    #     correct: true
    #   ,
    #     text: 'Answer 2'
    #   ,
    #     text: 'Answer 3'
    #   ,
    #     text: 'Answer 4'
    #   ]












    





