//
//  ViewController.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 28/06/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    /// Array to store selected or available media files
    lazy var arrMedia: [MediaObject] = {
        return []
    }()
    
    /// ViewModel responsible for handling login business logic and API calls
    lazy var viewModel: LoginViewModel = {
        return LoginViewModel()
    }()
    
    /// Flag to check if country is selected first time (used in country picker flow)
    var isFirstTimeGetCountry: Bool = true
    
    // MARK: - Outlets
    @IBOutlet weak var imgCountryFlag: UIImageView!
    @IBOutlet weak var lblCountryCode: UILabel!
    @IBOutlet weak var lblCountryTitle: UILabel!
    @IBOutlet weak var txtPhoneCode: UITextField!
    @IBOutlet weak var viewPhoneBorder: UIView!
    @IBOutlet weak var constraintCountryCodeWidth: NSLayoutConstraint!
    @IBOutlet weak var viewBlink: UIView!
    @IBOutlet weak var tableView: UITableView!

    /// Form fields for login screen (email, password, etc.)
    var fields: [FieldData] = [
        FieldData(title: "Email", placeholder: "Enter email", value: "", type: .email),
        FieldData(title: "Password", placeholder: "Enter password", value: "", type: .password),
        FieldData(title: "Phone", placeholder: "Enter phone", value: "", type: .phone),
        FieldData(title: "Username", placeholder: "Enter username", value: "", type: .username),
        FieldData(title: "Full Name", placeholder: "Enter full name", value: "", type: .fullname)
    ]
    
    /// Returns `Country` info based on current locale
    var currentCountry: Country? {
        guard let countryCode = Locale.current.region?.identifier else {
            return nil
        }
        return Country(countryCode: countryCode)
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Trigger login API (empty params for now)
//        self.callLoginAPI()
        
        // Set default country UI elements
        self.setCurrentCountry()
        
        // Animate border and title based on phone field content
        self.animateTextView(view: self.viewPhoneBorder, label: self.lblCountryTitle, isEmpty: self.txtPhoneCode.text?.trim() == "")
        
        // Uncomment to use:
        // self.checkSocketConnection()
        // self.uploadMediaToS3()
        // self.downloadMediaIfNeeded()
        
        self.viewBlink.blinkView()
        
        // Setup table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: "FormFieldCell", bundle: nil), forCellReuseIdentifier: "FormFieldCell")
    }
    
    // MARK: - Setup Methods

    /// Set current country flag, dialing code, and adjust UI widths
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
        
        // Load and display flag image
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
    
    /// Animate label and border color based on input field being empty
    func animateTextView(view: UIView, label: UILabel, isEmpty: Bool) {
        DispatchQueue.main.async {
            label.isHidden = isEmpty
            view.backgroundColor = isEmpty ? AppConstant.Colors.toastErrorBG : AppConstant.Colors.toastSuccessText
        }
    }
}

// MARK: - API Call

extension ViewController {

    /// Calls login API using ViewModel and handles response
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

// MARK: - User Actions

extension ViewController {

    /// Country code selection button tapped
    @IBAction func btnCountryCodeSelectionAction(_ sender: UIButton) {
        presentCountryPickerScene(withSelectionControlEnabled: false)
    }
    
    /// Validate all fields and collect data if valid
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

// MARK: - Country Picker
extension ViewController {
    
    /// Presents country picker with/without section control
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

// MARK: - Media & Socket Examples

extension ViewController {

    /// Check socket connection status, and reconnect if needed
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

    /// Upload media object to AWS S3
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

    /// Download media file if not already available locally
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

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
    /// Update animation based on phone input change
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

// MARK: - UITableView DataSource & Delegate

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
