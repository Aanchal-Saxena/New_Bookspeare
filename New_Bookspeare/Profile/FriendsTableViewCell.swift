//
//  FriendsTableViewCell.swift
//  profile
//
//  Created by Jasmine Agrawal on 28/05/24.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
 
    override func awakeFromNib() {
           super.awakeFromNib()
           // Initialization code
       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)
           // Configure the view for the selected state
       }
       
       func update(with user: Users) {
           if let image = UIImage(named: user.image) {
               userImageView.image = image
           } else {
               userImageView.image = UIImage(systemName: "person.circle")
           }
           firstNameLabel.text = user.firstName
       }
   }
