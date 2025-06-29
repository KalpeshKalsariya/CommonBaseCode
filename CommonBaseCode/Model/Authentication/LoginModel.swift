//
//  LoginModel.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

struct LoginModel : Codable {
    let success : Bool?
    let accessToken : String?
    let tokenType : String?
    let scope : String?
    let errorMessage : String?

    enum CodingKeys: String, CodingKey {

        case success = "Success"
        case accessToken = "AccessToken"
        case tokenType = "TokenType"
        case scope = "Scope"
        case errorMessage = "ErrorMessage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        tokenType = try values.decodeIfPresent(String.self, forKey: .tokenType)
        scope = try values.decodeIfPresent(String.self, forKey: .scope)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
    }

}
