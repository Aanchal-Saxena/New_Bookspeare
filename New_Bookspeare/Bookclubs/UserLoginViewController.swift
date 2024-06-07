//
//  UserLoginViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit
import Firebase
import FirebaseAuth
import AuthenticationServices
import CryptoKit
import FirebaseFirestore

class UserLoginViewController: UIViewController, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
    
    
    
    
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passInput: UITextField!
         
    @IBOutlet var loginBtn: UIButton!

    //    let config = ToastConfiguration(
    //        direction: .bottom,
    //        dismissBy: [.time(time: 2.0), .swipe(direction: .natural), .longPress],
    //        animationTime: 0.2
    //    );
        
    let appleButton=ASAuthorizationAppleIDButton(type: .continue, style: .black)
        override func viewDidLoad() {
            emailInput.useUnderline()
            passInput.useUnderline()
            super.viewDidLoad()
            loginBtn.tintColor = .darkGray
            // Do any additional setup after loading the view.
            setupAppleButton()
        }
        func setupAppleButton() {
                      view.addSubview(appleButton)
                      appleButton.cornerRadius = 20
                      appleButton.addTarget(self, action: #selector(startSignInWithAppleFlow), for: .touchUpInside)
                      appleButton.translatesAutoresizingMaskIntoConstraints = false
                      appleButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
                      appleButton.widthAnchor.constraint(equalToConstant: 349).isActive = true
                      appleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                      appleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
                  }
        fileprivate var currentNonce: String?
                    
                        
                    @objc func startSignInWithAppleFlow() {
                        let nonce = randomNonceString()
                        currentNonce = nonce
                        let appleIDProvider = ASAuthorizationAppleIDProvider()
                        let request = appleIDProvider.createRequest()
                        request.requestedScopes = [.fullName, .email]
                        request.nonce = sha256(nonce)
                        
                        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
                        authorizationController.delegate = self
                        authorizationController.presentationContextProvider = self
                        authorizationController.performRequests()
                    }
                    
                    @available(iOS 13, *)
                    private func sha256(_ input: String) -> String {
                        let inputData = Data(input.utf8)
                        let hashedData = SHA256.hash(data: inputData)
                        let hashString = hashedData.compactMap {
                            return String(format: "%02x", $0)
                        }.joined()
                        
                        return hashString
                    }
                let db = Firestore.firestore()
                @IBAction func LoginBtnPressed(_ sender: Any) {
                    guard let email=emailInput.text else {return}
                    guard let password=passInput.text else {return}
                    
                    Auth.auth().signIn(withEmail: email, password: password){
                        firebaseResult, error in
                        if let e = error {
                            print("Invalid Password")
                           
                        }
                        else {
                            //let toast = Toast.text("Welcome Back!!")
                            //toast.show()
                            self.performSegue(withIdentifier: "showGenres", sender: self)
                        }
                    }
                   
                    
                }
                
                
                private func randomNonceString(length: Int = 32) -> String {
                  precondition(length > 0)
                  let charset: Array<Character> =
                      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
                  var result = ""
                  var remainingLength = length

                  while remainingLength > 0 {
                    let randoms: [UInt8] = (0 ..< 16).map { _ in
                      var random: UInt8 = 0
                      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                      if errorCode != errSecSuccess {
                        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
                      }
                      return random
                    }

                    randoms.forEach { random in
                      if remainingLength == 0 {
                        return
                      }

                      if random < charset.count {
                        result.append(charset[Int(random)])
                        remainingLength -= 1
                      }
                    }
                  }

                  return result
                }
                func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
                    if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                        // Perform any additional actions with appleIDCredential if needed
                        
                        // Get the user's unique identifier (userIdentifier)
                        let userIdentifier = appleIDCredential.user
                        
                        // Get the user's email
                        let userEmail = appleIDCredential.email
                        
                        // Get the user's full name
                        let userFullName = "\(appleIDCredential.fullName?.givenName ?? "") \(appleIDCredential.fullName?.familyName ?? "")"
                        
                        // Perform segue to the home view controller
                        self.performSegue(withIdentifier: "homeView", sender: (userIdentifier, userEmail, userFullName))
                    }
                }
        @IBAction func signInCilicked(_ sender: UIButton) {
                    guard let email=emailInput.text else {return}
                    guard let password=passInput.text else {return}
                    Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                                if let error = error {
                                    print("Error signing up: \(error.localizedDescription)")
    //                                let toast = Toast.text("\(error.localizedDescription)", config: self.config)
    //                                toast.show()
                                } else {
    //                                let toast = Toast.text("Welcome Back", config: self.config)
    //                                toast.show()
                                    print("User signed In successfully")
                                    // Perform any additional actions after sign-up
                                    self.performSegue(withIdentifier: "showGenres", sender: nil)
                                }
                            }
                }
    //            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //                if segue.identifier == "homeView" {
    //                    if let destinationVC = segue.destination as? HomeTableViewController {
    //                        if let (userIdentifier, userEmail, userFullName) = sender as? (String, String?, String?) {
    //                            // Check if userIdentifier is available
    //                            if let currentUser = Auth.auth().currentUser {
    //                                // If the user authenticated with email/password, pass the email
    //                                destinationVC.user = currentUser.email
    //                            } else {
    //                                // If the user authenticated with Apple ID, pass the full name
    //                                destinationVC.user = userFullName
    //                            }
    //                        }
    //                    }
    //                }
    //                }

        /*
        // MARK: - Navigation

        // In a storyboard-based application, you will often want to do a little preparation before navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // Get the new view controller using segue.destination.
            // Pass the selected object to the new view controller.
        }
        */

    }

