//
//  LoginViewModel.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

public enum LoginParameterKey: String {
    case email = "Email"
    case password = "Password"
    case errorMessage = "ErrorMessage"
    case success = "Success"
    case accessToken = "AccessToken"
}

class LoginViewModel {
    // Define properties to hold the data fetched from the API
    private lazy var loadingView: ActivityLoaderView = {
        return ActivityLoaderView()
    }()
    
    // Create a function to make the API call
    func callAPIToLoginInStore(params: JSONType, showLoader:Bool = true, success withResponse: @escaping (Bool, String) -> (), failure: @escaping (_ error: String) -> Void) {
        
        if showLoader {
            //Show Loader if needed
            DispatchQueue.main.async {
                AppManager.shared.topViewController().view.addSubview(self.loadingView)
            }
        }
        let apiString = "\(AppConstant.ServerAPI.BaseURL.baseURL)\(AppConstant.ServerAPI.EndPoint.kLogin)"
        APIManager.makeRequest(with: apiString, method: .post, parameter: params) { response in
            
            if showLoader {
                //Hide Loader after API Calling
                DispatchQueue.main.async {
                    self.loadingView.removeFromSuperview()
                }
            }
            
            let dict = response as? JSONType ?? [:]
            let message = dict[LoginParameterKey.errorMessage.rawValue] as? String ?? ""
            let statusCode = dict[LoginParameterKey.success.rawValue] as? Int ?? 0
            let isSuccess = statusCode == APIStatusCode.Success.rawValue
            if isSuccess {
                if let currentAccessToken = dict[LoginParameterKey.accessToken.rawValue] as? String, !currentAccessToken.isEmpty {
                    Utils.setStringForKey(currentAccessToken, key: AppConstant.UserDefaultsKey.accessToken)
                    Utils.setBoolForKey(true, key: AppConstant.UserDefaultsKey.currentUserLogin)
                    withResponse(isSuccess, message)
                }
            } else {
                failure(message)
            }
            
        } failure: { error, errorcode in
            if showLoader {
                //Hide Loader after API Calling
                DispatchQueue.main.async {
                    self.loadingView.removeFromSuperview()
                }
            }
            failure(error)
        } connectionFailed: { error in
            if showLoader {
                //Hide Loader after API Calling
                DispatchQueue.main.async {
                    self.loadingView.removeFromSuperview()
                }
            }
            failure(error)
        }
    }
}
