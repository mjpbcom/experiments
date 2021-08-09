//
//  ViewController.swift
//  experiments
//
//  Created by Mariah Jessica Baysic on 7/12/21.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    var decimal, email, password, name : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func showAlert(_ sender: Any) {
        let alertController = CustomAlert(title: "Alert", message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", preferredStyle: .alert)
        
        // Change font and color of title
//        alertController.setTitlet(font: UIFont.boldSystemFont(ofSize: 20), color: UIColor.white)
        
        // Change font and color of message
        alertController.setMessage(font: UIFont(name: "HelveticaNeue", size: 12), color: UIColor.red)
        
        // Change background color of UIAlertController
        alertController.setBackgroundColor(color: UIColor.black)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
}

extension MainVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTextFieldCell") as! LabelTextFieldCell
            cell.initialize(title: "DECIMAL", placeholder: "DECIMAL", type: .DECIMAL)
            decimal = cell.getTextField()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTextFieldCell") as! LabelTextFieldCell
            cell.initialize(title: "EMAIL", placeholder: "EMAIL", type: .EMAIL, isMandatory: true, validation: "^.{1,}@.{1,}\\..{1,}$", errorMessage: "Invalid format")
            email = cell.getTextField()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTextFieldCell") as! LabelTextFieldCell
            cell.initialize(title: "PASSWORD", placeholder: "PASSWORD", type: .PASSWORD, isMandatory: true)
            password = cell.getTextField()
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelTextFieldCell") as! LabelTextFieldCell
            cell.initialize(title: "NAME", placeholder: "NAME", type: .NAME, validation: "^.{1,}$", errorMessage: "Name is required")
            name = cell.getTextField()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelsOnlyCell") as! LabelsOnlyCell
            cell.initialize(title: "\(indexPath.row)", body: "\(indexPath.row)")
            return cell
        }
    }
    
    
}
