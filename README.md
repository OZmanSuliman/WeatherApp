# WeatherApp

WeatherApp is an iOS App for weather information.
UI of the app is developed using SwiftUI.


## Environments
The project contains 3 enviroments:
- Development
- Staging
- Release

each environment of these has its own specific configuratuin.
to switch between environments just change scheme in XCode.
Environment is been controlled at the run time by the EnvironmentManager.




## Data Source
The app has 3 main data sources:



#### remote
it is using openweathermap APIs to get the weather data.
this data sourse is handled by ApiManager service.
it is exclusive for staging and release environments.



#### Local Files
It is being managed be ApiManagerMock service.
the core of this service is to read data from files in the project diroctry.
this data source is exclusive for development environment.
> some files may be large, so the service use streamer for reading, which makes any task on this file an O(N).



#### Local DataBase
By using [RealmSwift](https://www.mongodb.com/docs/realm/sdk/swift/ "RealmSwift"), the app manage to persiste the data as a local data base for easier and faster access in the future cases.
this is available for all environments.
this part is being done by the 



## Search
For a bettter UX, the app using MapKit to provide the search engine with suggestions for cities and deliver a smooth auto-complete.




## CI/CD
using fastlane and Github Actions, pipeline runs on one of the 3 environments depending on the destination branch.




## Todo
#### Background Process
Background service is implemented partly.
the idea of it is to provide a feature that keep user updated whenever there is any change in the weather.
this has not been completed due to the time shortage and missing Apple Developer Account.

#### Local Notification
This is works alonge with the background process to notify user whenever there is any update.
it is not been tested yet du to the time shortage.

#### UnitTest
currently there is not much in the unit test, but the app is developed in a a generic way which makes its testablity high.

#### View Reduction
There is a small part of the code exict in the View Layers, by moving this to the presenters the code will be structed better.


#### Design Pattrens
Add factory pattern to manage the services, which will make the code cleaner and more readable
