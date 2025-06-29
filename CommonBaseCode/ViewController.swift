//
//  ViewController.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    /// Array to store media objects
    lazy var arrMedia: [MediaObject] = {
        return []
    }()
    
    /// ViewModel for login screen
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    var isFirstTimeGetCountry: Bool = true
    
    // MARK: - Outlets
    @IBOutlet weak var imgCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblCountryTitle: UILabel!
    @IBOutlet weak var txtPhoneCode: UITextField!
    @IBOutlet weak var viewPhone: UIView!
    @IBOutlet weak var viewPhoneBorder: UIView!
    @IBOutlet weak var constraintCountryCodeWidth: NSLayoutConstraint!
    @IBOutlet weak var viewBlink: UIView!
    
    @IBOutlet weak var tableView: UITableView!

    var fields: [FieldData] = [
        FieldData(title: "Email", placeholder: "Enter email", value: "", type: .email),
        FieldData(title: "Password", placeholder: "Enter password", value: "", type: .password),
        FieldData(title: "Phone", placeholder: "Enter phone", value: "", type: .phone),
        FieldData(title: "Username", placeholder: "Enter username", value: "", type: .username),
        FieldData(title: "Full Name", placeholder: "Enter full name", value: "", type: .fullname)
    ]
    /// Computed property to get current country info using locale
    var currentCountry: Country? {
        guard let countryCode = Locale.current.region?.identifier else {
            return nil
        }
        return Country(countryCode: countryCode)
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initial login API call
        self.callLoginAPI()
        
        // Set country flag, dialing code and adjust UI
        self.setCurrentCountry()
        self.animateTextView(view: self.viewPhoneBorder, label: self.lblCountryTitle, isEmpty: self.txtPhoneCode.text?.trim() == "")
        
        // Uncomment to use:
        // self.checkSocketConnection()
        // self.uploadMediaToS3()
        // self.downloadMediaIfNeeded()
        
        self.viewBlink.blinkView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.register(UINib(nibName: "FormFieldCell", bundle: nil), forCellReuseIdentifier: "FormFieldCell")
    }
    
    // MARK: - Setup Methods

    /// Set current country details in the UI
    private func setCurrentCountry() {
        lblCountryCode.text = currentCountry?.dialingCode
        let font = UIFont.systemFont(ofSize: AppConstant.DeviceType.IS_PAD ? 18.0 : 16.0)
        self.lblCountryCode.font = font
        self.txtPhoneCode.font = font
        self.txtPhoneCode.delegate = self
        
        // Adjust width of label based on content
        let extraWidth = AppConstant.DeviceType.IS_PAD ? 10 : 0
        let labelWidth = (currentCountry?.dialingCode?.textWidth(font: font) ?? 0.0) + CGFloat(extraWidth)
        constraintCountryCodeWidth.constant = labelWidth
        
        // Load country flag from bundle
#if SWIFT_PACKAGE
        let bundle = Bundle.module
#else
        let bundle = Bundle(for: Country.self)
#endif
        
        if let flagImage = UIImage(named: currentCountry!.imagePath, in: bundle, compatibleWith: nil) {
            imgCountryFlag.image = flagImage
            imgCountryFlag.isHidden = false
        }
    }
    
    func animateTextView(view: UIView, label: UILabel, isEmpty: Bool) {
        DispatchQueue.main.async {
            label.isHidden = isEmpty
            view.backgroundColor = isEmpty ? AppConstant.Colors.toastErrorBG : AppConstant.Colors.toastSuccessText
        }
    }
}

// MARK: - API Call

extension ViewController {

    /// Calls API to login into the store
    func callLoginAPI() {
        var params: JSONType = [:]
        params[LoginParameterKey.email.rawValue] = ""
        params[LoginParameterKey.password.rawValue] = ""

        viewModel.callAPIToLoginInStore(params: params) { isSuccess, message in
            if isSuccess {
                // Navigate to dashboard or next screen
//                if let vc = R.storyboard.main.homeVC() {
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
            }
        } failure: { error in
            self.showToast(message: error, isSuccess: false)
        }
    }
}

// MARK: - Actions

extension ViewController {

    /// Handles country picker button tap
    @IBAction func btnCountryCodeSelectionAction(_ sender: UIButton) {
        presentCountryPickerScene(withSelectionControlEnabled: false)
    }
    
    /// Validate all input filed button tap
    @IBAction func validateAllFields(_ sender: UIButton) {
        var allValid = true
        
        for i in 0..<fields.count {
            let indexPath = IndexPath(row: i, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) as? FormFieldCell {
                let result = cell.validateInput(in: tableView, at: indexPath)
                if result.isValid {
                    fields[i].value = result.text ?? ""
                }
                allValid = allValid && result.isValid
            }
        }
        
        if allValid {
            print("✅ All fields valid")
            for field in fields {
                print("\(field.title): \(field.value)")
            }
        } else {
            print("❌ Validation failed")
        }
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

// MARK: - Socket & Media Handling (Reusable Examples)

extension ViewController {

    /// Example: Checks and connects socket
    private func checkSocketConnection() {
        if SocketManager.shared.checkConnection() {
            Utils.sendSocketEmitData(socketID: "your stored Socket Id", screenName: "\(self.classForCoder)")
        } else {
            SocketManager.shared.connectSocket { isSuccess, socketID in
                if isSuccess {
                    Utils.sendSocketEmitData(socketID: "your stored Socket Id", screenName: "\(self.classForCoder)")
                }
            }
        }
    }

    /// Example: Uploads media to S3 bucket
    private func uploadMediaToS3() {
        var objMedia: MediaObject?

        let bucketName = objMedia?.bucketName ?? ""
        let mediaKey = "user-profile-image/\(objMedia?.key ?? "")"
        let image = objMedia?.image ?? UIImage()

        AWSManager.uploadMediaToS3Bucket(isForProfile: true, bucketName: bucketName, mediaKey: mediaKey, image: image, fileURL: objMedia?.url, type: .image) { isSuccess in
            print("/user-profile-image/\(objMedia?.key ?? "")".appendS3BaseURL())
        } failure: { error in
            self.showToast(message: "Failed to upload media, please try again!", isSuccess: false)
            objMedia = nil
        } progressBlock: { progress in
            print(progress)
        }
    }

    /// Example: Downloads media if not already existing
    private func downloadMediaIfNeeded() {
        guard let obj = arrMedia.first else { return }

        if FileDownloader.checkIfFileExists(mediaObj: obj) {
            self.showToast(message: "File already exists!", isSuccess: false)
        } else {
            self.showToast(message: "Media downloading started. It will be saved shortly.", isSuccess: true)
            FileDownloader.loadFileAsync(mediaObj: obj) { message, error in
                DispatchQueue.main.async {
                    let topVC = AppManager.shared.topViewController()
                    topVC.showToast(message: message, isSuccess: error == nil)
                }
            }
        }
    }
}

//Textfield Delegate Method
extension ViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let newtext = text.replacingCharacters(in: range, with: string)
            
            switch textField {
            case self.txtPhoneCode:
                self.animateTextView(view: self.viewPhoneBorder, label: self.lblCountryTitle, isEmpty: newtext == "")
            default:
                print("")
            }
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    
        return true
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FormFieldCell", for: indexPath) as? FormFieldCell else {
            return UITableViewCell()
        }
        
        let field = fields[indexPath.row]
        cell.configure(with: field.title, placeholder: field.placeholder, type: field.type)
        
        return cell
    }
}
