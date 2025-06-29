//
//  DataManager.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

let kLanguageCode = "languageCode"

struct DataManager {
    
    static var shared = DataManager()
    
    var sourceLanguageCodeForTranslation: String = "en"
    
    func getCurrentLanguageCode() -> String {
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier ?? sourceLanguageCodeForTranslation
        } else {
            return Locale.current.languageCode ?? sourceLanguageCodeForTranslation
        }
    }
    
    func setCurrentLanguage(code: String) {
        UserDefaults.standard.setValue(code, forKey: kLanguageCode)
        UserDefaults.standard.synchronize()
    }
}

extension Bundle {
    var releaseVersionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildVersionNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
}
