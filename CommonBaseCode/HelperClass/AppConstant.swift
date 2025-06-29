//
//  AppConstant.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

struct AppConstant {
    
    // MARK: - Colors used throughout the app
    struct Colors {
        static let toastErrorBG = #colorLiteral(red: 0.9725490196, green: 0.8431372549, blue: 0.8549019608, alpha: 1)
        static let toastSuccessBG = #colorLiteral(red: 0.831372549, green: 0.9294117647, blue: 0.8549019608, alpha: 1)
        static let toastErrorText = #colorLiteral(red: 0.4470588235, green: 0.1098039216, blue: 0.1411764706, alpha: 1)
        static let toastSuccessText = #colorLiteral(red: 0.08235294118, green: 0.3411764706, blue: 0.1411764706, alpha: 1)
    }
    
    //MARK: - Input Filed Validation messages shown to users
    struct InputFiledValidationMessage {
        struct Email {
            static let emptyEmail = LocalizedConstants.empty_validate_email.localized
            static let invalid = LocalizedConstants.invalid_email.localized
            static let short = LocalizedConstants.short_email.localized
            static let long = LocalizedConstants.long_email.localized
            static let requiredEmail = LocalizedConstants.required_email.localized
        }

        struct Password {
            static let emptyPassword = LocalizedConstants.empty_validate_password.localized
            static let short = LocalizedConstants.short_password.localized
            static let long = LocalizedConstants.long_password.localized
            static let weak = LocalizedConstants.error_invalid_password.localized
            static let requiredPassword = LocalizedConstants.required_password.localized
        }

        struct Username {
            static let emptyUsername = LocalizedConstants.empty_username.localized
            static let short = LocalizedConstants.short_username.localized
            static let long = LocalizedConstants.long_username.localized
            static let invalid = LocalizedConstants.invalid_username.localized
            static let requiredUsername = LocalizedConstants.required_username.localized
        }

        struct FullName {
            static let emptyFullName = LocalizedConstants.empty_fullname.localized
            static let short = LocalizedConstants.short_fullname.localized
            static let long = LocalizedConstants.long_fullname.localized
            static let invalid = LocalizedConstants.invalid_fullname.localized
            static let requiredFullName = LocalizedConstants.required_fullname.localized
        }

        struct Phone {
            static let emptyPhone = LocalizedConstants.empty_phone.localized
            static let invalid = LocalizedConstants.invalid_phone.localized
            static let short = LocalizedConstants.short_phone.localized
            static let long = LocalizedConstants.long_phone.localized
            static let requiredPhone = LocalizedConstants.required_phone.localized
        }

        struct Address {
            static let emptyAddress = LocalizedConstants.empty_address.localized
            static let short = LocalizedConstants.short_address.localized
            static let long = LocalizedConstants.long_address.localized
            static let requiredAddress = LocalizedConstants.required_address.localized
        }

        struct DateOfBirth {
            static let empty = LocalizedConstants.empty_dob.localized
            static let invalid = LocalizedConstants.invalid_dob.localized
            static let required = LocalizedConstants.required_dob.localized
        }

        struct CreditCard {
            static let empty = LocalizedConstants.empty_credit_card.localized
            static let invalid = LocalizedConstants.invalid_credit_card.localized
            static let required = LocalizedConstants.required_credit_card.localized
        }

        struct ExpiryDate {
            static let empty = LocalizedConstants.empty_expiry_date.localized
            static let invalid = LocalizedConstants.invalid_expiry_date.localized
            static let expired = LocalizedConstants.expired_expiry_date.localized
            static let required = LocalizedConstants.required_expiry_date.localized
        }

        struct CVV {
            static let empty = LocalizedConstants.empty_cvv.localized
            static let invalid = LocalizedConstants.invalid_cvv.localized
            static let required = LocalizedConstants.required_cvv.localized
        }

        struct ZipCodePostalCode {
            static let empty = LocalizedConstants.empty_zipcode.localized
            static let invalid = LocalizedConstants.invalid_zipcode.localized
            static let required = LocalizedConstants.required_zipcode.localized
        }

        struct SecurityQuestion {
            static let empty = LocalizedConstants.empty_security_question.localized
        }

