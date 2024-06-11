//
//  hookedViewController.swift
//  New_Bookspeare
//
//  Created by Jasmine Agrawal on 11/06/24.
//

import UIKit

class hookedViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var listNameTextField: UITextField!
    @IBOutlet weak var shortDescriptionTextField: UITextField!
    @IBOutlet weak var donePressed: UIButton!
    
    // Define the delegate property
    weak var delegate: HookedViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the delegate for text fields
        listNameTextField.delegate = self
        shortDescriptionTextField.delegate = self
        
        // Add target for done button
        donePressed.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    
    @objc func doneButtonPressed() {
        // Get text from text fields
        guard let listName = listNameTextField.text, !listName.isEmpty,
              let shortDescription = shortDescriptionTextField.text, !shortDescription.isEmpty else {
            // Show an alert if any text field is empty
            let alert = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        // Pass data back to the delegate
        delegate?.didAddNewItem(listName: listName, shortDescription: shortDescription)
        
        // Dismiss the view controller
        navigationController?.popViewController(animated: true)
    }
    
    // Dismiss keyboard when return key is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Dismiss keyboard when user touches outside the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
