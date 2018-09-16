# Movies app

This project uses CoreData as the persistence layer, all navigation was implemented on a UIViewCollection so as to avoid issues with performance, the UI is simple and clean so Slide to discover navigation was implemented. Most of the interface was created with code but some components were created using template files (xibs).

For networking and data access, Alamofire was required with CocoaPods as dependencies manager and the new JSONDecoder class is used to serialize JSON responses and avoid unnecessary document parsing.

Each class contains its own responsibility and goal.

<img src="preview.gif" width="300">
