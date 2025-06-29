//
//  APIManager.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation
import Alamofire

// APIManager is a singleton class that manages API requests.
class APIManager {
    // Shared instance of APIManager.
    static let shared = APIManager()
    
    // Private initializer to ensure only one instance of APIManager is created.
    private init() {}
    
    // MARK: - Check for internet connection
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    /**
     This method is used to make Alamofire request with or without parameters.
     - Parameters:
     - url: URL of request
     - method: HTTPMethod of request
     - parameter: Parameter of request
     - success: Success closure of method
     - response: Response object of request
     - failure: Failure closure of method
     - error: Failure error
     - connectionFailed: Network connection faild closure of method
     - error: Network error
     */
    
    class func makeRequest(
        with url: String,
        method: Alamofire.HTTPMethod,
        parameter: [String: Any]? = nil,
        success: @escaping (_ response: Any) -> Void,
        failure: @escaping (_ error: String, _ errorCode: Int) -> Void,
        connectionFailed: @escaping (_ error: String) -> Void
    ) {
        // Check for internet connection
        guard isConnectedToNetwork() else {
            connectionFailed(AppConstant.InterNetErrorMessage.ConnectionNotFound)
            return
        }
        
        print("Request URL: \(url)")
        
        if let param = parameter,
           let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted),
           let paramString = String(data: data, encoding: .utf8) {
            print("Request Parameter: \(paramString)")
        }
        
        AF.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
            .responseData { response in
                
                switch response.result {
                case .success(let data):
                    let statusCode = response.response?.statusCode ?? 0
                    print("Response URL: \(url)\nServer Status Code: \(statusCode)\nServer Response: \n", data)
                    
                    if statusCode == ServerStatusCode.Success.rawValue {
                        // Attempt to parse JSON
                        if let responseData = try? JSONSerialization.jsonObject(with: data, options: []) {
                            /*if let responseJson = responseData as? JSONType,  // JSONType assumed to be [String: Any]
                               let jsonString = Utils.convertDictionaryToJsonString(dictionary: responseJson) {
                                print("Server Response JSON String: \(jsonString)")
                            }*/
                            
                            success(responseData)
                        } else {
                            failure("Invalid JSON Format", statusCode)
                        }
                    } else {
                        let errorMessage = self.errorMessage(forStatusCode: statusCode)
                        failure(errorMessage, statusCode)
                    }
                    
                case .failure(let error):
                    failure(error.localizedDescription, 500)
                }
            }
    }
    
    // MARK: - Error message helper
    private class func errorMessage(forStatusCode statusCode: Int) -> String {
        switch statusCode {
        case 400: return AppConstant.ConstantMessage.badRequest
        case 401: return AppConstant.ConstantMessage.unauthorized
        case 403: return AppConstant.ConstantMessage.forbidden
        case 404: return AppConstant.ConstantMessage.notFound
        case 405: return AppConstant.ConstantMessage.methodNotAllowed
        case 500: return AppConstant.ConstantMessage.internalServerError
        case 501: return AppConstant.ConstantMessage.notImplemented
        case 502: return AppConstant.ConstantMessage.badGateway
        case 503: return AppConstant.ConstantMessage.serviceUnavailable
        case 504: return AppConstant.ConstantMessage.gatewayTimeout
        default:  return AppConstant.ConstantMessage.unknownError
        }
    }
    
    
    // Function to parse error message from response data.
    private func parseErrorMessage(from data: Data) -> String? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let errorMessage = json["message"] as? String {
                    return errorMessage
                }
            } else if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]], jsonArray.count > 0 {
                // Handle array case (if needed)
                // For example, you could extract messages from each object in the array.
                // Replace the following line with your desired logic:
                return "Multiple error messages found in the array."
            }
        } catch {
            return nil
        }
        return nil
    }
    
}
