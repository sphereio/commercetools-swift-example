import Foundation
import Alamofire

class Carts {
    // See http://dev.sphere.io/http-api-projects-carts.html#cart-by-id
    static func byId(id: String, parameters: [String : AnyObject]? = nil, _ completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
        sphereGetRequest("carts/\(id)", parameters: parameters, completionHandler: completionHandler)
    }
    
    // See http://dev.sphere.io/http-api-projects-carts.html#create-cart
    static func create(json: [String: AnyObject], _ completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
        spherePostRequest("carts/", parameters: json, completionHandler: completionHandler)
    }
    
    // See http://dev.sphere.io/http-api-projects-carts.html#update-cart
    static func update(id: String, version: Int, actions: [[String: AnyObject]], _ completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
        let json: [String : AnyObject] = [
            "version": version,
            "actions": actions
        ]
        spherePostRequest("carts/\(id)", parameters: json, completionHandler: completionHandler)
    }
    
    // See http://dev.sphere.io/http-api-projects-carts.html#delete-cart
    static func delete(id: String, version: Int, _ completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
        let parameters: [String : AnyObject] = [
            "version": version
        ]
        sphereDeleteRequest("carts/\(id)", parameters: parameters, completionHandler: completionHandler)
    }
}