//
//  FormFieldCell.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 29/06/25.
//

import UIKit

class FormFieldCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    /// Label to show field title (e.g. Email, Password)
    @IBOutlet weak var titleLabel: UILabel!
    
    /// TextField for user input
    @IBOutlet weak var textField: UITextField!
    
    /// Label to display validation error messages
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Properties
        
    /// Field type used to determine which validation to apply
    var validationType: FieldType?
    
    /// Closure to notify value change (optional, not used here)
    var onTextChange: ((String) -> Void)?
    
    // MARK: - Lifecycle
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Set initial error label appearance
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
//        errorLabel.isHidden = true
        errorLabel.text = ""
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Configuration
        
    /// Configures the cell with title, placeholder, and field type
    func configure(with title: String, placeholder: String, type: FieldType) {
        titleLabel.text = title
        textField.placeholder = placeholder
        validationType = type
    }
    
    // MARK: - Validation
        
    /// Validates the text field input based on the assigned field type
    /// - Parameters:
    ///   - tableView: Table view containing the cell
    ///   - indexPath: Index path of the cell
    /// - Returns: Tuple indicating if input is valid and the actual text (or nil if invalid)
    func validateInput(in tableView: UITableView, at indexPath: IndexPath) -> (isValid: Bool, text: String?) {
        guard let type = validationType else { return (true, textField.text) }
        let text = textField.text ?? ""
        var isValid = true
        
        // Perform validation based on field type
        switch type {
        case .email:
            if text.isEmpty {
                errorLabel.text = AppConstant.InputFiledValidationMessage.Email.emptyEmail
                isValid = false
            } else if !text.contains("@") {
                errorLabel.text = AppConstant.InputFiledValidationMessage.Email.invalid
                isValid = false
            }
        case .password:
            if text.isEmpty {
                errorLabel.text = AppConstant.InputFiledValidationMessage.Password.emptyPassword
                isValid = false
            } else if text.count < 8 {
                errorLabel.text = AppConstant.InputFiledValidationMessage.Password.short
                isValid = false
            }
        case .phone:
            if text.isEmpty {
                errorLabel.text = AppConstant.InputFiledValidationMessage.Phone.emptyPhone
                isValid = false
            } else if text.count < 10 {
                errorLabel.text = AppConstant.InputFiledValidationMessage.Phone.short
                isValid = false
            }
        case .username:
            if text.isEmpty {
                errorLabel.text = AppConstant.InputFiledValidationMessage.Username.emptyUsername
                isValid = false
            }
        case .fullname:
            if text.isEmpty {
                errorLabel.text = AppConstant.InputFiledValidationMessage.FullName.emptyFullName
                isValid = false
            }
        default:
            isValid = true
            break
        }
        
        // Show or hide error label based on validation result
        errorLabel.isHidden = isValid
        
        // Refresh the cell layout to accommodate error label height
        tableView.beginUpdates()
        tableView.endUpdates()
        return (isValid, isValid ? text : nil)
    }
}