        struct SecurityAnswer {
            static let empty = LocalizedConstants.empty_security_answer.localized
        }

        struct Location {
            static let empty = LocalizedConstants.empty_location.localized
            static let short = LocalizedConstants.short_location.localized
            static let long = LocalizedConstants.long_location.localized
            static let required = LocalizedConstants.required_location.localized
        }

        struct SelectLocation {
            static let empty = LocalizedConstants.empty_select_location.localized
            static let invalid = LocalizedConstants.invalid_select_location.localized
            static let required = LocalizedConstants.required_select_location.localized
        }

        struct UploadProfilePicture {
            static let empty = LocalizedConstants.empty_upload_profile_picture.localized
            static let invalid = LocalizedConstants.invalid_upload_profile_picture.localized
            static let format = LocalizedConstants.format_upload_profile_picture.localized
            static let size = LocalizedConstants.size_upload_profile_picture.localized
            static let required = LocalizedConstants.required_upload_profile_picture.localized
        }

        struct SelectProfilePicture {
            static let empty = LocalizedConstants.empty_select_profile_picture.localized
            static let invalid = LocalizedConstants.invalid_select_profile_picture.localized
            static let required = LocalizedConstants.required_select_profile_picture.localized
        }

        struct Age {
            static let empty = LocalizedConstants.empty_age.localized
            static let invalid = LocalizedConstants.invalid_age.localized
            static let low = LocalizedConstants.low_age.localized
            static let high = LocalizedConstants.high_age.localized
            static let required = LocalizedConstants.required_age.localized
        }

        struct SelectAge {
            static let empty = LocalizedConstants.empty_select_age.localized
            static let invalid = LocalizedConstants.invalid_select_age.localized
            static let required = LocalizedConstants.required_select_age.localized
        }

        struct Gender {
            static let empty = LocalizedConstants.empty_gender.localized
            static let invalid = LocalizedConstants.invalid_gender.localized
            static let required = LocalizedConstants.required_gender.localized
        }

        struct FirstName {
            static let empty = LocalizedConstants.empty_firstname.localized
            static let short = LocalizedConstants.short_firstname.localized
            static let long = LocalizedConstants.long_firstname.localized
            static let required = LocalizedConstants.required_firstname.localized
        }

        struct LastName {
            static let empty = LocalizedConstants.empty_lastname.localized
            static let short = LocalizedConstants.short_lastname.localized
            static let long = LocalizedConstants.long_lastname.localized
            static let required = LocalizedConstants.required_lastname.localized
        }

        struct MiddleName {
            static let empty = LocalizedConstants.empty_middlename.localized
            static let short = LocalizedConstants.short_middlename.localized
            static let long = LocalizedConstants.long_middlename.localized
            static let required = LocalizedConstants.required_middlename.localized
        }

        struct RetypePassword {
            static let empty = LocalizedConstants.empty_retype_password.localized
            static let mismatch = LocalizedConstants.mismatch_password.localized
            static let short = LocalizedConstants.short_retype_password.localized
            static let long = LocalizedConstants.long_retype_password.localized
            static let required = LocalizedConstants.required_retype_password.localized
        }

        struct Comments {
            static let empty = LocalizedConstants.empty_comment.localized
            static let short = LocalizedConstants.short_comment.localized
            static let long = LocalizedConstants.long_comment.localized
            static let required = LocalizedConstants.required_comment.localized
        }

        struct Description {
            static let empty = LocalizedConstants.empty_description.localized
            static let short = LocalizedConstants.short_description.localized
            static let long = LocalizedConstants.long_description.localized
            static let required = LocalizedConstants.required_description.localized
        }

        struct RadioButtons {
            static let required = LocalizedConstants.required_radio_button.localized
        }

        struct FileUpload {
            static let required = LocalizedConstants.required_file_upload.localized
            static let type = LocalizedConstants.type_file_upload.localized
            static let size = LocalizedConstants.size_file_upload.localized
        }

        struct TextArea {
            static let length = LocalizedConstants.length_text_area.localized
        }

        struct Logout {
            static let logoutConfirmation = LocalizedConstants.confirmation_logout.localized
        }

        struct DeleteItem {
            static let deleteItemConfirmation = LocalizedConstants.confirmation_delete_item.localized
        }

