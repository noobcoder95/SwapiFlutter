## Swapi Flutter - Ferdiansyah (courseit3@gmail.com)

This is an example flutter app to show data from API provided by swapi.dev. Since I don't have the design, so I decided to just made the UI/UX very simple.
But instead just showing data from API, i also add search, filter, sort and caching feature in the app. 
In this project, I am using BLOC pattern with flutter_bloc package to provide clean architecture and to separate UI and business logic.
This project could be run in both mobile platform (iOS and Android) and web platform.
I made this project to support concurrence/multithreading in both mobile and web, and i use easy_localization package to support localization.
I also provide an example of unit testing using bloc_test and equatable package.

Before run this project make sure to get or update all dependencies by run this command in your terminal
(also make sure your directory in terminal pointing to the root of the project):
`flutter pub get` or `flutter pub upgrade`

After all the dependencies resolved, Run this command to launch the app:
`flutter run` or `flutter run -d chrome` to test in web platform
