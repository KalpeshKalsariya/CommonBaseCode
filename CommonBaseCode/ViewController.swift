//
//  ViewController.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import UIKit

class ViewController: UIViewController {

    lazy var arrMedia: [MediaObject] = {
        return []
    }()
    
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.callLoginAPI()
        
        /**
         This method is used to check socket connection
         - check socket connection: if connection exists then send data to server
         - connect socket: send connection request to server if socket is connected then send data to server
         */
        
        /*if SocketManager.shared.checkConnection() {
            Utils.sendSocketEmitData(socketID: "your stored Socket Id", screenName: "\(self.classForCoder)")
        }
        else {
            SocketManager.shared.connectSocket { isSuccess, socketID in
                if isSuccess {
                    Utils.sendSocketEmitData(socketID: "your stored Socket Id", screenName: "\(self.classForCoder)")
                }
            }
        }*/
        
        /**
         This method is used to upload Media to S3 Bucket.
         - user-profile-image: folder of your s3bucket
         - once upload sucessfully then received sucess respose with key append your s3 bucket base url
         */
        /*var objMedia: MediaObject?
        
        let name = objMedia?.bucketName ?? ""
        let key = "user-profile-image/\(objMedia?.key ?? "")" //user-profile-image: folder of your s3bucket
        let image = objMedia?.image ?? UIImage()
        
        AWSManager.uploadMediaToS3Bucket(isForProfile: true, bucketName: name, mediaKey: key, image: image, fileURL: objMedia?.url, type: .image) { isSuccess in
            
            //user-profile-image: folder of your s3bucket
            print("/user-profile-image/\(objMedia?.key ?? "")".appendS3BaseURL())
            
        } failure: { error in
            self.showToast(message: "Failed to upload media, please try again!", isSuccess: false)
            objMedia = nil
        } progressBlock: { progress in
            print(progress)
            
        }*/
        
        /**
         This method is used to dowload File.
         - check file exist or not
         - download dile asyncronous
         */
        
        /*if self.arrMedia.count > 0 {
            let obj = self.arrMedia[0]
            if FileDownloader.checkIfFileExists(mediaObj: obj) {
                self.showToast(message: "File already exists!", isSuccess: false)
            }
            else {
                self.showToast(message: "Media downloading started, It will be saved shortly.", isSuccess: true)
                FileDownloader.loadFileAsync(mediaObj: obj) { message, error in
                    DispatchQueue.main.async {
                        let topVC = AppManager.shared.topViewController()
                        if error != nil {
                            topVC.showToast(message: message, isSuccess: false)
                        }
                    }
                }
            }
        }*/
    }


}

//API call
extension ViewController {
    func callLoginAPI() {
        var params : JSONType = JSONType()
        params[LoginParameterKey.email.rawValue] = ""
        params[LoginParameterKey.password.rawValue] = ""
        
        self.viewModel.callAPIToLoginInStore(params: params) { (isSuccess, message) in
            if isSuccess {
                //navigate to dashboard screen or as per your functionality
//                if let vc = R.storyboard.main.homeVC() {
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
            }
        } failure: { error in
            self.showToast(message: error, isSuccess: false)
        }
    }
}
