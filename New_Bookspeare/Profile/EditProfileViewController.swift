//
//  EditProfileViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class EditProfileViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var user: User?
    var userEmail: String?
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var editImageChanged: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var changeProfileButton: UIButton!
    
    
    @IBOutlet weak var pronounsTextField: UITextField!
    
    @IBOutlet weak var dobTextField: UITextField!
    
    
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            // Ensure the profile image view is circular
            editImageChanged.layer.cornerRadius = editImageChanged.frame.size.width / 2
            editImageChanged.clipsToBounds = true
        }
        
        _ = [("Enter Your Name")]
        
        func viewDidLoad() {
            super.viewDidLoad()
            
            if let user = user {
                    nameTextField.text = user.firstName
                    pronounsTextField.text = user.pronouns
                    bioTextField.text = user.bio
                    userEmail = user.email
                    }
            user?.email = "misty@gmail.com"
            
            editImageChanged.contentMode = .scaleAspectFit
            makeCircular(imageView: editImageChanged)
            viewCell(profileCellView: view1)
            viewCell(profileCellView: view2)
            viewCell(profileCellView: view3)
            viewCell(profileCellView: view4)
            viewCell(profileCellView: view5)
            
            
            
            viewCell(profileCellView: view
            )
            
            func viewCell(profileCellView: UIView)
            {
                profileCellView.layer.borderColor = UIColor.gray.cgColor
                profileCellView.layer.borderWidth = 0.1
                
                // Set the corner radius
                profileCellView.layer.cornerRadius = 5.0
                profileCellView.clipsToBounds = true
                
                // Set the shadow
                profileCellView.layer.shadowColor = UIColor.black.cgColor
                profileCellView.layer.shadowOpacity = 0.1
                profileCellView.layer.shadowOffset = CGSize(width: 2, height: 2)
                profileCellView.layer.shadowRadius = 0.2
                profileCellView.layer.masksToBounds = false
            }
            
        }
        
        
        
        
        
        
        // Enable interaction
               editImageChanged.isUserInteractionEnabled = true
               changeProfileButton.isUserInteractionEnabled = true
               
               // Add tap gesture recognizers
               let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
               editImageChanged.addGestureRecognizer(imageTapGesture)
               
               let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
               changeProfileButton.addGestureRecognizer(labelTapGesture)
           }
    
    
    @IBAction func editingDidEnd(_ sender: UITextField) {
        
        guard var user = user else { return }
            
            // Update user properties based on the text field that triggered the action
            switch sender {
            case nameTextField:
                user.firstName = sender.text ?? ""
            case pronounsTextField:
                user.pronouns = sender.text ?? ""
            case bioTextField:
                user.bio = sender.text ?? ""
            default:
                break
            }
            user.email = "misty@gmail.com" // Update user's email
            userEmail = user.email
      
            // Update the user in DataController
            DataController.shared.updateUser(withEmail: "misty@gmail.com", updatedUser: user)
            
            // Reassign the updated user to the user property
            self.user = user
        print("User email on save: \(user.email)")
        
    }
    
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let user = user else { return }
                
                // Update the user in DataController
        DataController.shared.updateUser(withEmail: "misty@gmail.com", updatedUser: user)
        print(user)
        userEmail = user.email
        
        print("User email on save: 1 \(user.email)")
            
            // Perform unwind segue
        performSegue(withIdentifier: "unwindToMyProfileViewController", sender: self)
    }
    
    
    
    
    
  @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if sender.view == editImageChanged{
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
            alertController.popoverPresentationController?.sourceView = editImageChanged
            present(alertController, animated: true, completion: nil)
 
               }
        else if sender.view == changeProfileButton {
            print("Camera")
                   
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
                   alertController.popoverPresentationController?.sourceView = changeProfileButton
                   present(alertController, animated: true, completion: nil)
                   // Perform your action here
               }
           }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let pickedImage = info[.originalImage] as? UIImage {
                editImageChanged.image = pickedImage
                makeCircular(imageView: editImageChanged)
            }
            dismiss(animated: true, completion: nil)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    
    func makeCircular(imageView: UIImageView) {
            imageView.layer.cornerRadius = imageView.frame.size.width / 2
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 1.0
            imageView.layer.borderColor = UIColor.gray.cgColor
        }
}
        
      
