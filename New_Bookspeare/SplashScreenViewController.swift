//
//  SplashScreenViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 11/06/24.
//

import UIKit
import FirebaseAuth

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    private func checkAuthenticationStatus()
    {
        if Auth.auth().currentUser != nil{
            navigateToMainScreen()
        }
        else
        {
            navigateToRegisterScreen()
        }
    }
    
    private func navigateToMainScreen()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainVC = storyboard.instantiateViewController(withIdentifier: "mainPage") as? UITabBarController
        {
            setRootViewController(mainVC)
        }
    }
    private func navigateToRegisterScreen()
    {
        let storyboard = UIStoryboard(name: "auth", bundle: nil)
        if let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterPage") as? RegisteredViewController
        {
            setRootViewController(registerVC)
        }
    }
    
    private func setRootViewController(_ viewController: UIViewController)
    {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else {
            return
        }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

}
