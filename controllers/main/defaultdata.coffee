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


  symantecQuesitons = [
    [
      "1",
      "Symantec",
      "Symantec Solutions for Malware are:",
      "All of these",
      "Faster ",
      "Stronger",
      "Anticipate threats"
    ],
    [
      "1",
      "Symantec",
      "Symantec Solution for Cyber Attacks is called?",
      "Global Intelligence Network",
      "Global Attack Network",
      "Global Eye Network",
      "Global Data Network"
    ],
    [
      "1",
      "Symantec",
      "What does Symantec have built into their products?",
      "Multiple Technologies",
      "Nice Colours",
      "Great Designs",
      "Pleasing Patterns"
    ],
    [
      "1",
      "Symantec",
      "Symantec Insight uses",
      "Reputation Security Technology",
      "Media Reports",
      "Crystal ball",
      "Musical Notes"
    ],
    [
      "1",
      "Symantec",
      "Companies using Symantec Protection Policies are reporting improved:",
      "All of these",
      "Detection",
      "Performance",
      "Accuracy"
    ],
    [
      "1",
      "Symantec",
      "Symantec Insight tracks millions of files and billions of data to:",
      "Identify new threats being created",
      "Identify Trends ",
      "Identify Ideas",
      "Identify People"
    ],
    [
      "1",
      "Symantec",
      "Symantec collects and deciphers",
      "Global Intelligence",
      "Weather Patterns",
      "Constellations",
      "Volcanic activity"
    ],
    [
      "1",
      "Symantec",
      "Symantec can help businesses ",
      "Of all sizes",
      "Only on a small scale",
      "Only on a medium scale",
      "Only on a large scale"
    ],
    [
      "1",
      "Symantec",
      "Symantec knows",
      "How to interpret all the data",
      "Distribute the data",
      "Upload the data",
      "Collect the data"
    ],
    [
      "1",
      "Symantec",
      "Symantec Insight resolves Malware Issues",
      "In time",
      "In a week",
      "In a month",
      "In a year"
    ],
    [
      "1",
      "Symantec",
      "Symantec takes the data and",
      "Builds the right defence",
      "Ignores it",
      "Files it",
      "Gives it back"
    ],
    [
      "1",
      "Symantec",
      "Symantec gives",
      "Real Solutions",
      "Good advice",
      "Good prizes",
      "Good support"
    ],
    [
      "1",
      "Symantec",
      "Symantec is the Leader in collecting and deciphering Global Intelligence",
      "TRUE",
      "FALSE",
      "",
      ""
    ],
    [
      "1",
      "Symantec",
      "Symantec helps businesses recover from attacks and also",
      "Avoid them completely",
      "Ignore them",
      "Send them away",
      "Understand them"
    ],
    [
      "1",
      "Product",
      "Advanced Malware is responsible for",
      "Cyber Attack",
      "Verbal attack",
      "Art attack",
      "Time attack"
    ],
    [
      "1",
      "Product",
      "Cyber Attacks only happen to big Corporations",
      "FALSE",
      "TRUE",
      "",
      ""
    ],
    [
      "1",
      "Product",
      "Cyber Attacks target",
      "All of these",
      "Employees",
      "Customers",
      "Critical information"
    ],
    [
      "1",
      "Product",
      "Cyber Attacks can be present in",
      "All of these",
      "Spam",
      "Website Attacks",
      "Malvertising"
    ],
    [
      "1",
      "Product",
      "Anti Virus solutions are enough against Cyber Attacks",
      "FALSE",
      "TRUE",
      "",
      ""
    ],
    [
      "1",
      "Product",
      "Security is ",
      "Knowledge",
      "A Guard dog",
      "A Fence",
      "A Wall"
    ],
    [
      "1",
      "Product",
      "Knowledge is",
      "Power",
      "Strength",
      "Physical Fitness",
      "Agility"
    ],
    [
      "1",
      "Product",
      "Protection is about real time",
      "Security Intelligence",
      "Higher intelligence",
      "Basic Intelligence",
      "Average Intelligence"
    ],
    [
      "1",
      "Product",
      "What do Cyber criminals want",
      "Valuable Information",
      "Television Listings",
      "Clever sayings",
      "Football Statistics"
    ],
    [
      "1",
      "Product",
      "Targeted attacks and Data Breaches are",
      "Rising",
      "Falling",
      "Staying the same",
      "Non existent"
    ],
    [
      "1",
      "Observe",
      "The gentleman newsreader is",
      "Sitting in a studio",
      "Jogging",
      "Kneeling down",
      "Standing"
    ],
    [
      "1",
      "Observe",
      "What colour is the blouse of the small business lady?",
      "Pink",
      "Yellow",
      "Blue",
      "Black"
    ],
    [
      "1",
      "Observe",
      "How does the video blogger end his 'speech'",
      "Peace out",
      "Peace to the World",
      "Global Peace",
      "Peace be with you"
    ],
    [
      "1",
      "Observe",
      "What is the name of the news channel?",
      "10 Action News",
      "Newsbeat",
      "Cyber news",
      "News for you"
    ],
    [
      "1",
      "Observe",
      "What colour is the handheld microphone that the lady newsreader is holding?",
      "Grey",
      "Black",
      "Red",
      "White"
    ],
    [
      "1",
      "Observe",
      "How many monitors are on the desk of the small business lady?",
      "Two",
      "One",
      "Three",
      "None"
    ],
    [
      "1",
      "Observe",
      "According to the young lady from Georgia, companies need someone who",
      "All of these",
      "Has the tools",
      "Recognises the problem",
      "Acts on the data"
    ],
    [
      "2",
      "Symantec",
      "Symantec know the …….. of malicious insiders",
      "demographics",
      "names",
      "number",
      "dimensions"
    ],
    [
      "2",
      "Symantec",
      "Symantec products have the ability to …… malicious insiders ",
      "lock out",
      "look up",
      "like",
      "remember"
    ],
    [
      "2",
      "Symantec",
      "Security is",
      "knowledge",
      "happiness",
      "cool",
      "smart"
    ],
    [
      "2",
      "Symantec",
      "Knowledge is ",
      "power",
      "perfect",
      "people",
      "vital"
    ],
    [
      "2",
      "Symantec",
      "Protection is about ",
      "real time security data",
      "knowing the math",
      "double locking doors",
      "finger print access"
    ],
    [
      "2",
      "Symantec",
      "No-one collects and deciphers more real time data that ",
      "Symantec",
      "RSA",
      "Santa Claus",
      "Employees"
    ],
    [
      "2",
      "Symantec",
      "Symantec recommend building a team made up of ",
      "HR, Security & Legal",
      "the best players",
      "technical engineers",
      "senior managers"
    ],
    [
      "2",
      "Symantec",
      "Symantec's solution provides dashboards with",
      "a business view",
      "a sea view",
      "colour options",
      "HR reviews"
    ],
    [
      "2",
      "Symantec",
      "Symantec recommends using a security technology like",
      "Data Loss Prevention (DLP)",
      "Data Loss Protection",
      "Data Validation",
      "Norton 360"
    ],
    [
      "2",
      "Symantec",
      "Deploy technology to find incrimination evidence ",
      "quickly and easily",
      "slowly and surely",
      "fast and furiously",
      "nice and quietly"
    ],
    [
      "2",
      "Product",
      "This video identifies malicious insider",
      "Protection",
      "Identification",
      "Manipulation",
      "Manifestation"
    ],
    [
      "2",
      "Product",
      "Gangsters, Hackers, Malcontents and ……. engage in organised crime",
      "The Competition",
      "The Employees",
      "The Pope",
      "The Customers"
    ],
    [
      "2",
      "Product",
      "A recent report states employees consider intellectual property",
      "Fair game",
      "a fair gain",
      "free",
      "protected"
    ],
    [
      "2",
      "Product",
      "Other potential risks include Customers,  Contractors, Vendors and ",
      "Partners",
      "Players",
      "Staff",
      "Friends"
    ],
    [
      "2",
      "Product",
      "Many stealing intellectual property are people you ",
      "Trust",
      "Know",
      "Love",
      "Hate"
    ],
    [
      "2",
      "Product",
      "The majority of malicious insiders are ",
      "Male",
      "Female",
      "Old",
      "Young"
    ],
    [
      "2",
      "Product",
      "What are ex-employees taking to their new employers?",
      "IP",
      "IT",
      "Personnel Files",
      "Colleagues"
    ],
    [
      "2",
      "Product",
      "Removing a company's IP is ",
      "both illicit and illegal",
      "acceptable",
      "illicit",
      "illegal"
    ],
    [
      "2",
      "Product",
      "Employees can be",
      "sued",
      "rewarded",
      "sacked",
      "framed"
    ],
    [
      "2",
      "Product",
      "Many employees think that managers ",
      "do not care",
      "do not know",
      "report the problem",
      "do not think"
    ],
    [
      "2",
      "Product",
      "Companies lack a culture of ",
      "security",
      "smileys",
      "social networking",
      "protection"
    ],
    [
      "2",
      "Observe",
      "Which company does Linda Newquist worked for?",
      "TNC",
      "BBC",
      "NBC",
      "Google"
    ],
    [
      "2",
      "Observe",
      "Which exit does the CCTV camera cover?",
      "M1 North Lobby",
      "M1 South Lobby",
      "M6 North Lobby",
      "M6 South Lobby"
    ],
    [
      "2",
      "Observe",
      "Which Channel is making the outdoor broadcast?",
      "10 Action News",
      "NBC",
      "Fox",
      "News 24"
    ],
    [
      "2",
      "Observe",
      "How many circles are there on the opening shot",
      "3",
      "5",
      "2",
      "0"
    ],
    [
      "2",
      "Observe",
      "Which news station is broadcasting the breaking news story?",
      "iNCN",
      "iCNC",
      "BBC",
      "NBC"
    ],
    [
      "2",
      "Observe",
      "IP was taking out of the building on a ",
      "tablet",
      "mobile phone",
      "mac air",
      "pallet truck"
    ],
    [
      "2",
      "Observe",
      "What was the name if the IT analyst",
      "Jeff Hinson",
      "Jeff Taylor",
      "Brian Hinson",
      "Brian Taylor"
    ],
    [
      "2",
      "Observe",
      "What was the colour of the female employee?",
      "Red",
      "Black",
      "Brown",
      "Blond"
    ],
    [
      "2",
      "Observe",
      "The narrator ends saying ",
      "peace out",
      "pace out",
      "make out",
      "work out"
    ],
    [
      "2",
      "Observe",
      "What is the name of the narrators company?",
      "Tech Mayhem",
      "Tech Know How",
      "Tech Data",
      "Data Mayhem"
    ],
    [
      "3",
      "Symantec",
      "Which Symantec product can provide the solution you need?",
      "Symantec Net Backup",
      "Norton 360",
      "Asset Management Suite",
      "Back Up Exec"
    ],
    [
      "3",
      "Symantec",
      "Which Symantec product can provide the solution you need?",
      "Veritas Cluster Server",
      "ApplicationHA",
      "Norton 360",
      "Enterprise Vault"
    ],
    [
      "3",
      "Symantec",
      "Symantec means availability you can",
      "count on",
      "count up",
      "do without",
      "measure"
    ],
    [
      "3",
      "Symantec",
      "Symantec Net Back Up and Verirtas Cluster Server",
      "know where the problems are",
      "don’t have any problems",
      "know where your office is",
      "know your company"
    ],
    [
      "3",
      "Symantec",
      "Symantec's solution offers",
      "virtual business services",
      "virtual support",
      "online business services",
      "virtual assistants"
    ],
    [
      "3",
      "Symantec",
      "Symantec' solution makes sure your business is always",
      "up and running",
      "safe from fire",
      "aware of intruders",
      "active"
    ],
    [
      "3",
      "Symantec",
      "Symantec's solutions mean minimal downtime and ",
      "faster recovery",
      "no recovery",
      "better recovery",
      "faster employees"
    ],
    [
      "3",
      "Symantec",
      "With Veritas Cluster server testing is no longer",
      "risky or expensive",
      "possible",
      "risky",
      "expensive"
    ],
    [
      "3",
      "Product",
      "This video is about business",
      "continuity",
      "contingency",
      "collaboration",
      "climate"
    ],
    [
      "3",
      "Product",
      "What percentage of decision-makers think improving BC/DR a priority?",
      "0.6",
      "0.7",
      "0.25",
      "0.06"
    ],
    [
      "3",
      "Product",
      "What percentage of IT budget planned for BC/DR?",
      "0.066",
      "0.086",
      "0.26",
      "none"
    ],
    [
      "3",
      "Product",
      "The average enterprise uses how many virtual and back up applications?",
      "7",
      "17",
      "1.7",
      "8"
    ],
    [
      "3",
      "Product",
      "What is the name of the new plague?",
      "Data Center Down",
      "Watership Down",
      "Data Deduplication",
      "Data Center Up"
    ],
    [
      "3",
      "Product",
      "What contributes to system downtime as well as mother nature?",
      "Human Error & System Failure",
      "Human Error",
      "System Failure",
      "None of these"
    ],
    [
      "3",
      "Product",
      "What application has Fire Drill capability built in?",
      "Veritas Cluster",
      "VirtualStore",
      "DLP",
      "Desktop Email Encryption"
    ],
    [
      "3",
      "Product",
      "With Veritas Cluster all testing can be done whilst applications remain",
      "on line",
      "on stand by",
      "off line",
      "hibernating"
    ],
    [
      "3",
      "Product",
      "What is critical to success when disaster hits?",
      "Testing",
      "Power off",
      "Run for cover",
      "Boarding windows"
    ],
    [
      "3",
      "Product",
      "Keeping your data up and running is about",
      "real time solutions",
      "reality shows",
      "quick solutions",
      "real software"
    ],
    [
      "3",
      "Product",
      "Solutions for applications ruining on different",
      "physical and virtual tiers",
      "physical tiers",
      "virtual tiers",
      "physical workouts"
    ],
    [
      "3",
      "Observe",
      "What threatens the entire coast?",
      "A storm",
      "A swarm",
      "A hurricane",
      "A tidal wave"
    ],
    [
      "3",
      "Observe",
      "How many hurricanes per year on average?",
      "6",
      "7",
      "16",
      "75"
    ],
    [
      "3",
      "Observe",
      "How many earthquakes per year on average?",
      "150",
      "155",
      "200",
      "550"
    ],
    [
      "3",
      "Observe",
      "How many tornadoes per year on average?",
      "1253",
      "2523",
      "253",
      "1000"
    ],
    [
      "3",
      "Observe",
      "Video feed was unexpectedly",
      "terminated",
      "decontaminated",
      "broken",
      "interrupted"
    ],
    [
      "3",
      "Observe",
      "How many hours warning did we have of the storm?",
      "24",
      "48",
      "4",
      "36"
    ],
    [
      "3",
      "Observe",
      "Where was the video blogger situated",
      "San Francisco CA",
      "Palo Alto CA",
      "Silicone Valley",
      "Salt Lake City, UT"
    ],
    [
      "3",
      "Observe",
      "Cost in damage over past 30 years",
      "$8.22BILLION",
      "$8.22MILLION",
      "$5BILLION",
      "Not recorded"
    ],
    [
      "3",
      "Observe",
      "Which research company provided the facts",
      "Forrester Research",
      "Gartner",
      "MORI",
      "Clarion Research"
    ],
    [
      "3",
      "Observe",
      "Female employee can't work if she can't get to her",
      "email",
      "office",
      "desk",
      "home"
    ],
    [
      "3",
      "Observe",
      "Millions of dollars are lost every …….. we can't do business due to disaster",
      "hour",
      "week",
      "day",
      "minute"
    ],
    [
      "4",
      "Symantec",
      "Mobility without …………….?",
      "Vulnerability",
      "Mutiny",
      "Desirability",
      "Susceptibility"
    ],
    [
      "4",
      "Symantec",
      "Symantec reports what percentage increase in Malware of the last 9 months of 2012?",
      "2.1",
      "1.5",
      "10",
      "0.5"
    ],
    [
      "4",
      "Symantec",
      "Security is ………….?",
      "Knowledge",
      "Power",
      "Smart",
      "Sensible"
    ],
    [
      "4",
      "Symantec",
      "Knowledge is …………?",
      "Power",
      "Knowledge",
      "Intimidating",
      "Safe"
    ],
    [
      "4",
      "Symantec",
      "The average mobile connection speed with surpass how many Mbps in 2014",
      "1",
      "2",
      "10",
      "6"
    ],
    [
      "4",
      "Symantec",
      "What percentage of companies give network access through their own device?",
      "0.65",
      "0.52",
      "0.17",
      "0.87"
    ],
    [
      "4",
      "Symantec",
      "Symantec Meet all Regulatory Compliance Requirements",
      "All the time",
      "On a Tuesday",
      "Only after lunch",
      "When CTO is visiting"
    ],
    [
      "4",
      "Symantec",
      "Symantec has backup and recovery & what to control mobile apps ",
      "Encryption",
      "Decryption",
      "Deduplication",
      "Dedication"
    ],
    [
      "4",
      "Symantec",
      "Symantec's logo is  ",
      "Yellow and black",
      "Yellow and Grey",
      "Grey and Black",
      "Orange and Yellow"
    ],
    [
      "4",
      "Product",
      "What does BYOD stand for?",
      "Bring your own device",
      "Bring your own service",
      "Bring your own slice",
      "Bring your own design"
    ],
    [
      "4",
      "Product",
      "What do companies need to also consider in order to protect data?",
      "Unsecure apps",
      "Unsecure flaps",
      "Unsecure maps",
      "Unsecure bats"
    ],
    [
      "4",
      "Product",
      "What might be happening whilst connected to a unsecure network?",
      "Phishing for data",
      "Fishing for fish",
      "Draining your battery",
      "Viewing your Facebook "
    ],
    [
      "4",
      "Product",
      "How many mobile apps has Symantec been tracking?",
      " 1.5 million",
      "1.5 billion",
      "100000000",
      "150000"
    ],
    [
      "4",
      "Product",
      "What do companies now need to provision for?",
      "2 or 3 secure connections",
      "Several secure connections",
      "Limited secure connections",
      "Starvation"
    ],
    [
      "4",
      "Product",
      "What do users insist on being untouched?",
      "Personal information",
      "Movie selections",
      "Playlists kept the same",
      "Photo's not viewed"
    ],
    [
      "4",
      "Product",
      "Connecting to an unsecure network leaves your data….",
      "Wide open for viewing",
      "Slightly closed for copying",
      "Ajar for seeing",
      "Shut forever"
    ],
    [
      "4",
      "Product",
      "Companies do not want to be liable for a users……?",
      "Personal data",
      "Personal preferences",
      "Personal choices",
      "Personal "
    ],
    [
      "4",
      "Product",
      "In what year did the number of mobile connected devices, exceed the worlds population?",
      "2012",
      "2011",
      "2013",
      "2030"
    ],
    [
      "4",
      "Product",
      "In what year will global mobile data traffic surpass 10 exabytes?",
      "2016",
      "2017",
      "2018",
      "2014"
    ],
    [
      "4",
      "Product",
      "What are users moving into consumer grade cloud accounts?",
      "Company data",
      "Company cars",
      "Company reputation",
      "Company employees"
    ],
    [
      "4",
      "Product",
      "What should business communications be encrypted with?",
      "SSL",
      "BRB",
      "FYI",
      "XXL"
    ],
    [
      "4",
      "Product",
      "Mobile productivity must come without compromising what?",
      "Protection",
      "Reaction",
      "Transactions",
      "Reputations"
    ],
    [
      "4",
      "Observe",
      "What did the employee leave at the airport?",
      "Tablet",
      "Laptop",
      "Mobile phone",
      "Credit Card"
    ],
    [
      "4",
      "Observe",
      "Shown on the video, what percentage regularly use three or more devices?",
      "0.52",
      "0.94",
      "0.34",
      "0.48"
    ],
    [
      "4",
      "Observe",
      "What was the IT analyst's name?",
      "Jeff Hinson",
      "Jeff Hansen",
      "Geoff Honsen",
      "Heff Hanson"
    ],
    [
      "4",
      "Observe",
      "What colour is the anchor-man's tie?",
      "Brown",
      "Purple",
      "Blue",
      "Red"
    ],
    [
      "4",
      "Observe",
      "Symantec is trying to do what to BYOD?",
      "Embrace",
      "Reject",
      "Remember",
      "Postpone"
    ],
    [
      "4",
      "Observe",
      "What is the news channel's name?",
      "10 Action news",
      "5 local news",
      "7 Serious news",
      "SYM News"
    ],
    [
      "4",
      "Observe",
      "What colour is the IT analyst's shirt?",
      "Blue",
      "White ",
      "Black",
      "Beige"
    ],
    [
      "4",
      "Observe",
      "What did the employee leave a copy of, on her tablet?",
      "Financial Projections",
      "Personnel Data",
      "Whitepapers",
      "Blueprints"
    ]
  ]

  for question in symantecQuesitons
    insertQuestion = {}
    for field, i in question
      switch i 
        when 0
          insertQuestion.category = parseInt field
        when 1
          question[2] = "#{field}: #{question[2]}" 
        when 2
          insertQuestion.text = field
        when 3
          insertQuestion.options = [
            text: field
            correct: true
          ]
        else
          if field isnt ''
            insertQuestion.options.push 
              text: field

    collections.Questions.insert insertQuestion





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












    





