mike = User.find_or_create_by(name: "Mike", user_name: "Mike", email: "mike@test.com", password: "12345678")
stive = User.find_or_create_by(name: "Stive", user_name: "Stive", email: "stive@test.com", password: "12345678")
john = User.find_or_create_by(name: "John", user_name: "John", email: "john@test.com", password: "12345678")
robert =User.find_or_create_by(name: "Robert", user_name: "Robert", email: "robert@test.com", password: "12345678")

question_1 = Question.find_or_create_by(
  title: "How to set up Amplitude with Riverpod generators?",
  content: "I am using Riverpod for state management and want to set up Amplitude for tracking...",
  user: mike
)

question_2 = Question.find_or_create_by(
  title: "Flutter-Riverpod - how to combine providers to filter on a Stream",
  content: "I'm trying to follow the example docs on how to combine Providers using Flutter & Riverpod to filter a list of items. The data is coming from Firestore using Streams...",
  user: stive
)

question_3 = Question.find_or_create_by(
  title: "How do you combine 2 Riverpod StreamProviders where 1 stream depends on the data from another stream?",
  content: "Sometimes I think I'm getting the logic of providers and then I get stumped for hours trying to do something like below. I need to get a List of connection id's from a firestore collectionsstream. Easy....",
  user: john
)

question_4 = Question.find_or_create_by(
  title: "Combine streams from Firestore in flutter",
  content: "I have been trying to listen to more than one collection from Firestone using a StreamBuilder or something similar. My original code when I was working with only one Stream was....",
  user: robert
)


answer_1 = Answer.find_or_create_by(
  question: question_4,
  content: "I have been trying to listen to more than one collection from Firestone using a StreamBuilder or something similar. My original code when I was working with only one Stream was....",
  user: mike
)

answer_2 = Answer.find_or_create_by(
  question: question_3,
  content: "Sometimes I think I'm getting the logic of providers and then I get stumped for hours trying to do something like below. I need to get a List of connection id's from a firestore collectionsstream. Easy....",
  user: stive
)

answer_3 = Answer.find_or_create_by(
  question: question_2,
  content: "I'm trying to follow the example docs on how to combine Providers using Flutter & Riverpod to filter a list of items. The data is coming from Firestore using Streams...",
  user: john
)

answer_4 = Answer.find_or_create_by(
  question: question_1,
  content: "I am using Riverpod for state management and want to set up Amplitude for tracking...",
  user: robert
)

Comment.find_or_create_by(
  commented_to: question_2,
  content: "Aaaaaa",
  user: robert
)

Comment.find_or_create_by(
  commented_to: question_3,
  content: "Oh!!!!",
  user: mike
)

Comment.find_or_create_by(
  commented_to: answer_1,
  content: "No bad!!!!",
  user: stive
)

Comment.find_or_create_by(
  commented_to: answer_4,
  content: "Yes, dude!!!",
  user: john
)

tag_1 = Tag.find_or_create_by(name: "Flutter")
tag_2 = Tag.find_or_create_by(name: "React")
tag_3 = Tag.find_or_create_by(name: "Dart")
tag_4 = Tag.find_or_create_by(name: "JS")

QuestionTag.find_or_create_by(
  tag: tag_1,
  question: question_1
)

QuestionTag.find_or_create_by(
  tag: tag_2,
  question: question_1
)

QuestionTag.find_or_create_by(
  tag: tag_2,
  question: question_2
)

QuestionTag.find_or_create_by(
  tag: tag_4,
  question: question_2
)

QuestionTag.find_or_create_by(
  tag: tag_3,
  question: question_3
)

QuestionTag.find_or_create_by(
  tag: tag_4,
  question: question_4
)




