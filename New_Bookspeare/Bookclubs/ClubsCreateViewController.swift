//
//  ClubsCreateViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit
import FirebaseDatabase



class ClubsCreateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    var exitingBookclubs: [BookClub] = []
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }
   
    
    @IBOutlet weak var bookclubImage: UIImageView!
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    
    @IBOutlet weak var genreTextField: UITextField!
    
    
    @IBOutlet weak var createButton: UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchExistingBookclubs()
        self.inputViewController?.dismissKeyboard()
        self.nameTextField.delegate = self
        self.descriptionTextField.delegate = self
        self.genreTextField.delegate = self
        
        bookclubImage.isUserInteractionEnabled = true
        
        // Add tap gesture recognizers
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        bookclubImage.addGestureRecognizer(imageTapGesture)
        
        nameTextField.useUnderline()
        descriptionTextField.useUnderline()
        genreTextField.useUnderline()
        
        createButton.layer.borderWidth = 0.5
        createButton.layer.cornerRadius = 22
        createButton.layer.borderColor = UIColor.black.cgColor
        createButton.isEnabled = false
        updateCreateButtonState()
        
        
    }
    
//    func fetchExistingBookclubs()
//    {
//        let email = UserDefaults.standard.value(forKey: "email")
//        let safeEmail = DataController.safeEmail(email: email as! String)
//        DataController.shared.fetchBookClubs(forEmail: safeEmail) { [weak self] result in
//            switch result {
//            case .success(let bc):
//                self?.exitingBookclubs.append(contentsOf: bc)
//                
//                 // Ensure the main bookclubs array is also updated
//            case .failure(let error):
//                print("Failed to fetch book clubs: \(error)")
//            }
//            
//        }
//    }
    
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
    
    
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view == bookclubImage{
            print("Photo Library")
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            let alertController = UIAlertController(title: "Choose Image source", message: nil, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: {action in imagePicker.sourceType = .camera
                    self.present(imagePicker, animated: true, completion: nil)
                })
                alertController.addAction(cameraAction)
            }
            
            if  UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let photoLibraryAction =  UIAlertAction(title: "Photo Library", style: .default, handler: {action in imagePicker.sourceType = .photoLibrary
                    self.present(imagePicker, animated: true, completion: nil)})
                alertController.addAction(photoLibraryAction)
            }
            
            
            alertController.addAction(cancelAction)
            alertController.popoverPresentationController?.sourceView = bookclubImage
            present(alertController, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            bookclubImage.image = pickedImage

            guard let image = bookclubImage.image,
                  let data = image.pngData() else
            {
                return
            }
            
            let email = UserDefaults.standard.value(forKey: "email")
            let safeEmail = DataController.safeEmail(email: email as! String)
            let fileName = DataController.bookclubPictureUrl(safeEmail: safeEmail)
            StorageManager.shared.uploadProfilePicure(with: data, filename: fileName, completion: { result in
                switch result {
                case .success(let downloadUrl):
                    UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                    print(downloadUrl)
                case .failure(let error):
                    print("Storage manager error: \(error)")
                }
            })

                  
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        let name = nameTextField.text ?? ""
            let description = descriptionTextField.text ?? ""
            let genre = genreTextField.text ?? ""
            let genreEnum = Genre(rawValue: genre) ?? .Fiction
            let bookclub = BookClub(name: name, image: "one", description: description, members: 1)
            
            exitingBookclubs.append(bookclub)
            
            guard let email = UserDefaults.standard.value(forKey: "email") else {
                return
            }
            let safeEmail = DataController.safeEmail(email: email as! String)
            
        let bookclubRef = Database.database().reference().child(safeEmail).child("bookclubs").child("child")
            
            let bookclubDicts = exitingBookclubs.map { $0.toDictionary() }
            
            bookclubRef.setValue(bookclubDicts) { error, _ in
                if let error = error {
                    print("Failed to update book clubs: \(error.localizedDescription)")
                } else {
                    print("Book clubs updated successfully.")
                }
            }
        }
    
    
}








//DataController.shared.updateBookClubs(forEmail: safeEmail, bookClubs: bookclubs) { success in
//            if success {
//                print("Book club updated successfully")
//                // Handle success (e.g., navigate back, show success message, etc.)
//            } else {
//                print("Failed to update book club")
//                // Handle failure (e.g., show error message)
//            }
//        }
