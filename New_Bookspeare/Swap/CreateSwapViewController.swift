//
//  CreateSwapViewController.swift
//  New_Bookspeare
//
//  Created by Katyayani Singh on 10/06/24.
//

import UIKit

class CreateSwapViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var existingSwaps: [Swap] = []
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }
    
    @IBOutlet weak var swapImage: UIImageView!
    
    
    @IBOutlet weak var swapBookName: UITextField!
    
    
    @IBOutlet weak var swapBookDescription: UITextField!
    
    
    @IBOutlet weak var swapGenre: UITextField!
    
    
    @IBOutlet weak var createButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        swapImage.isUserInteractionEnabled = true
        fetchExistingEvents()
        self.inputViewController?.dismissKeyboard()
        self.swapBookName.delegate = self
        self.swapBookDescription.delegate = self
        self.swapGenre.delegate = self
        
        // Add tap gesture recognizers
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        swapImage.addGestureRecognizer(imageTapGesture)
        
        swapBookName.useUnderline()
        swapBookDescription.useUnderline()
        swapBookDescription.useUnderline()
        
        createButton.layer.borderWidth = 0.5
        createButton.layer.cornerRadius = 22
        createButton.layer.borderColor = UIColor.black.cgColor
        createButton.isEnabled = false
        updateCreateButtonState()
        

        // Do any additional setup after loading the view.
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view == swapImage{
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
            alertController.popoverPresentationController?.sourceView = swapImage
            present(alertController, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            swapImage.image = pickedImage

        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func fetchExistingEvents()
    {
        let email = UserDefaults.standard.value(forKey: "email")
        let safeEmail = DataController.safeEmail(email: email as! String)
        DataController.shared.fetchSwappedBooks(forEmail: safeEmail) { [weak self] result in
            switch result {
            case .success(let bc):
                self?.existingSwaps.append(contentsOf: bc)
                
                 // Ensure the main bookclubs array is also updated
            case .failure(let error):
                print("Failed to fetch book clubs: \(error)")
            }
            
        }
    }
    
    
    func updateCreateButtonState()
    {
        let nameText = swapBookName.text ?? ""
        let descriptionText = swapBookDescription.text ?? ""
        let genreText = swapGenre.text ?? ""
        //let image = UIImage(named: "one")
        createButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty
    }
    
    
    @IBAction func textEditingEnded(_ sender: UITextField) {
        updateCreateButtonState()
        
    }
    
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        guard let email = UserDefaults.standard.value(forKey: "email") else {
            return
        }
        let safeEmail = DataController.safeEmail(email: email as! String)
        let location1 = Location(latitude: 40.7128, longitude: -74.0060) // New York
        
        let name = swapBookName.text ?? ""
        let description = swapBookDescription.text ?? ""
        let genre = swapGenre.text ?? ""
        let swap = Swap(bookTitle: name, description: description, location: location1, image: "one")
        existingSwaps.append(swap)
        
        DataController.shared.updateSwappedBooks(forEmail: safeEmail, swappedBooks: existingSwaps) { success in
            if success {
                print("Swap books updated successfully.")
            } else {
                print("Failed to update events.")
            }
        }

    }
    
    


}
