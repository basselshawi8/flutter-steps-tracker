# Step Counter Test Code 


# points done in the test:

Functional points accomplished:
1,2,3,4,5,6,7,8

Non Functional points
1,2,3 (clearn code TDD), 4,5,8

Software Requirements
1,3

To run the project no need to external files, just flutter pub get and it should run on both Android and iOS,
but the test is heavily test on Android



The architecture that the project follows is Clean Architecture TDD (Test Driven Design)

The structure is divided into 2 main parts
- Core
- Features 

## Core Section

The Core sections is divided into helper classes and Utilities, we will go through them one by one

- Common:
Common sections has the following classes:
  appConfig.dart which contains information about the applications that are shared across the app, the information
  includes os version, application name, platform (iOS, Android, Web), current language
  CoreStyle.dart which holds the application shared colors and fonts and common widgets like divider, text and spacers
  RouteGenerator.dart: the routing utility class that manages all the rote transition logic between screens in the application
  SharedPreference.dart: A singleton class that manages Crud operations on local storage
  Utils.dart: That holds shared utils functions like: lauchUrl, changer of testifieds (focus node), show toast, etc..
  Validators.dart: a class that contains regular expressions that validates textfields.
  
- Datasource:
RemoteDataSource.dart which is an abstract class that we can inherit in the data layer section of the project, and this class
  has request functions, that request a specific API method from the APIProvider
  
- Entities
BaseEntity.dart, which is the base entity class, that all entities objects in the project inherits its basic functionality. For data holders
  we have 2 different types in the project, (Entity, and Model), The model is what comes as a result of an API request, the content of 
  the model could change in the future depending on the backend and API responses, but the Entity is what we use in the presentation layer,
  and doesn't not change usually, there is a converter method between model and entity in the data layer, if the model changes we change the conversion 
  to maintain the entity's integrity, so the presentation layer in not affected in changes in the data layer.
  
- Errors
Has most of the Errors that the APIProvider could encounter, example BarRequest, ForbiddenError, TimeoutError, etc...
  
- Extensions 
folder contains extension methods on core dart classes, for example an extension on LatLng class that defined a method called distance to calculate
  the distance between 2 coordinates.
  
- Http 
APIUrl.dart contain base url of the backend, APIs urls, and all other kind of urls (media url)
  HttpMethod.dart which holds the methods we are using in the application (GET,POST,PATCH, etc..)
  ModelsFactory.dart the class that registers model converters (converts json to model)
  APIProviders: The core controller that sends API requests and uploads using Dio Networking Library 
  
- Localization
LocalizationProvider.dart which holds the logic for handling locals and changing between them.
  Translations.dart that holds the logic of translations in the app
  
- Models
BaseModel.dart which is an abstract basemodel that all models in the project inherits
  common models that we could encounter as API responses, for example BarRequestModel, EmptyResponseModel (204 no content), MessageModelResponse.dart, etc...
  
- Params 
BaseParam.dart which is an abstract class that all params classes inherits, params objects encapsulate the parameters send to APIs 
  whether they are form data, body json, or query parameters.
  NoParams class which is a class that we use if there is no params send to the backend, params has already defined cancelToken, which 
  handles the case if the user send a request to the server, and leaves the screen, cancle token will cancel the request.
  
- Repositories
Repository.dart which is an abstract class that all repository classes inherit, whether they are local or remote repository
  
- Results
result.dart which has 2 fields, data in case of success in response of datasource call, or error if error occurs
  
- UI
has common UI widgets that are usable across the app, like common error widgets, testifieds, toasts, etc...
  
- Usecases
UseCase.dart an abstract class the all usecases classes inherits, usecase servers as the brige between presentation and domain layer.
  
- Constants
constants.dart which holds all constants values like images names and other assets

## Feature sections

Any project in clean architecture could be divided into several features, for example in a restaurant app common features would be 
user management feature, restaurants feature, menu feature, etc...

In this starter app we have code demo for restaurants feature, we would dive deep into the feature to demonstrate the architecture.

-Data layer

Datasource folder which has the following:
IRestaurantsRemoteDataSource, which has an abstract class that inherits the base remote datasource class, and define the following Methods: getRestaurants, getRestaurantMenu,
the methods parameters are the GetMenuParam which is a BaseModel param, the return value is Future<Either<BaseError, RestaurantMenuModel>>

RestaurantsRemoteDataSource which implements IRestaurantsRemoteDataSource, the class calls the remotedatasource methods request or upload, and the response is 
used in (domain layer in repositories).

Datasource could be local not only remote, and it follows the same architecture as remote, but it gets the data from a local storage ex: shared preference.

Model Folder: which holds all the models of a specific feature, models have a method .toEntity, which transforms the model into an entity
that is used in the later discussed presentation layer

Params Folder: which holds the parameters that are used in datasource section also they could params for remote or local.

Repository Folder: which holds the implementation of a repository interface, for example here we have RestaurantsRepository which implements
 iRestaurantsRepository, this repo has the following methods: getRestaurants, getRestaurantMenu, repository call either a remote datasource, or a local 
datasource, repository is the link between domain layer and data layer.

- Domain Layer
Entity Folder, which holds all the entities in the feature.
  entities are used to show data in screens and widgets in the presentation layer.
  
Repository Folder, has the interface of the repository "iRestaurantsRepository"

UseCase Folder:
UseCases in clean architecture serves as single purpose method, in this example we have 2 usecase classes GetRestaurantMenuUseCase and GetRestaurantsUseCase,
these usecases calls a local or remote repository on the application logic demand, and pass the data to the presentation layer (BloC in the project)

- Presentation Layer

Bloc Folder:
we have Events, and states classes and files, for more information about BloC see a tutorial of BloC in the following video:
https://www.youtube.com/results?search_query=Bloc+Tutorial

RestaurantsBloc class that inherits a BloC Base Class, maps a received event, call the appropriate usecase, and return a state that either has data or an error,
bloc returns multiple states, first it returns initial, then waiting, if success returns a success state with data, if error returns 
an error state with error message, bloc is used inside screens and message, it's basically an inherited widgets of streams of events, that 
refreshes the UI.

Screen Folder:
the screens of the applications, each screen has a routeName static field, for use in routeGenerator

Widgets Folder:
The reusable widgets of a feature, they are small UI building blocks to keep the screen's code neat and simple, and it could be utilized accross the app.




## Other important applications classes

- main.dart which has the initializing code of the app 
- fireBase.dart which has the initializing and notifications handling code of the app.
- service_locator.dart which servers as dependency injection handler, we use this primarily to connect datasource, repository classes interfaces
and implementations
  
-app.dart the main application core widget, the root widget of this is multiproviders, which holds all the BlocProviders used in the application, holds also change notifiers.
the child of this widget is the MaterialAppWidget.







  
  
  