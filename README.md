![SolidRock](https://github.com/DarkoDamjanovic/SolidRock.AppTemplate.iOS/blob/master/solidrock.jpg "SolidRock")

# SolidRock App Template for iOS

This repository should give you a rock solid foundation for new iOS Apps. All themes are handled which are used by 99% of all Apps like Configuration, Networking, Logging, Storyboard handling, etc.. . If you are a beginner iOS developer then you can use this if you are not sure how to structure your App. If you are an advanced iOS developer then let be inspired - maybe you will find something which complements you current workflow.

## Configuration

The App configures itself thru the `Info.plist` file. The `Info.plist` file has a special feature supported by Xcode to inject variables during compile time. This variables can be set in the Build Settings of the project and then are later specified with the `$(MY_VARIABLE)` syntax in the `Info.plist` file. The big advantage - the Build Settings variables can be set different for each build configuration like Debug, Release, etc... In this way it get's really easy to configure everything which is specific to the build configuration. For example API Base URL's, API Keys, etc..

## MVP - Model View Presenter architecture

SolidRock App Template uses the MVP (Model View Presenter) architecture pattern. Additionally a `Builder` and `Router` classes are created. 

* `Builder`

   The `Builder` is used to create the module and to inject all needed dependencies.

* `Router`

   The `Router` handles all the navigation use-cases between views and passes the shared dependencies from one module into the other. In this way only the really needed dependencies are injected into the presenter and view. 

* `View`

UIViewController and other UIView derived classes (e.g. UILabel, UITableView) are the representation of the `View` layer from the MVP pattern. 

* `Presenter`

The `Presenter` has an own implementation. The `Presenter` handles only presentation logic and use cases but not business logic. (that's the job of the `Model` layer) The `Presenter` never imports `UIKit`, that's the job of the `View`.

* `Model`

The `Model` is basically all `Service` classes or alternatively specific `UseCase` implementations. The `Model` doesn't know about the `View` and the `View` doesn't know about the `Model`. It's the `Presenter`s job to glue them together.

## Why not MVVM?

MVVM is in fact not that much different to MVP. Find [here](https://medium.com/ios-os-x-development/ios-architecture-patterns-ecba4c38de52) a very good comparison. MVVP was used mostly by Microsoft for the WPF framework and later by Google's Angular. The point is - MVVM needs binding mechanisms which have to be supported out of the box to be really good. iOS misses these binding mechanisms because it was not created with this in mind. So you would need to use some 3rd party libraries to support this kind of architecture. Most developers choose RxSwift because it provides the best experience in this regard. The problem which RxSwift creates is that it highjacks basically your whole workflow. Starting reactive leads to using more and more reactive until your whole App bases on reactive programming. You will basically not use idiomatic iOS anymore. This may be good and acceptable for really advanced developers but for most people (especially beginners) this is way to much to grasp. And if you are one of this really advanced developers you would (most likely) not read this post right now. So my recommendation is to start with MVP like described here and maybe later - if you really feel the need to incorporate MVVM with RxSwift then just do it. From an architectural point of view MVVM brings the advantage that the viewmodel (the presenter in MVP) does not need to know anything about the view. So MVP's loose coupling goes one step further. This makes it easier to exchange the view layer with another. At least theoretically. MVP has basically the same advantage as long as you adhere to pure protocol oriented programming. And it will safe you from hours of debugging code which fails and has a long, long RxSwift callstack to analyse. But one big advantage of RxSwift is that it can be used perfectly to handle multiple concurrent streams - which is the case for example if multiple network requests need to be fired at the same time and then the responses handled in a smart way. You can't beat RxSwift here. Even Apple's DispatchGroups can not handle that easy and elegant like RxSwift. But RxSwift can be incorporated for this use-case really [easy](http://reactivex.io/documentation/operators/merge.html) into the Architecture described here. (without going fully reactive)

## Singletons

Meanwhile it should be clear to anyone that Singletons are (in most cases) an anti-pattern. But the problem with Singletons is not the fact that they assure that there is just one instance of a type available. The real problem is that they can be accessed globally over the typical: `mySingletonObject.sharedInstance.myFunc()`. In the SolidRock App Template this pattern is avoided by doing a check for possible multiple instances of shared dependencies during initialization of the class. This check is not done in Test Targets (UnitTest) so the class stays fully testable. There is no problem of static access anymore. In order to access such a created singleton it has to be passed by the `SharedDependencies` and injected on demand. This still does not solve the problem of shared mutable state - but it prepares the stage to handle this problem as well. In the best case all shared dependencies are immutable. If not - the state has to be synchronized, to avoid concurrency issues.

## Dependency Injection 

Every dependency which is needed by a module is injected by a `Builder` class. Usually dependencies can be created directly by the `Builder` itself. If shared dependencies are needed then also the `Builder` injects it into the module and additionally forwards the shared dependencies to the `Router`. The `Router`in turn can use the `SharedDependencies` to inject them into the next `Builder` and so on. In this way the `SharedDependencies` are passed from one module to the other without the need for global access to Singletons.

## Protocol oriented loose coupling

Every dependency is injected as a protocol, never the concrete implementation itself. In this way [loose coupling](https://en.wikipedia.org/wiki/Loose_coupling) is assured thru the whole App. 

## Testing

One of the advandages of loose coupling is that Mock classes can be injected during Unit Tests. Which in turn enables complete testability for presentation and business logic. The view classes itself are not unit tested, they are just a "dumb" UI layer with no logic at all. It's the job of the creators of those classes to test them. (in this case Apples UIKit team) Also the `Builder` and `Router` are not unit tested.

This approach leads to a possible code coverage of 100% at unit testing for all presentation logic and business logic.

![SolidRock](https://github.com/DarkoDamjanovic/SolidRock.AppTemplate.iOS/blob/master/codecoverage.png "SolidRock")

## Storyboards

Every viewcontroller is stored in an own storyboard. This prevents merge problems if multiple developers work on Storyboards. Each viewcontroller has a storyboard with the same name as the viewcontroller itself. That single viewcontroller in the storyboard is marked as "Is initial viewcontroller". In this way we can use a simple extension on `UIViewController` and `UIStoryboard` to instantiate every viewcontroller without even knowing the storyboard name or some ID in the storyboard.

    let viewController = MoviesViewController.storyboardInstance()

## Networking

Networking is done with NSURLSession - not with Alamofire. For most cases NSURLSession is perfectly fine and there is no need to introduce a third party library. But there is nothing wrong with Alamofire, if you are used to it - go on. However, what is more important, is to implement networking code only once and not repeat yourself all the time. That's why Networking is done with Swift Generics. New API endpoints are implemented in a few seconds by extending the WebService class with a few lines of code.

## Cocoapods

Cocoapods is the de-facto package manager for iOS. Most available 3rd party libraries are integrated into iOS projects over Cocoapods. There is no real need for 3rd party libraries in this small sample App but for the sake of demonstration the famous SDWebImage is included for downloading and caching images.

## Contributing

I am open for discussion, please post issues or add pull requests to this repository. I am happy to get new input and would like to improve this App template over time.






