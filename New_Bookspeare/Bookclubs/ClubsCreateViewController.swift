//
//  ClubsCreateViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class ClubsCreateViewController: UIViewController {
    
    var bookclubs: [BookClub] = []
    
    @IBOutlet weak var bookclubImage: UIImageView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBOutlet weak var genreTextField: UITextField!
    
    
    @IBOutlet weak var createButton: UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.useUnderline()
        descriptionTextField.useUnderline()
        genreTextField.useUnderline()
        
        createButton.layer.borderWidth = 0.5
        createButton.layer.cornerRadius = 22
        createButton.layer.borderColor = UIColor.black.cgColor
        createButton.isEnabled = false
        updateCreateButtonState()
        
        
    }
    
    @IBAction func textEditingEnded(_ sender: Any) {
        updateCreateButtonState()
    }
   
    
    func updateCreateButtonState()
    {
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        let genreText = genreTextField.text ?? ""
        //let image = UIImage(named: "one")
        createButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "saveUnwind" else { return }
//   
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        let genre = genreTextField.text ?? ""
        let genreEnum = Genre(rawValue: genre) ?? .Fiction
        //let image = UIImage(named: "one")
        let bookclub = BookClub(name: name, image: "one", genre: [genreEnum] ,description: description, members: 1)
        
        bookclubs.append(bookclub)
        
        guard let email = UserDefaults.standard.value(forKey: "email") else {
                        return  }
        let safeEmail = DataController.safeEmail(email: email as! String)
        DataController.shared.updateBookClubs(forEmail: safeEmail, bookClubs: bookclubs) { success in
                    if success {
                        print("Book club updated successfully")
                        // Handle success (e.g., navigate back, show success message, etc.)
                    } else {
                        print("Failed to update book club")
                        // Handle failure (e.g., show error message)
                    }
                }

        
    }
    
    
}
