//
//  EditViewController.swift
//  profile
//
//  Created by Jasmine Agrawal on 27/05/24.
//

import UIKit

class EditViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var editImageChanged: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bioTextField: UITextField!
    @IBOutlet weak var changeProfileButton: UIButton!
    
    
    
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
        
      
