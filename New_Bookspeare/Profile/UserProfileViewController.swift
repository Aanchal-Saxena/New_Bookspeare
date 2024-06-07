//
//  UserProfileViewController.swift
//  New_Bookspeare
//
//  Created by Jasmine Agrawal on 05/06/24.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var user: User?
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var bioLabel: UILabel!
    
    override func viewDidLoad() {
           super.viewDidLoad()

           if let user = user {
               if let image = UIImage(named: user.image) {
                   profileImageView.image = image
               } else {
                   profileImageView.image = UIImage(systemName: "person.circle")
               }
               nameLabel.text = "\(user.firstName) \(user.lastName)"
               bioLabel.text = user.email
           }
       }
   }
