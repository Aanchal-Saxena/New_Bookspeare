//
//  FriendsTableViewCell.swift
//  profile
//
//  Created by Jasmine Agrawal on 28/05/24.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    

    @IBOutlet weak var imageLabel: UILabel!
    
    @IBOutlet weak var firstNameLabel: UILabel!
    
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func update(with user: Users){
        imageLabel.text = user.image
        firstNameLabel.text = user.firstName
      
        
    }
    
}
