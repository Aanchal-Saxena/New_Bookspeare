//
//  CreateEventsViewController.swift
//  New_Bookspeare
//
//  Created by Katyayani Singh on 10/06/24.
//

import UIKit

class CreateEventsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    
    var existingEvents: [Event] = []
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }
    
    
    @IBOutlet weak var eventImage: UIImageView!
    
    
    @IBOutlet weak var eventName: UITextField!
    
    
    @IBOutlet weak var eventAddress: UITextField!
    
    
    
    @IBOutlet weak var createButton: UIButton!
    
@IBOutlet weak var eventDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventImage.isUserInteractionEnabled = true
        
        self.inputViewController?.dismissKeyboard()
        self.eventName.delegate = self
        self.eventDescription.delegate = self
        self.eventAddress.delegate = self
        
        // Add tap gesture recognizers
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        eventImage.addGestureRecognizer(imageTapGesture)
        
        eventName.useUnderline()
        eventDescription.useUnderline()
        eventAddress.useUnderline()
        
        createButton.layer.borderWidth = 0.5
        createButton.layer.cornerRadius = 22
        createButton.layer.borderColor = UIColor.black.cgColor
        createButton.isEnabled = false
        updateCreateButtonState()

        // Do any additional setup after loading the view.
    }
    
    func updateCreateButtonState() {
            let nameText = eventName.text ?? ""
            let descriptionText = eventDescription.text ?? ""
            let addressText = eventAddress.text ?? ""
            createButton.isEnabled = !nameText.isEmpty && !descriptionText.isEmpty
        }
    
    func fetchExistingBookclubs()
    {
        let email = UserDefaults.standard.value(forKey: "email")
        let safeEmail = DataController.safeEmail(email: email as! String)
        DataController.shared.fetchEvents(forEmail: safeEmail) { [weak self] result in
            switch result {
            case .success(let bc):
                self?.existingEvents.append(contentsOf: bc)
                
                 // Ensure the main bookclubs array is also updated
            case .failure(let error):
                print("Failed to fetch book clubs: \(error)")
            }
            
        }
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view == eventImage{
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
            alertController.popoverPresentationController?.sourceView = eventImage
            present(alertController, animated: true, completion: nil)
            
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            eventImage.image = pickedImage


                  
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func textEditingEnded(_ sender: UITextField) {
        updateCreateButtonState()
        
    }
    
    

    @IBAction func createButtonTapped(_ sender: UIButton) {
        
        // Create a new event
                let name = eventName.text ?? ""
                let description = eventDescription.text ?? ""
                let address = eventAddress.text ?? ""
                let event = Event(title: name, images: "one", description: description, registeredMembers: 0, address: address)
                
                // Add the new event to the existing events array
                existingEvents.append(event)
        
        guard let email = UserDefaults.standard.value(forKey: "email") else {
            return
        }
        let safeEmail = DataController.safeEmail(email: email as! String)
                
                // Update events in the database
                DataController.shared.updateEvents(forEmail: safeEmail, events: existingEvents) { success in
                    if success {
                        print("Events updated successfully.")
                    } else {
                        print("Failed to update events.")
                    }
                }
    }
    
}
