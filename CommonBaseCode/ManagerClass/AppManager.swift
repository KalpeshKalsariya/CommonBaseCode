//
//  AppManager.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import Foundation

class AppManager: NSObject {
    
    static let shared = AppManager()
    
    override private init() {
        
    }
    
    private var windowScene: UIWindowScene? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            return windowScene
        }
        return nil
    }
    
    private var window: UIWindow? {
        guard let windowScene = self.windowScene else { return nil }
        if #available(iOS 15.0, *) {
            return windowScene.keyWindow
        } else {
            // Fallback on earlier versions
            return windowScene.windows.first
        }
    }
    
    private var rootViewController : UIViewController {
        guard let window = self.window, let rootVC = window.rootViewController else { return  UIViewController() }
        return rootVC
    }
    
    ////
    ///  to get top most view controller in app
    func topViewController() -> UIViewController {
        return self.rootViewController.getTopViewController()
    }
    
    func setRootVC(withViewController controller: UIViewController) {
        guard let window = self.window else { return }
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }
}
