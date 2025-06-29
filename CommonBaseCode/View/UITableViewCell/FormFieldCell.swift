//
//  FormFieldCell.swift
//  CommonBaseCode
//
//  Created by  Kalpesh on 29/06/25.
//

import UIKit

class FormFieldCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var validationType: FieldType?
    var onTextChange: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
    
    func configure(with title: String, placeholder: String, type: FieldType) {
        titleLabel.text = title
        textField.placeholder = placeholder
        validationType = type
    }
    
    func validateInput(in tableView: UITableView, at indexPath: IndexPath) -> (isValid: Bool, text: String?) {
        guard let type = validationType else { return (true, textField.text) }
        let text = textField.text ?? ""
        var isValid = true
        
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
        
        errorLabel.isHidden = isValid
        tableView.beginUpdates()
        tableView.endUpdates()
        return (isValid, isValid ? text : nil)
    }
}