        struct DeleteAllItems {
            static let deleteAllItemsConfirmation = LocalizedConstants.confirmation_delete_all_items.localized
        }

        struct ClearCart {
            static let clearCartConfirmation = LocalizedConstants.confirmation_clear_cart.localized
        }

        struct Warnning {
            static let functionalityNotImplemented = LocalizedConstants.functionality_not_implemented.localized
        }
        
        static let passwordRecoveryDetails = LocalizedConstants.static_text_label_password_recovery.localized
        static let outofstock = LocalizedConstants.static_text_label_out_of_stock.localized
        static let in_stock = LocalizedConstants.static_text_label_in_stock.localized
    }
    
    // MARK: - Common server error messages with localization
    struct ServerErrorMessage {
        static let Status_400 = LocalizedConstants.server_error_bad_request_400.localized //"Bad Request:"
        static let Status_401 = LocalizedConstants.server_error_unauthorized_401.localized //"Unauthorized:"
        static let Status_403 = LocalizedConstants.server_error_forbidden_403.localized //"Forbidden:"
        static let Status_404 = LocalizedConstants.server_error_not_found_404.localized //"Not Found:"
        static let Status_405 = LocalizedConstants.server_error_method_not_allowed_405.localized //"Method Not Allowed:"
        static let Status_500 = LocalizedConstants.server_error_internal_server_500.localized //"Internal Server Error:"
        static let Status_501 = LocalizedConstants.server_error_not_implemented_501.localized // "Not Implemented:"
        static let Status_502 = LocalizedConstants.server_error_bad_gateway_502.localized //"Bad Gateway:"
        static let Status_503 = LocalizedConstants.server_error_service_unavailable_503.localized //"Service Unavailable:"
        static let Status_504 = LocalizedConstants.server_error_gateway_timeout_504.localized //"Gateway Timeout:"
        static let Unknown    = LocalizedConstants.server_error_unknown.localized //"Unknown Error:"
    }
    
    // MARK: - General static error messages
    struct staticErrorMessage {
        static let noDataFound = LocalizedConstants.static_text_label_no_data_found.localized
    }
    
    // MARK: - Internet connectivity error message
    struct InterNetErrorMessage {
        static let ConnectionNotFound = LocalizedConstants.error_internet_connection.localized
    }
    
    // MARK: - Keys for UserDefaults storage
    struct UserDefaultsKey {
        static let accessToken              = "accessToken"
        static let currentUserLogin         = "currentUserLogin"
    }
    
    // MARK: - Common confirmation messages for alerts
    struct AlertConfirmationMessage {
        static let logout                   = LocalizedConstants.confirmation_message_logout.localized
        static let clearData                = LocalizedConstants.confirmation_message_clear_data.localized
    }
    
    // MARK: - Common button titles for alerts
    struct AlertButtonTitle {
        static let yesButton                = LocalizedConstants.button_title_yes.localized
        static let noButton                 = LocalizedConstants.button_title_no.localized
        static let okButton                 = LocalizedConstants.button_title_ok.localized
        static let cancelButton             = LocalizedConstants.button_title_cancel.localized
    }
    
    // MARK: - Common date and time formats used across app
    struct DateFormat {
        static let k_yyyy_MM_dd_HH_mm_ss_dash                = "yyyy-MM-dd HH:mm:ss"
        static let k_yyyy_MM_dd_hh_mm_a_dash                 = "yyyy-MM-dd hh:mm a"
        static let k_yyyy_MM_dd_HH_mm_slash                  = "yyyy/MM/dd HH:mm:ss"
        static let k_yyyy_MM_dd_hh_mm_a_slash                = "yyyy/MM/dd hh:mm a"
        static let k_HH_mm_ss                                = "HH:mm:ss"
        static let k_hh_mm_a                                 = "hh:mm a"
        static let k_display_dateformate_slash               = "MM/dd/yyyy"
        static let k_display_dateformate_dash                = "YYYY-MM-dd"
        static let k_display_dateformate                     = "dd MMM, YYYY"
        static let k_date_formate                            = "dd"
        static let k_month_formate                           = "MM"
        static let k_year_formate                            = "yyyy"
    }
    
