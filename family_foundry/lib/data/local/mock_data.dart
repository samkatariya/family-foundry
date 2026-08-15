import '../models/member.dart';
import '../models/skill.dart';
import '../models/problem.dart';
import '../models/idea.dart';
import '../models/experiment.dart';
import '../models/action_item.dart';

final mockMembers = [
  Member(
    id: '1',
    name: 'Mohit',
    profession: 'Entrepreneur',
    skills: [
      const Skill(name: 'Startup Strategy', category: 'Business'),
      const Skill(name: 'Fundraising', category: 'Finance'),
    ],
    canHelpWith: ['Business validation', 'Pitch decks', 'Investor connections'],
    interestedIn: ['AgriTech', 'EdTech'],
    wantsToLearn: ['AI product management'],
  ),
  Member(
    id: '2',
    name: 'Nikhil',
    profession: 'Software Engineer',
    skills: [
      const Skill(name: 'Flutter', category: 'Technology'),
      const Skill(name: 'Backend Systems', category: 'Technology'),
    ],
    canHelpWith: ['App development', 'System design', 'Technical mentoring'],
    interestedIn: ['Education', 'HealthTech'],
    wantsToLearn: ['Product design'],
  ),
  Member(
    id: '3',
    name: 'Neha',
    profession: 'Chartered Accountant',
    skills: [
      const Skill(name: 'GST', category: 'Finance'),
      const Skill(name: 'Tax Planning', category: 'Finance'),
    ],
    canHelpWith: ['Financial planning', 'Compliance', 'GST queries'],
    interestedIn: ['Social enterprises'],
    wantsToLearn: ['Impact investing'],
  ),
  Member(
    id: '4',
    name: 'Pratik',
    profession: 'Marketing Consultant',
    skills: [
      const Skill(name: 'Digital Marketing', category: 'Marketing'),
      const Skill(name: 'Brand Strategy', category: 'Marketing'),
    ],
    canHelpWith: ['Go-to-market strategy', 'SEO', 'Content marketing'],
    interestedIn: ['Startups', 'Farming'],
    wantsToLearn: ['Data analytics'],
  ),
  Member(
    id: '5',
    name: 'Ajju',
    profession: 'Farmer & Agribusiness',
    skills: [
      const Skill(name: 'Agriculture', category: 'Agriculture'),
      const Skill(name: 'FPO Formation', category: 'Agriculture'),
    ],
    canHelpWith: ['Crop planning', 'Market linkages', 'Farming best practices'],
    interestedIn: ['Direct farmer markets'],
    wantsToLearn: ['Precision farming'],
  ),
  Member(
    id: '6',
    name: 'Pooja',
    profession: 'Product Designer',
    skills: [
      const Skill(name: 'UI/UX Design', category: 'Design'),
      const Skill(name: 'User Research', category: 'Design'),
    ],
    canHelpWith: ['Prototyping', 'User testing', 'Design thinking workshops'],
    interestedIn: ['Education platforms'],
    wantsToLearn: ['Frontend development'],
  ),
];

final mockProblems = [
  Problem(
    id: 'p1',
    title: 'Farmers struggle to get reliable expert advice quickly',
    description:
        'Small farmers often lack access to trustworthy agricultural experts. They rely on local input dealers who may upsell products. A quick, reliable advisory service could help.',
    postedBy: 'Ankita',
    category: 'Agriculture',
    interestedMembers: ['Ajju', 'Mohit', 'Pratik'],
    potentialSolutions: 2,
  ),
  Problem(
    id: 'p2',
    title: 'No platform for regional-language education content',
    description:
        'Most online education is English-first. People in smaller towns struggle. A platform with quality content in Hindi/Marathi could reach millions.',
    postedBy: 'Nikhil',
    category: 'Education',
    interestedMembers: ['Nikhil', 'Pooja', 'Neha'],
    potentialSolutions: 1,
  ),
  Problem(
    id: 'p3',
    title: 'Waste management in semi-urban areas',
    description:
        'Waste segregation and recycling is poorly implemented outside metros. Could there be a community-driven model?',
    postedBy: 'Pooja',
    category: 'Environment',
    interestedMembers: [],
    potentialSolutions: 0,
  ),
];

final mockIdeas = [
  Idea(
    id: 'i1',
    title: 'Farm Expert Network',
    originProblemId: 'p1',
    status: IdeaStatus.validation,
    peopleInvolved: ['Ajju', 'Pratik', 'Samyak'],
    potentialCustomer: 'Farmers / FPOs',
    nextAction: 'Interview 10 farmers about their current advisory sources',
  ),
  Idea(
    id: 'i2',
    title: 'Regional Education Platform',
    originProblemId: 'p2',
    status: IdeaStatus.discussion,
    peopleInvolved: ['Nikhil', 'Pooja'],
    potentialCustomer: 'Students in tier-2/3 cities',
    nextAction: 'Survey 50 students about their learning preferences',
  ),
  Idea(
    id: 'i3',
    title: 'Online Jamun Flex Business',
    originProblemId: null,
    status: IdeaStatus.discussion,
    peopleInvolved: ['Mohit', 'Shrenik'],
    potentialCustomer: 'Health-conscious urban consumers',
    nextAction: 'Check supply chain and seasonal availability',
  ),
  Idea(
    id: 'i4',
    title: 'Meditation Book + Studio',
    originProblemId: null,
    status: IdeaStatus.discussion,
    peopleInvolved: [],
    potentialCustomer: 'Urban professionals seeking mental wellness',
    nextAction: null,
  ),
];

final mockExperiments = [
  Experiment(
    id: 'e1',
    hypothesis: 'Farmers will pay ₹200/month for reliable expert advice via phone.',
    owner: 'Ajju',
    deadline: DateTime(2024, 8, 20),
    target: 10,
    progress: 6,
    result: null,
  ),
  Experiment(
    id: 'e2',
    hypothesis: 'Students in tier-3 cities prefer video content in Hindi over English.',
    owner: 'Nikhil',
    deadline: DateTime(2024, 8, 25),
    target: 20,
    progress: 4,
    result: null,
  ),
];

final mockActionItems = [
  ActionItem(
    id: 'a1',
    description: 'Interview 5 more farmers in Nashik region',
    assignedTo: 'Ajju',
    isDone: false,
    relatedExperimentId: 'e1',
  ),
  ActionItem(
    id: 'a2',
    description: 'Prepare survey form for student preferences',
    assignedTo: 'Pooja',
    isDone: true,
    relatedExperimentId: 'e2',
  ),
  ActionItem(
    id: 'a3',
    description: 'Research existing ed-tech platforms in regional languages',
    assignedTo: 'Nikhil',
    isDone: false,
    relatedExperimentId: 'e2',
  ),
];

final mockNextMeeting = {
  'date': '23 August, 7:00 PM',
  'agenda': [
    'Review experiment progress',
    'New problems from members',
    'Vote on next idea to validate',
    'Assign actions for next sprint',
  ],
};
