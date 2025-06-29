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
    
    var isFirstTimeGetCountry: Bool = true
    @IBOutlet weak var imgCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblCountryTitle: UILabel!
    @IBOutlet weak var txtPhoneCode: UITextField!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewPhoneBorder: UIView!
    @IBOutlet weak var constraintCountryCodeWidth: NSLayoutConstraint!
    
    var currentCountry: Country? {
        guard let countryCode = Locale.current.region?.identifier else {
            return nil
        }
        return Country(countryCode: countryCode)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.callLoginAPI()
        
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
        
        self.setCurrentCountry()
    }


    private func setCurrentCountry() {
        lblCountryCode.text = currentCountry?.dialingCode
        let font = UIFont.systemFont(ofSize: AppConstant.DeviceType.IS_PAD ? 18.0 : 16.0)
        self.lblCountryCode.font = font
        self.txtPhoneCode.font = font
        let extrawidth = AppConstant.DeviceType.IS_PAD ? 10 : 0
        let cellWidth = (currentCountry?.dialingCode?.textWidth(font:font) ?? 0.00) + CGFloat(extrawidth)
        constraintCountryCodeWidth.constant = cellWidth
        
        #if SWIFT_PACKAGE
            let bundle = Bundle.module
        #else
            let bundle = Bundle(for: Country.self)
        #endif
        
        let flagImg = UIImage(named: currentCountry!.imagePath, in: bundle, compatibleWith: nil)
        
        imgCountryFlag.image = flagImg
        imgCountryFlag.isHidden = false
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

//Button Action
extension ViewController {
    @IBAction func btnCountryCodeSelectionAction(_ sender: UIButton) {
        presentCountryPickerScene(withSelectionControlEnabled: false)
    }
}

//Present Country Picker Controller
extension ViewController {
    
    /// Dynamically presents country picker scene with an option of including `Selection Control`.
    ///
    /// By default, invoking this function without defining `selectionControlEnabled` parameter. Its set to `True`
    /// unless otherwise and the `Selection Control` will be included into the list view.
    ///
    /// - Parameter selectionControlEnabled: Section Control State. By default its set to `True` unless otherwise.
    
    func presentCountryPickerScene(withSelectionControlEnabled selectionControlEnabled: Bool = true) {
        switch selectionControlEnabled {
        case true:
            // Present country picker with `Section Control` enabled
            CountryPickerWithSectionViewController.presentController(on: self, configuration: { countryController in
                countryController.configuration.flagStyle = .circular
                countryController.configuration.isCountryFlagHidden = false
                countryController.configuration.isCountryDialHidden = false
                countryController.configuration.labelFont = UIFont.boldSystemFont(ofSize: 16.0)
                countryController.configuration.detailFont = UIFont.boldSystemFont(ofSize: 14.0)
                if isFirstTimeGetCountry {
                    countryController.manager.lastCountrySelected = currentCountry//onSelectCountry?(currentCountry!)
                }
//                countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]

            }) { [weak self] country in
                
                guard let self = self else { return }
                self.imgCountryFlag.isHidden = false
                self.imgCountryFlag.image = country.flag
                self.lblCountryCode.text = country.dialingCode
                self.isFirstTimeGetCountry = false
                
                let font = UIFont.systemFont(ofSize: AppConstant.DeviceType.IS_PAD ? 18.0 : 16.0)
                let extrawidth = AppConstant.DeviceType.IS_PAD ? 10 : 0
                let cellWidth = (country.dialingCode?.textWidth(font:font) ?? 0.00) + CGFloat(extrawidth)
                self.constraintCountryCodeWidth.constant = cellWidth
            }
            
        case false:
            // Present country picker without `Section Control` enabled
            CountryPickerController.presentController(on: self, configuration: { countryController in
                countryController.configuration.flagStyle = .corner
                countryController.configuration.isCountryFlagHidden = false
                countryController.configuration.isCountryDialHidden = false
                countryController.configuration.labelFont = UIFont.boldSystemFont(ofSize: 16.0)
                countryController.configuration.detailFont = UIFont.boldSystemFont(ofSize: 14.0)
                if isFirstTimeGetCountry {
                    countryController.manager.lastCountrySelected = currentCountry//onSelectCountry?(currentCountry!)
                }
//                countryController.favoriteCountriesLocaleIdentifiers = ["IN", "US"]
                
            }) { [weak self] country in
                
                guard let self = self else { return }
                self.imgCountryFlag.isHidden = false
                self.imgCountryFlag.image = country.flag
                self.lblCountryCode.text = country.dialingCode
                self.isFirstTimeGetCountry = false
                
                let font = UIFont.systemFont(ofSize: AppConstant.DeviceType.IS_PAD ? 18.0 : 16.0)
                let extrawidth = AppConstant.DeviceType.IS_PAD ? 10 : 5
                let cellWidth = (country.dialingCode?.textWidth(font:font) ?? 0.00) + CGFloat(extrawidth)
                self.constraintCountryCodeWidth.constant = cellWidth
            }
        }
    }
}