    // MARK: - Asset image names used in the app
    struct Images {
        static let ic_default_user_profile = "ic_default_user_profile"
    }
    
    // MARK: - Static label text used in UI
    struct TextStaticLabel {
        static let requiredLabel = LocalizedConstants.static_text_label_required.localized
    }
    
    // MARK: - Screen size properties
    struct ScreenSize {
        static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    // MARK: - Device type checks based on screen size
    struct DeviceType {
        static let IS_IPHONE_4_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone
        && ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone
        && ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6 = UIDevice.current.userInterfaceIdiom == .phone
        && ScreenSize.SCREEN_MAX_LENGTH == 667.0
        
        static let IS_IPHONE_6_OR_LESS = UIDevice.current.userInterfaceIdiom == .phone
        && ScreenSize.SCREEN_WIDTH <= 375.0
        
        static let IS_IPHONE_6P = UIDevice.current.userInterfaceIdiom == .phone
        && ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_PAD               = UIDevice.current.userInterfaceIdiom == .pad
        static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
        && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPAD_PRO = UIDevice.current.userInterfaceIdiom == .pad
        && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
        static let IS_IPHONE_X = UIDevice.current.userInterfaceIdiom == .phone
        && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    }
    
    // MARK: - Socket-related constants
    struct SocketKeys {
        
        static let socketURL = "Socket Base URL" // Set your socket base URL
        
        //Socket Event for emit & Receive message
        struct socketEvent {
            static let kActivity = "eventName" // Emit event
            static let kActivityReplay = "responseEventName" // Response event
        }
    }
    
    // MARK: - Local folder types used in file management
    struct LocalFolderType {
        static let files = "Files"
        static let images = "Images"
        static let videos = "Videos"
    }
    
    // MARK: - AWS S3 credentials and URLs
    struct AWS {
        static let accessKey                = "" // AWS Access Key
        static let secreatKey               = "" // AWS Secret Key
        static let signatureVersion         = "" // AWS Signature Version (e.g. v4)
        
        struct S3MainBucketUrl {
            static let kMainUrl = "https://amazonaws.com/" // AWS S3 main bucket URL
            static let kCloudFrontUrl = "https://cloudfront.net/" // AWS CloudFront URL (if used)
        }
        
    }
    
    // MARK: - API server base URL and endpoints
    struct ServerAPI {
        
        struct BaseURL {
            static let baseURL = "" // Base API URL
        }
        
