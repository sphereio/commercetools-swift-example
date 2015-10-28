import Foundation
import Alamofire

class CTPOAuthToken {
    // Insert the credentials for your project here
    // On https://admin.sphere.io go to Developers > API Clients
    static let clientId = ""
    static let clientSecret = ""
    // Provide only the project name (without "manage_project:")
    static let project = ""

    // If a valid OAuth token was received from the server, it is cached here
    static var token: String?
    
    static var header: [String : String]? {
        if let tkn = token {
             return ["Authorization": "Bearer \(tkn)"]
        }
        else {
             return nil
        }
    }
}

// See http://dev.sphere.io/http-api-authorization.html
public func withHeader(callback: ([String : String]) -> Void) {
    if let h = CTPOAuthToken.header {
        // Get token from cache and call the callback instantly
        callback(h)
    }
    else if CTPOAuthToken.project == "" || CTPOAuthToken.clientId == "" || CTPOAuthToken.clientSecret == "" {
        print("You did not provide client credentials for your CTP project!")
        print("After you have created a project on https://admin.sphere.io, go to Developers > API Clients and copy the credentials")
        print("Insert them into the CTPOAuthToken class!")
        assertionFailure()
    }
    else if CTPOAuthToken.project.containsString("manage_project:") {
        print("Provide only the project name (without manage_project:) in the CTPOAuthToken class!")
        assertionFailure()
    }
    else {
        // Retrieve token from auth webservice
        let credentialData = "\(CTPOAuthToken.clientId):\(CTPOAuthToken.clientSecret)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        let headers = ["Authorization": "Basic \(base64Credentials)"]
        
        let scope = "manage_project:\(CTPOAuthToken.project)"
        
        Alamofire.request(.POST, "https://auth.sphere.io/oauth/token", headers: headers, parameters: ["grant_type": "client_credentials", "scope": scope])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success(let JSON):
                    if let accessToken = JSON["access_token"] as? String {
                        // Put token into cache
                        CTPOAuthToken.token = accessToken
                        // And use the header to call the callback
                        if let h = CTPOAuthToken.header {
                            callback(h)
                        }
                    }
                case .Failure:
                    print(response.debugDescription)
                }
                if let JSON = response.result.value {
                    if let accessToken = JSON["access_token"] as? String {
                        // Put token into cache
                        CTPOAuthToken.token = accessToken
                        // And use the header to call the callback
                        if let h = CTPOAuthToken.header {
                            callback(h)
                        }
                    }
                }
        }
    }
}

public func sphereGetRequest(endpoint: String, parameters: [String : AnyObject]? = nil, completionHandler: Alamofire.Response<AnyObject, NSError> -> Void) {
    withHeader { headers in
        Alamofire.request(.GET, "https://api.sphere.io/\(CTPOAuthToken.project)/\(endpoint)", headers: headers, parameters: parameters)
            .validate()
            .responseJSON { response in
                completionHandler(response)
        }
    }
}