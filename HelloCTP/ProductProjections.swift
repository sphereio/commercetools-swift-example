import Foundation
import Alamofire

class ProductProjections : EndpointWithById {
    static let endpoint: String = "carts/"

    // See http://dev.sphere.io/http-api-projects-products-search.html
    static func search(parameters parameters: [String : AnyObject]? = nil, _ completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
        sphereGetRequest("product-projections/search", parameters: parameters, completionHandler: completionHandler)
    }
}