//
//  LocalizedConstants.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

enum LocalizedConstants: String {
    
    case server_error_bad_request_400
    case server_error_unauthorized_401
    case server_error_forbidden_403
    case server_error_not_found_404
    case server_error_method_not_allowed_405
    case server_error_internal_server_500
    case server_error_not_implemented_501
    case server_error_bad_gateway_502
    case server_error_service_unavailable_503
    case server_error_gateway_timeout_504
    case server_error_unknown
    case error_internet_connection
    case confirmation_message_logout
    case confirmation_message_clear_data
    case button_title_yes
    case button_title_no
    case button_title_ok
    case button_title_cancel
    case static_text_label_required
    case static_text_label_no_data_found
    case empty_validate_email
    case invalid_email
    case empty_validate_password
    case error_invalid_password
    case static_text_label_password_recovery
    case static_text_label_out_of_stock
    case static_text_label_in_stock
    
}


extension LocalizedConstants {
    var localized: String {
        return NSLocalizedString(self.rawValue, tableName: nil, bundle: bundle(), value: "", comment: "")
    }
    
    private func bundle() -> Bundle {
        let code = DataManager.shared.getCurrentLanguageCode()
       
        var path = Bundle.main.path(forResource: code, ofType: "lproj")
        if path == nil {
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
        }
        let bundle = Bundle(path: path!)
        return bundle!
    }
}