        struct EndPoint {
            static let kLogin               =  "login" // Login API endpoint
        }
    }

}

// ISO 3166-1 alpha-2 two-letter country codes.
let isoToDigitCountryCodeDictionary: [String: String] = [
    "AX": "358",
    "AQ": "672",
    "AS": "1684",
    "AI": "1264",
    "AG": "1268",
    "IL": "972",
    "AF": "93",
    "AL": "355",
    "DZ": "213",
    "AD": "376",
    "AO": "244",
    "AR": "54",
    "AM": "374",
    "AW": "297",
    "AU": "61",
    "AT": "43",
    "AZ": "994",
    "BS": "1242",
    "BH": "973",
    "BD": "880",
    "BB": "1246",
    "BY": "375",
    "BE": "32",
    "BZ": "501",
    "BJ": "229",
    "BM": "1441",
    "BT": "975",
    "BA": "387",
    "BW": "267",
    "BR": "55",
    "IO": "246",
    "BG": "359",
    "BES": "599",
    "BF": "226",
    "BI": "257",
    "BQ": "599",
    "BV": "55",
    "KH": "855",
    "CM": "237",
    "CA": "1",
    "CV": "238",
    "CW": "599",
    "KY": "1345",
    "CF": "236",
    "TD": "235",
    "TF": "262",
    "CL": "56",
    "CN": "86",
    "CX": "61",
    "CO": "57",
    "KM": "269",
    "CG": "242",
    "CK": "682",
    "CR": "506",
    "HR": "385",
    "CU": "53",
    "CY": "357",
    "CZ": "420",
    "DK": "45",
    "DJ": "253",
    "DM": "1767",
    "DO": "1",
    "HM": "334",
    "EC": "593",
    "EG": "20",
    "SV": "503",
    "GQ": "240",
    "ER": "291",
    "EE": "372",
    "EH": "212",
    "ET": "251",
    "FO": "298",
    "FJ": "679",
    "FI": "358",
    "FR": "33",
    "GF": "594",
    "PF": "689",
    "GA": "241",
    "GM": "220",
    "GE": "995",
    "DE": "49",
    "GH": "233",
    "GI": "350",
    "GR": "30",
    "GL": "299",
    "GD": "1473",
    "GP": "590",
    "GU": "1671",
    "GT": "502",
    "GN": "224",
    "GW": "245",
    "GY": "592",
    "HT": "509",
    "HN": "504",
    "HU": "36",
    "IS": "354",
    "IN": "91",
    "ID": "62",
    "IQ": "964",
    "IE": "353",
    "IT": "39",
    "JM": "1876",
    "JP": "81",
    "JO": "962",
    "KZ": "7",
    "KE": "254",
    "KI": "686",
    "KW": "965",
    "KG": "996",
    "LV": "371",
    "LB": "961",
    "LS": "266",
    "LR": "231",
    "LI": "423",
    "LT": "370",
    "LU": "352",
    "MG": "261",
    "MW": "265",
    "MY": "60",
    "MV": "960",
    "ML": "223",
    "MT": "356",
    "MH": "692",
    "MQ": "596",
    "MR": "222",
    "MU": "230",
    "YT": "262",
    "MX": "52",
    "MC": "377",
    "MN": "976",
    "ME": "382",
    "MS": "1664",
    "MA": "212",
    "MM": "95",
    "NA": "264",
    "NR": "674",
    "NP": "977",
    "NL": "31",
    "AN": "599",
    "NC": "687",
    "NZ": "64",
    "NI": "505",
    "NE": "227",
    "NG": "234",
    "NU": "683",
    "NF": "672",
    "MP": "1670",
    "NO": "47",
    "OM": "968",
    "PK": "92",
    "PW": "680",
    "PA": "507",
    "PG": "675",
    "PY": "595",
    "PE": "51",
    "PH": "63",
    "PL": "48",
    "PT": "351",
    "PR": "1",
    "QA": "974",
    "RO": "40",
    "RW": "250",
    "WS": "685",
    "SM": "378",
    "SA": "966",
    "SN": "221",
    "RS": "381",
    "SC": "248",
    "SL": "232",
    "SG": "65",
    "SX": "1721",
    "SK": "421",
    "SI": "386",
    "SB": "677",
    "ZA": "27",
    "GS": "500",
    "ES": "34",
    "LK": "94",
    "SD": "249",
    "SR": "597",
    "SZ": "268",
    "SE": "46",
    "CH": "41",
    "TJ": "992",
    "TH": "66",
    "TG": "228",
    "TK": "690",
    "TO": "676",
    "TT": "1868",
    "TN": "216",
    "TR": "90",
    "TM": "993",
    "TC": "1649",
    "TV": "688",
    "UG": "256",
    "UA": "380",
    "AE": "971",
    "GB": "44",
    "US": "1",
    "UY": "598",
    "UZ": "998",
    "VU": "678",
    "WF": "681",
    "YE": "967",
    "ZM": "260",
    "ZW": "263",
    "BO": "591",
    "BN": "673",
    "CC": "61",
    "CD": "243",
    "CI": "225",
    "FK": "500",
    "GG": "44",
    "VA": "379",
    "HK": "852",
    "IR": "98",
    "IM": "44",
    "JE": "44",
    "KP": "850",
    "KR": "82",
    "LA": "856",
    "LY": "218",
    "MO": "853",
    "MK": "389",
    "FM": "691",
    "MD": "373",
    "MZ": "258",
    "PS": "970",
    "PN": "872",
    "RE": "262",
    "RU": "7",
    "BL": "590",
    "SH": "290",
    "KN": "1869",
    "LC": "1758",
    "MF": "590",
    "PM": "508",
    "VC": "1784",
    "ST": "239",
    "SO": "252",
    "SS": "211",
    "SJ": "47",
    "SY": "963",
    "TW": "886",
    "TZ": "255",
    "TL": "670",
    "UM": "1",
    "VE": "58",
    "VN": "84",
    "VG": "1284",
    "VI": "1340",
    "XK": "383"
]

