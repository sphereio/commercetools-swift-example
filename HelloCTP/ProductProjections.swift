import Foundation
import Alamofire

class ProductProjections {
    // See http://dev.sphere.io/http-api-projects-products-search.html
    static func search(parameters parameters: [String : AnyObject]? = nil, _ completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
        sphereGetRequest("product-projections/search", parameters: parameters, completionHandler: completionHandler)
    }
    
    // See http://dev.sphere.io/http-api-projects-productProjections.html#product-projection-by-id
    static func byId(id: String, parameters: [String : AnyObject]? = nil, _ completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
        sphereGetRequest("product-projections/\(id)", completionHandler: completionHandler)
    }
}