# Flutter Course BMI Calculator
I recently got interested in [Flutter](https://flutter.dev/), and after doing some reading and
fooling around I decided to do AppBrewery's 
[Complete 2021 Flutter Development Bootcamp with Dart](https://www.appbrewery.co/p/flutter-development-bootcamp-with-dart)
course. One of the lessons involves creating a BMI calculator based on
[this design](https://dribbble.com/shots/4585382-Simple-BMI-Calculator). Rather than
going through the lesson I figured I'd give it a shot from scratch to see how much I understand so far. I did clone the
original project, or rather the [one migrated by tigerjoy](https://github.com/tigerjoy/bmi-calculator-flutter)
(thanks, by the way!), but there isn't much there. It also
gives me a chance to do some unopinionated Googling with regards to best practices, because the course
appears to be quite outdated in some respects.

What I ended up with is, I suspect, quite different from what the course is doing (I'm returning to
it after finishing this README).
- I'm using [provider](https://pub.dev/packages/provider) since it appears to be an important pattern
  in Flutter, and I wanted to try it out. Some of the `Consumer`s are inside of extracted widgets,
  which made the code cleaner in this case, but is probably not great if you'd want to user those widgets
  for something else.
- No local color definitions, everything is themed. It was really quite a mess to figure out how
    to do that correctly, and I'm not sure I'm all the way there. To some extend it 
  [probably just is kind of a mess](https://docs.google.com/document/d/1kzIOQN4QYfVsc5lMZgy_A-FWGXBAJBMySGqZqsJytcE/edit#).
- For the weight / age controls, I implemented custom buttons that increment / decrement the
  corresponding properties with increasing speed when held, so you can just press and hold to
  rapidly change the property. Also see [my answer on StackOverflow](https://stackoverflow.com/a/69977924/358873).
- Since I was theming anyway, I figured I'd add light / dark mode support (following the system setting). 
  Dark mode is the one in the supplied design, light mode uses something, well, light.
- I'm using named routes for navigation, which is entirely superfluous here, but again I was curious.
  
Some other notes:
- The male / female and age controls, while functional, don't change anything in the result.
  I did go through the effort of putting the default BMI health ranges in, but anything beyond
  that is really not the point of this exercise.

I might update this app as I go along as it provides a nice canvas for playing around with Flutter.