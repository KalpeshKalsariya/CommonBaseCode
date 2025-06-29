//
//  LocalizedConstants.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

enum LocalizedConstants: String {
    // Server errors
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

    // General
    case error_internet_connection
    case confirmation_message_logout
    case confirmation_message_clear_data
    case button_title_yes
    case button_title_no
    case button_title_ok
    case button_title_cancel
    case static_text_label_required
    case static_text_label_no_data_found
    case static_text_label_password_recovery
    case static_text_label_out_of_stock
    case static_text_label_in_stock
    
    // Email
    case empty_validate_email
    case invalid_email
    case short_email
    case long_email
    case required_email

    // Password
    case empty_validate_password
    case short_password
    case long_password
    case error_invalid_password
    case required_password

    // Retype Password
    case empty_retype_password
    case mismatch_password
    case short_retype_password
    case long_retype_password
    case required_retype_password

    // Username
    case empty_username
    case short_username
    case long_username
    case invalid_username
    case required_username

    // Full Name
    case empty_fullname
    case short_fullname
    case long_fullname
    case invalid_fullname
    case required_fullname

    // First Name
    case empty_firstname
    case short_firstname
    case long_firstname
    case required_firstname

    // Last Name
    case empty_lastname
    case short_lastname
    case long_lastname
    case required_lastname

    // Middle Name
    case empty_middlename
    case short_middlename
    case long_middlename
    case required_middlename

    // Phone
    case empty_phone
    case invalid_phone
    case short_phone
    case long_phone
    case required_phone

    // Address
    case empty_address
    case short_address
    case long_address
    case required_address

    // Date of Birth
    case empty_dob
    case invalid_dob
    case required_dob

    // Credit Card
    case empty_credit_card
    case invalid_credit_card
    case required_credit_card

    // Expiry Date
    case empty_expiry_date
    case invalid_expiry_date
    case expired_expiry_date
    case required_expiry_date

    // CVV
    case empty_cvv
    case invalid_cvv
    case required_cvv

    // Zip Code
    case empty_zipcode
    case invalid_zipcode
    case required_zipcode

    // Security
    case empty_security_question
    case empty_security_answer

    // Location
    case empty_location
    case short_location
    case long_location
    case required_location

    // Select Location
    case empty_select_location
    case invalid_select_location
    case required_select_location

    // Profile Picture Upload
    case empty_upload_profile_picture
    case invalid_upload_profile_picture
    case format_upload_profile_picture
    case size_upload_profile_picture
    case required_upload_profile_picture

    // Profile Picture Selection
    case empty_select_profile_picture
    case invalid_select_profile_picture
    case required_select_profile_picture

    // Age
    case empty_age
    case invalid_age
    case low_age
    case high_age
    case required_age

    // Select Age
    case empty_select_age
    case invalid_select_age
    case required_select_age

    // Gender
    case empty_gender
    case invalid_gender
    case required_gender

    // Comments
    case empty_comment
    case short_comment
    case long_comment
    case required_comment

    // Description
    case empty_description
    case short_description
    case long_description
    case required_description

    // Radio Button
    case required_radio_button

    // File Upload
    case required_file_upload
    case type_file_upload
    case size_file_upload

    // Text Area
    case length_text_area

    // Logout, Delete, Cart
    case confirmation_logout
    case confirmation_delete_item
    case confirmation_delete_all_items
    case confirmation_clear_cart

    // Warning
    case functionality_not_implemented
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
