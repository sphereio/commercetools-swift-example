# Commercetools Platform Example with Swift

This Hello World project shows how to:
- [x] Connect to the [SPHERE.IO](http://dev.sphere.io/) API with OAuth2
- [x] Search and sort products
- [x] Perform reference expansion
- [x] Create a cart
- [x] Put a product into a cart
- [x] Delete a cart

## Getting started
* `git clone` this repo
* Open `HelloCTP.xcodeproj` in XCode
* If you don't have a SPHERE.IO project yet, register at the [Merchant Center](https://admin.sphere.io/) and setup a project. If you add sample data, the app will work with that out of the box!
* In the [Merchant Center](https://admin.sphere.io/), go to the `Developers` section and select `API Clients`
* Copy the credentials into the top of the class `CTPOAuthToken` in `HelloCTP` > `CTPutils`
* Now run the project and play around with it ;)

## Understanding the example

### ProductTableViewController

The first VC that is shown fetches the products from the [search](http://dev.sphere.io/http-api-projects-products-search.html) endpoint. It simply displays the name of each product. It caches the products and on a segue passes on the selected product.

### ProductViewController

The second VC displays details of a product (name, category and price). It first displays the cached version, but in the background pulls the most recent version. If the user wants to add the product to the cart, it passes the product to the next VC.

### CartTableViewController

This VC displays the line items in the cart. It will look for an existing cartId in the `NSUserDefaults` or [create](http://dev.sphere.io/http-api-projects-carts.html#create-cart) a new cart. Afterwards it [adds](http://dev.sphere.io/http-api-projects-carts.html#add-line-item) the product to the cart. The API will either add a new line item or increase the count of an existing line item.

The VC can also [delete](http://dev.sphere.io/http-api-projects-carts.html#delete-cart) the whole cart.

### CTPOAuthToken

To use the SPHERE.IO API, we need to send an OAuth token in the header. The function `withHeader` will provide this header by either using a cached token or getting one from the API with the supplied credentials.

There are also helper functions for GET, POST and DELETE requests. [Alamofire](https://github.com/Alamofire/Alamofire) is used to send the requests and do some parsing on the response. On an error, they will print the error messages the SPHERE.IO API sends back.

### ProductProjections and Carts

Thin wrappers for accessing the methods of these endpoints. You probably want to write additional wrappers for other endpoints.

To learn more about working with the responses, have a look at the [Alamofire Response Handling](https://github.com/Alamofire/Alamofire/blob/master/README.md#response-handling) documentation. You can check whether the request was successful either via `if response.result.isSuccess` or with a switch `switch response.result {` and `case .Success(let JSON):`. With the `switch`, you can immediately bind the json, or you can access it via `response.result.value`.

## How to use this as a starting point for your own project
* You can either fork this project or start from scratch and copy only the classes inside `CTPutils`.
* If you want to use a dependency manager like CocoaPods or Carthage, add [Alamofire](https://github.com/Alamofire/Alamofire).
* You may want to use a JSON library like [SwiftyJSON](https://github.com/lingoer/SwiftyJSON) or [something else](https://github.com/matteocrippa/awesome-swift#json).
