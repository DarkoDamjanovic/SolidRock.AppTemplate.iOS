![SolidRock](https://github.com/DarkoDamjanovic/SolidRock.AppTemplate.iOS/blob/master/solidrock.jpg "SolidRock")

# SolidRock AppTemplate for iOS

This repository should give you a solid rock starting point for new iOS Apps. All themes are handled which are used by 99% of all Apps like Configuration, Networking, Logging, Storyboard handling, etc.. . If you are a beginner iOS developer then you can use this if you are not sure how to structure your App. If you are an advanced iOS developer then let be inspired - maybe you will find something which complements you current workflow.

## Configuration

The App configures itself thru the `Info.plist` file. The `Info.plist` file has a special feature supported by Xcode to inject variables during compilation time. This variables can be set in the Build Settings of the project and then are later specified with the `$(MY_VARIABLE)` syntax in the `Info.plist`. The big advantage - the Build Settings variables can be set different for each build configuration like Debug, Release, etc... In this way it get's really easy to configure everything which is specific to the build configuration. For example API Base URL's, API Keys, etc..

## MVP - Model View Presenter architecture

SolidRock App Template uses the MVP (Model View Presenter) architecture pattern. Additionally a `Builder` and `Router` class is created. 

* `Builder`

   The `Builder` is used to create the module and to inject all needed dependencies.

* `Router`

   The `Router` handles all the navigation use-cases between views and passes the shared dependencies from one module into the other. In this way only the really needed dependencies are injected into the presenter and view. 

* `View`

UIViewController and other UIView derived classes (e.g. UILabel, UITableView) are the representation of the `View` layer from the MVP pattern. 

* `Presenter`

The `Presenter` has an own implementation. The `Presenter` handles only presentation logic and use-cases but not business logic. (that's the job of the `Model` layer) The `Presenter` never imports `UIKit`, that's the job of the `View`. (UIViewController + other UIView  derived classes)

* `Model`

The `Model` is basically all `Service` classes or alternatively specific `UseCase` implementations. The `Model` does know nothing about the `View` and the `View` does know anything about the `Model`. It's the `Presenter`s job to glue them together.

## Singletons

Meanwhile it should be clear to anyone that Singletons are (in most cases) an anti-pattern. But the problem with Singletons is not the fact that they assure that there is just one instance of a type available. The real problem is that they can be accessed globally over the typical mySingletonObject.sharedInstance.myFunc(). In the SolidRock App Template this pattern is avoided by doing a check during initialization of the class for possible multiple instances. This check is not done in Test Targets (UnitTest, UITest) so the class stays fully testable. In order to access such a created singleton it has to be passed by the `SharedDependencies` and injected on demand. This still does not solve the problem of shared mutable state - but if prepares the stage to handle this problem as well. In the best case all shared dependencies are immutable. If not - the state has to be synchronized, to avoid concurrency issues.

## Dependency Injection 

Every dependency which is needed by a module is injected by a `Builder` class. Usually dependencies can be created directly by the `Builder` itself. If shared dependencies are needed then also the `Builder` injects it into the module and additionally forwards the shared dependencies to the `Router` in turn can use the `SharedDependencies` to inject them into the next `Builder` and so on.  

## Protocol oriented loose coupling

Every dependency is injected as a protocol, never the concrete implementation itself. In this way loose coupling is assured thru the whole App. In this way we gain all the advantages of loose coupling. 

## Testing

One of the advandages of loose coupling is that Mock classes can be injected during Unit Tests. Which in turn enables complete testability for presentation and business logic. The view classes itself are not unit tested, they are just a "dumb" breakdown of UI setters or input use cases. It's the job of the creators of those classes to test them. (in this case Apples UIKit team) Also the `Builder` and `Router` are not unit tested specifically. (just in special cases)

## Storyboards

Every viewcontroller is stored in an own storyboard. This prevents merge problems if multiple developer work on the UI. Each viewcontroller has a storyboard with the same name as the viewcontroller itself. The viewcontroller in the storyboard is marked as "Initial viewcontroller". In this way we can use a simple extension on UIViewController and UIStoryboard to instantiate every viewcontroller without knowing the storyboard name or some ID in the storyboard.

    let viewController = MoviesViewController.storyboardInstance()

## Networking

Networking is done with NSURLSession, not with Alamofire. For most cases NSURLSession is perfectly fine and there is no need to introduce a third party library. But there is nothing wrong with Alamofire, if you are used to it - go on. However, what is more important is to implement networking code only once and not repeat yourself all the time. That's why Networking is done with Swift Generics. By simply extending the WebService class with a few lines of code. New endpoints are implemented in this way in seconds.

## Cocoapods

Cocoapods is the de-facto package manager for iOS. Most available 3rd party libraries are integrated into iOS projects over Cocoapods. There is no real need for Cocoapods in this small sample App but for the sake of demonstration the famous SDWebImage is included for downloading and caching images.

## Contributing

I am open for discussion, please post issues or add pull requests to this repository. I am happy to get new input and would like to improve this App template over time.






