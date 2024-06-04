//
//  ButtonCollectionViewCell.swift
//  Events
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit

class EventButtonCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var myButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myButton.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 20.0
         
         // Add border
         self.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 1.0).cgColor
         self.layer.borderWidth = 1.0
         
         // Enable clipping to bounds to apply corner radius
         self.clipsToBounds = true
        
        // Apply corner radius to the cell
        layer.masksToBounds = true
    }
}
