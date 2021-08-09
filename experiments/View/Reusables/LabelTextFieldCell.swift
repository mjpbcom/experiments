//
//  LabelTextFieldCell.swift
//  experiments
//
//  Created by Mariah Jessica Baysic on 7/12/21.
//

import UIKit

enum textFieldType {
    case NUMBER
    case DECIMAL
    case NAME
    case PASSWORD
    case STRING
    case EMAIL
}

class LabelTextFieldCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var error: UILabel!
    
    var validation, errorMessage: String!
    var isMandatory: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initialize(title: String, placeholder: String, type: textFieldType, isMandatory: Bool = false, validation: String = "", errorMessage: String = "") {
        self.title.text = title
        field.placeholder = placeholder
        field.delegate = self
        error.text = ""
        if isMandatory {
            error.text = "\(title) is required"
        }
        self.validation = validation
        self.errorMessage = errorMessage
        self.isMandatory = isMandatory
        
        switch type {
        case .NUMBER:
            field.keyboardType = .numberPad
        case .DECIMAL:
            field.keyboardType = .decimalPad
        case .NAME:
            field.textContentType = .name
            field.autocapitalizationType = .words
            field.keyboardType = .alphabet
        case .PASSWORD:
            field.textContentType = .password
            field.autocapitalizationType = .none
            field.keyboardType = .default
            field.isSecureTextEntry = true
        case .EMAIL:
            field.textContentType = .emailAddress
            field.keyboardType = .emailAddress
            field.autocapitalizationType = .none
        default:
            field.autocapitalizationType = .sentences
            field.keyboardType = .default
        }
    }
    
    func getTextField() -> UITextField {
        return field
    }

}

extension LabelTextFieldCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if isMandatory && textField.text!.isEmpty {
            error.text = "\(title.text ?? "Field") is required"
        }
        textField.resignFirstResponder()
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if isMandatory && textField.text!.isEmpty {
            error.text = "\(title.text ?? "Field") is required"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !validation.isEmpty || isMandatory {
            let oldString = textField.text! as NSString
            let candidate = oldString.replacingCharacters(in: range, with: string)
            let regex = try? NSRegularExpression(pattern: validation, options: [])
            let isValid = regex?.firstMatch(in: candidate, options: [], range: NSRange(location: 0, length: candidate.count)) != nil
            
            error.text = ""
            if !isValid {
                error.text = errorMessage
            }
        }
        
        return true
    }
}
