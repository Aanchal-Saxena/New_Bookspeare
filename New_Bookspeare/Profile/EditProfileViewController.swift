//
//  EditProfileViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth



class EditProfileViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
                self.view.endEditing(true)
            }
    
    
    
    
    
    
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editImageChanged.contentMode = .scaleAspectFit
        makeCircular(imageView: editImageChanged)
        viewCell(profileCellView: view1)
        viewCell(profileCellView: view2)
        viewCell(profileCellView: view3)
        viewCell(profileCellView: view4)
        viewCell(profileCellView: view5)
        
        print("edit view did load")
        
        editImageChanged.isUserInteractionEnabled = true
        changeProfileButton.isUserInteractionEnabled = true
        
        // Add tap gesture recognizers
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        editImageChanged.addGestureRecognizer(imageTapGesture)
        
        let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        changeProfileButton.addGestureRecognizer(labelTapGesture)
        
    }

        
    func viewCell(profileCellView: UIView)
    {
        profileCellView.layer.borderColor = UIColor.gray.cgColor
        profileCellView.layer.borderWidth = 0.1
        profileCellView.layer.cornerRadius = 5.0
        profileCellView.clipsToBounds = true
        
        
        // Set the shadow
        profileCellView.layer.shadowColor = UIColor.black.cgColor
        profileCellView.layer.shadowOpacity = 0.1
        profileCellView.layer.shadowOffset = CGSize(width: 2, height: 2)
        profileCellView.layer.shadowRadius = 0.2
        profileCellView.layer.masksToBounds = false
    }
        
        
        
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
       
        print("save button tapped")
        
    
//        performSegue(withIdentifier: "unwindToMyProfileViewController", sender: self)
    }
    
        
        
        
    
    
    @IBAction func editingDidEnd(_ sender: UITextField) {
        
        guard let email = UserDefaults.standard.value(forKey: "email") else {
                return  }
        let safeEmail = DataController.safeEmail(email: email as! String)
        
        
        let name = nameTextField.text ?? ""
        let bio = bioTextField.text ?? ""
        let pronouns = pronounsTextField.text ?? ""
        
        let bioRef = Database.database().reference().child(safeEmail).child("bio")
        let nameRef = Database.database().reference().child(safeEmail).child("name")
        let pronounsRef = Database.database().reference().child(safeEmail).child("pronouns")
        
        
        bioRef.setValue(bio) { error, _ in
                if let error = error {
                    print("Failed to update bio: \(error.localizedDescription)")
                } else {
                    print("Bio updated successfully.")
                }
        }
            
        nameRef.setValue(name) { error, _ in
                if let error = error {
                    print("Failed to update name: \(error.localizedDescription)")
                } else {
                    print("Name updated successfully.")
                }
        }
            
        pronounsRef.setValue(pronouns) { error, _ in
                if let error = error {
                    print("Failed to update pronouns: \(error.localizedDescription)")
                } else {
                    print("Pronouns updated successfully.")
                }
        }

        
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
            
            
            guard let email = UserDefaults.standard.value(forKey: "email") else {
                    return  }
            let safeEmail = DataController.safeEmail(email: email as! String)
           
            
            
            guard let image = editImageChanged.image,
                  let data = image.pngData() else
            {
                return
            }
            
            let fileName = DataController.profilePictureUrl(safeEmail: safeEmail)
            StorageManager.shared.uploadProfilePicure(with: data, filename: fileName, completion: { result in
                switch result {
                case .success(let downloadUrl):
                    UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
                    let imageRef = Database.database().reference().child(safeEmail).child("image")
                    
                    
                    imageRef.setValue(downloadUrl) { error, _ in
                            if let error = error {
                                print("Failed to update bio: \(error.localizedDescription)")
                            } else {
                                print("Profile Url updated successfully.")
                            }
                    }
                    print(downloadUrl)
                case .failure(let error):
                    print("Storage manager error: \(error)")
                }
            })
            
//            func downloadImage(imageView: UIImageView, url: URL)
//            {
//                 URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in guard let data = data, error == nil else { return }
//            
//                DispatchQueue.main.async {
//                    let image = UIImage(data: data)
//                    imageView.image = image }
//            
//                }).resume()
//            }

                  
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
        imageView.contentMode = .scaleToFill
    }
 
}
    

