# Flutter Course BMI Calculator
I recently got interested in [Flutter](https://flutter.dev/), and after doing some reading and
fooling around I decided to do AppBrewery's 
[Complete 2021 Flutter Development Bootcamp with Dart](https://www.appbrewery.co/p/flutter-development-bootcamp-with-dart)
course. One of the lessons involves creating a BMI calculator based on
[this design](https://dribbble.com/shots/4585382-Simple-BMI-Calculator). Rather than
going through the lesson I figured I'd give it a shot from scratch (I did clone
the original repo, but there wasn't much there) to see how much I understand so far. It also
gives me a chance to do some unopinionated (this is a word now) Googling, because the course
appears to be quite outdated in some respects.

What I ended up with is, I suspect, quite different from what the course is doing (I'm returning to
it after finishing this README).
- I'm using [provider](https://pub.dev/packages/provider) since it appears to be an important pattern
    in Flutter, and I wanted to try it out.
- No local color definitions, everything is themed. It was really quite a mess to figure out how
    to do that correctly, and I'm not sure I'm all the way there. To some extend it 
  [probably just is kind of a mess](https://docs.google.com/document/d/1kzIOQN4QYfVsc5lMZgy_A-FWGXBAJBMySGqZqsJytcE/edit#).
- Since I was theming anyway, I figured I'd add light / dark mode support (following the system setting). 
  Dark mode is the one in the supplied design, light mode uses something, well, light.
  
Some other notes:
- The male / female and age controls, while functional, don't change anything in the result.
  I did go through the effort of putting the default BMI health ranges in, but anything beyond
  that is really not the point of this exercise.