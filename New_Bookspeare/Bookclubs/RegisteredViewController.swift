//
//  RegisteredViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//
import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices
extension UITextField {
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

class RegisteredViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
    
    @IBOutlet var signUpWithAplleButton: UIButton!
    
    @IBOutlet var signUpWithEmailButton: UIButton!
    
    @IBOutlet var emailTextField: UITextField!
    
    
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var privacyPolicyButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.useUnderline()
        emailTextField.useUnderline()
        passwordTextField.useUnderline()
        signUpWithAplleButton.layer.borderWidth = 0.5
        signUpWithAplleButton.layer.cornerRadius = 22
        signUpWithAplleButton.layer.borderColor = UIColor.black.cgColor

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func privacyPolicyButtonTapped(_ sender: UIButton) {
        privacyPolicyButton.isSelected.toggle()
    }
    @IBAction func signUpCilicked(_ sender: UIButton) {
                guard let email=emailTextField.text else {return}
                guard let password=passwordTextField.text else {return}
                guard let username=nameTextField.text else {return}
        
        DataController.shared.validateNewUser(with: email, completion: { [weak self] exists in
            guard let strongSelf = self else
            {
                return
            }
            guard !exists else
            {
                strongSelf.alertUserLoginError(message: "Looks like a user account for that email address already exists")
                return
            }
            
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                
                if let error = error {
                    print("Error signing up: \(error.localizedDescription)")
                } else {
                    let user = User(id: UUID(), password: password, username: username, name: nil , email: email, pronouns: nil, bookclubs: nil, image: nil, userGenres: nil, bio: nil)
                    DataController.shared.insertUser(with: user)
                            
//                            guard let image = strongSelf.imageView.image,
//                                  let data = image.pngData() else
//                            {
//                                return
//                            }
//                            let fileName = user.profilePictureUrl
//                            StorageManager.shared.uploadProfilePicure(with: data, filename: fileName, completion: { result in
//                                switch result {
//                                case .success(let downloadUrl):
//                                    UserDefaults.standard.set(downloadUrl, forKey: "profile_picture_url")
//                                    print(downloadUrl)
//                                case .failure(let error):
//                                    print("Storage manager error: \(error)")
//                                }
//                            })
                        
                    
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(password, forKey: "password")
                    UserDefaults.standard.set(username, forKey: "username")
                    print("User signed up successfully")
                    // Perform any additional actions after sign-up
                    //strongSelf.navigationController?.dismiss(animated: true , completion: nil)
                    strongSelf.performSegue(withIdentifier: "showLogin", sender: nil)
//                    let vc = DateOfBirthViewController()
//                    let nav = UINavigationController(rootViewController: vc)
//                    nav.modalPresentationStyle = .fullScreen
//                    strongSelf.present(nav, animated: false)
                }}
        })
    }
    
    
    func alertUserLoginError(message: String)
    {
        let alert = UIAlertController(title: "Woops", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
