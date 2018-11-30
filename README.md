![SolidRock](https://github.com/DarkoDamjanovic/SolidRock.AppTemplate.iOS/blob/master/solidrock.jpg "SolidRock")

# SolidRock App Template for iOS

This repository should give you a rock solid foundation for new iOS Apps. All themes are handled which are used by 99% of all Apps like Configuration, Networking, Logging, Storyboard handling, etc.. . If you are a beginner iOS developer then you can use this if you are not sure how to structure your App. If you are an advanced iOS developer then let be inspired - maybe you will find something which complements you current workflow.

# Mobile App Architecture

Mobile Apps have meanwhile grown from small tools to often huge pieces of software. In no way different in complexity to full blown desktop apps or even backend software. It is now more important than ever to stick to a clean architecture to assure:

- low maintenance cost (75% of an App lifecycle is maintenance)
- low extendability risk
- easiness to jump into a project as a new developer and continue the work of others 
- full testability

There are many different approaches to keep an App architecture clean. Let us first discuss some of them to get an overview.

# MVC

MVC (Model-View-Controller) is the grand daddy of App architecture. This architecture pattern is used since the 80’s and is still the de-facto-standard of most Apps. MVC consists mainly of three layers. The "Model", the "View" and the "Controller". The controller updates the model and the view get’s the needed “raw” data to display it. (either active or passive, dependent on the used approach) But who is in charge of how the data has to be displayed? Is it the view or the model? Often this unclarity leads to a view which does UI logic. Which in turn creates a view layer which can’t be unit tested correctly. The other approach is to let the model handle the UI logic. But this also leads to a mixture of concerns, in that case business logic and UI logic get’s mixed. This mixture finally can lead to a state which can’t be fixed but needs a refactoring of the whole App.

# MVVM

Another approach is MVVM (Model-View-ViewModel). In the MVVM architecture the view is completely decoupled from the model. The concerns of each layer are really separated. The view model handles all UI logic and the model the business logic. The view owns the view model but the view model does not know anything about the view. Communication to the view from the view model is done thru bindings. This clear separation of concerns leads to higher modularity and in turn simplifies development and maintenance. 

One disadvantage of MVVM is that it needs really good supported binding mechanisms. iOS does not support this natively although it is possible to use (or misuse) some of the native iOS API’s for this. (such as Key-Value-Coding, NSNotification, etc..) Most developer which choose MVVM as an architecture pattern have to come up with a 3rd party solution for data binding. And most choose Rx (Reactive Extensions) for this. But Rx was not designed for this, Rx is a total different approach  to programming and has his own pitfalls.

Android supports native view binding since 2015. The problem with the Android approach is that it enables presentation logic to be defined in the view layer (.xml files). Which again facilitates mixture of concerns and leads to a not testable and hard to maintain codebase.


## MVP - Model View Presenter architecture

MVP (Model-View-Presenter) is an Architecture pattern which is very similar to MVVM but with one major difference. The presenter (which is the view model in MVVM) updates the view directly without any intermediate binding mechanism. Otherwise the two are the same and provide the same features. 

After working with many different architecture approaches for years I have finally arrived to the conclusion that MVP is the most appropriate architecture style for mobile applications. It provides all the advantages of MVVP without the disadvantages. And it is not dependent on any 3rd party libraries.

Therefore the rest of this document will use MVP as the architecture style of choice.


# Solid Rock's MVP

SolidRock App Template uses the MVP (Model View Presenter) architecture pattern. Additionally a `Builder` and `Router` classes are created. This idea originated from the "Viper" architecture pattern. (https://www.objc.io/issues/13-architecture/viper/)

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

# Loose coupling

https://en.wikipedia.org/wiki/Loose_coupling

Another important point to consider is the modularity and the connectedness of modules in the Application. Functional responsibilities have to be grouped in modules and those modules need to interact with each other by defined interfaces - not by creating strong dependencies between them. But he same principle applies also between the more granular components (mostly classes) in modules.

Both Android and iOS support the concept of interfaces. In iOS they are called "protocols". This is the main means to ensure loose coupling. There are also other means like e.g. notification systems, but we will focus now only on interfaces.

By declaring all communication and dependencies between classes and modules of an App as interfaces we can prevent strong coupling between them. This in turn enables:

- higher reuseability
- easier extendability
- easier maintainability
- high testability

# Inversion of control

Another very important point to consider is the inversion of control principle, implemented mostly as dependency injection. In iOS inversion of control can also be implemented by the "delegate" pattern, but to keep both Mobile platforms in sync regarding architecture decisions we will focus on dependency injection. (most Mobile Projects are implemented both on Android and iOS and it's generally a good idea to keep the same architecture decisions on both platforms)

## Dependency Injection 

See: https://en.wikipedia.org/wiki/Dependency_injection

In this template every dependency which is needed by a module is injected by a `Builder` class. Usually dependencies can be created directly by the `Builder` itself. If shared dependencies are needed then also the `Builder` injects it into the module and additionally forwards the shared dependencies to the `Router`. The `Router`in turn can use the `SharedDependencies` to inject them into the next `Builder` and so on. In this way the `SharedDependencies` are passed from one module to the other without the need for global access to Singletons.

## Singletons

By sticking to the principles of loose coupling with the help of dependency injection we can completely give up the Singleton design pattern. Singletons are problematic in many ways. Because they are globally reachable with "static" access it is very easy to run into all the problems of shared mutable state. This is especially problematic with concurrent access to Singletons. Because multiple threads can access the same mutable data at the same time all the problems of concurrency like deadlocks and race conditions can come up. Apart from this Singletons are really hard to unit test, because their global state violates the rule of unit testing that every test should be independent of any other test. Therefore we are going to avoid Singletons as much as possible. (we can't avoid them completely because many 3rd party frameworks come with Singletons included)

# Shared Dependencies

But how we are going to solve the problems that some modules or services of the App are used by many others at the same time? We need a concept of how dependencies of classed and/or modules can be shared. So let's start by a simple class called `SharedDependencies`. All classes which should be instantiated just once are in `SharedDependencies`. In order to access such a created singleton it has to be passed by the `SharedDependencies` and injected on demand. This still does not solve the problem of shared mutable state - but it prepares the stage to handle this problem as well. In the best case all shared dependencies are immutable. If not - the state has to be synchronized, to avoid concurrency issues.

The `SharedDependencies` class is created at startup and all dependencies which will be shared thru the lifetime of the Application are created inside this class. So this class also has the knowledge of how the dependency tree has to be created. Then one single instance is created on App startup and this single instance is passed from view to view as referenced class. In this way we still have to advantage that only one instance is created of a class but can share this instance thru the whole App. And this single("ton") instance still stays fully testable during unit testing. One has to keep in mind that the problem of share mutable state is not solved completely by this approach. So it's strongly recommended that class instances in the `SharedDependencies` are used always from the same thread or in another way synchronised.

## Testing

One of the advandages of loose coupling and dependency injection is that Mock classes can be injected during Unit Tests. Which in turn enables complete testability for presentation and business logic. The view classes itself are not unit tested, they are just a "dumb" UI layer with no logic at all. It's the job of the creators of those classes to test them. (in this case Apples UIKit team) Also the `Builder` and `Router` are not unit tested but are implicitely tested on UI testing.

This approach leads to a possible code coverage of 100% at unit testing for all presentation logic and business logic.

![SolidRock](https://github.com/DarkoDamjanovic/SolidRock.AppTemplate.iOS/blob/master/codecoverage.png "SolidRock")

## Storyboards

In this template every viewcontroller is stored in an own storyboard. This prevents merge problems if multiple developers work on Storyboards. Additionally it improves performance because loading even a singel UIViewController from a storyboard means loading at first the whole storyboard into memory. Each viewcontroller has a storyboard with the same name as the viewcontroller itself. That single viewcontroller in the storyboard is marked as "Is initial viewcontroller". In this way we can use a simple extension on `UIViewController` and `UIStoryboard` to instantiate every viewcontroller without even knowing the storyboard name or some ID in the storyboard.

    let viewController = MoviesViewController.storyboardInstance()

## Networking

Networking is done with NSURLSession - not with Alamofire. For most cases NSURLSession is perfectly fine and there is no need to introduce a third party library. But there is nothing wrong with Alamofire, if you are used to it - go on. However, what is more important, is to implement networking code only once and not repeat yourself all the time. That's why Networking is done with Swift Generics. New API endpoints are implemented in a few seconds by extending the WebService class with a few lines of code.

## Cocoapods

Cocoapods is the de-facto package manager for iOS. Most available 3rd party libraries are integrated into iOS projects over Cocoapods. There is no real need for 3rd party libraries in this small sample App but for the sake of demonstration the famous SDWebImage is included for downloading and caching images.

## Contributing

I am open for discussion, please post issues or add pull requests to this repository. I am happy to get new input and would like to improve this App template over time.






