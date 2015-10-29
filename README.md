# Commercetools Platform Example with Swift

This Hello World project shows how to:
- [x] Connect to the [SPHERE.IO](http://dev.sphere.io/) API with OAuth2
- [x] Search and sort products
- [x] Create a cart
- [x] Put a product into a cart
- [x] Delete a cart

## Getting started
* `git clone` this repo
* Open `HelloCTP.xcodeproj` in XCode
* If you don't have a SPHERE.IO project yet, register at the [Merchant Center](https://admin.sphere.io/) and setup a project. If you add sample data, the app will work with that out of the box!
* In the [Merchant Center](https://admin.sphere.io/), go to the `Developers` section and select `API Clients`
* Copy the credentials into the top of the class `CTPOAuthToken` in `HelloCTP` > `CTPutils`.
* Now run the project and play around with it ;)

## How to use this as a starting point for your own project
* You can either fork this project or start from scratch and copy only the classes inside `CTPutils`.
* If you want to use a dependency manager like CocoaPods or Carthage, add [Alamofire](https://github.com/Alamofire/Alamofire).
* You may want to use a JSON library like [SwiftyJSON](https://github.com/lingoer/SwiftyJSON) or [something else](https://github.com/matteocrippa/awesome-swift#json).
