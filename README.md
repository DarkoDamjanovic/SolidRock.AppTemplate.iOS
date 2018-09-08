# SolidRock AppTemplate for iOS
This repository should serve as a starting point for new iOS Apps. Don't repeat yourself all the time. All themes are handled which are used by 99% of all Apps like Configuration, Networking, Logging, etc.. .

## Configuration

The App configures itself thru the `Info.plist` file. The `Info.plist` file has a special feature supported by Xcode to inject variables during compilation time. This variables can be set in the Build Settings of the project and then are later specified with the `$(MY_VARIABLE)` syntax in the `Info.plist`. The big advantage - the Build Settings variables can be set different for each build configuration like Debug, Release, etc... In this way it get's really easy for example to configure everything which is specific to the build configuration. For example API Base URL's, API Keys, etc..

## MVP - Model View Presenter architecture

The App uses the MVP (Model View Presenter) architecture pattern. Additionally a `Builder` and `Router` class is created. 

* `Builder`

   The `Builder` is used to create the module and to inject all needed dependencies.

* `Router`

   The `Router` handles all the navigation use-cases between views and passes the shared dependencies from one module into the other. In this way only the really needed dependencies are injected into the presenter and view. 

## Singletons

Meanwhile it should be clear to anyone that Singletons are (in most cases) an anti-pattern. But the problem with Singletons is not the fact that they assure that there is just one instance of a type available. The real problem is that they can be accessed globally over the typical mySingletonObject.sharedInstance.myFunc(). In the SolidRock App Template this pattern is avoided by deriving every class which needs to restrict itself to just one instance from the base class `Singleton`. This class has a required initializer which does a static check if just one instance of a class is available. Otherwise an assertion fails. This static check is not done in Test Targets (UnitTest, UITest) so the class stays fully testable. In order to access such a created singleton it has to be passed by the `SharedDependencies` and injected on demand. This still does not solve the problem of shared mutable state - but if prepares the stage to handle this problem as well. In the best case all shared dependencies are immutable. If not - the state has to be synchronized, to avoid concurrency issues.

## Dependency Injection 

Every dependency which is needed by a module is injected by a ´Builder´ class. Usually dependencies can be created directly by the `Builder` itself. If shared dependencies are needed then also the `Builder` injects it into the module and additionally passed the shared dependencies to the `Router` in turn can use the `SharedDependencies` to inject them into the next `Builder` and so on.  

## Protocol oriented loose coupling

Every dependency is injected as a protocol, never the concrete implementation itself. In this way loose coupling is assured thru the whole App. In this way e.g. Mock classes can be injected during Unit Tests. Which in turn enables complete testability for presentation and business logic. The view classes itself are not unit tested, but UI tested.








