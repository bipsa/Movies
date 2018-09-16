# Movies app

This project uses CoreData as the persistence layer, all navigation was implemented on a UIViewCollection so as to avoid issues with performance, the UI is simple and clean so Slide to discover navigation was implemented. Most of the interface was created with code but some components were created using template files (xibs).

For networking and data access, Alamofire was required with CocoaPods as dependencies manager and the new JSONDecoder class is used to serialize JSON responses and avoid unnecessary document parsing.

Each class contains its own responsibility and goal.

#### ContentNavigationController: 
The application only has one controller, this class contains the main initial code logic, there are not many responsibilities assigned to this class, only loading the initial data and the main navigation

#### SwipingNavigation: 
Custom class to deal with sliding navigation. This class reacts to MoviesUpdated event in order to show the specific content to the user.

#### TheMovieDB: 
This class contains all API calls, extends from Api class, this was done this way just in case other endpoints were required or other movie service providers.

#### NSManagedObject+Horn: 
This extension centralize all core data interactions.

<img src="preview.gif" width="300">


#### En qué consiste el principio de responsabilidad única? Cuál es su propósito?
El principio de responsabilidad única establece que cada clase y o función tiene un único propósito identificable. Como práctica en trabajo en grupo es un buen método para mantener un código limpio y ordenado pero este depende del tipo de arquitectura de Software que se realice y así evitar sobre-ingeniería ó modelos de comunicación complejos.


### Qué características tiene, según su opinión, un “buen” código o código limpio
Evitar repetir código y sobre dimensionar funcionalidad complejiza el proceso de mantenibilidad, este es un tema donde se pueden encontrar una gran variedad de respuestas, para mi un buen código es aquel que pueda entender y mantener, independientemente del estilo ó lenguaje de programación. Si bien hay buenas prácticas que se pueden seguir, todos los proyectos y programadores tienen una forma de hacer las cosas. 
