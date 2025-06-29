//
//  AppEnum.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

/// Enum to represent the type of media content
public enum MediaType: Int {
    case image = 0   // Represents image files
    case video = 1   // Represents video files
    case file  = 2   // Represents generic files (PDF, DOC, etc.)
}

/// Enum to represent basic API call status
public enum APIStatusCode: Int {
    case Success = 1  // API call was successful
    case Failure = 0  // API call failed
}

/// Enum for common HTTP status codes returned by the server
public enum ServerStatusCode: Int {
    case Success = 200              // OK: Request succeeded
    case BadRequest = 400           // Bad Request: Invalid syntax
    case Unauthorized = 401         // Unauthorized: Authentication required
    case Forbidden = 403            // Forbidden: Access denied
    case NotFound = 404             // Not Found: Resource does not exist
    case MethodNotAllowed = 405     // Method Not Allowed: HTTP method not supported
    case InternalServerError = 500  // Internal Server Error: Generic server error
    case ServiceUnavailable = 503   // Service Unavailable: Server temporarily unable to handle the request
    
    /// Localized user-friendly message for each server error
    var message: String {
        switch self {
        case .Success:
            return "" // No error message for success
        case .BadRequest:
            return AppConstant.ServerErrorMessage.Status_400
        case .Unauthorized:
            return AppConstant.ServerErrorMessage.Status_401
        case .Forbidden:
            return AppConstant.ServerErrorMessage.Status_403
        case .NotFound:
            return AppConstant.ServerErrorMessage.Status_404
        case .MethodNotAllowed:
            return AppConstant.ServerErrorMessage.Status_405
        case .InternalServerError:
            return AppConstant.ServerErrorMessage.Status_500
        case .ServiceUnavailable:
            return AppConstant.ServerErrorMessage.Status_503
        }
    }
}

/// Enum representing supported HTTP methods for API calls
enum HTTPMethod: String {
    case get    = "GET"     // Used to retrieve data from server
    case post   = "POST"    // Used to send data to the server
    case put    = "PUT"     // Used to update existing data on the server
    case delete = "DELETE"  // Used to delete data from the server
    // Extend this enum with more methods (e.g., PATCH, HEAD) if needed
}
