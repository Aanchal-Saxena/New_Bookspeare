//
//  AutoSliderCollectionViewCell.swift
//  Swap
//
//  Created by Katyayani Singh on 11/05/24.
//

import UIKit

class AutoSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myImage: UIImageView!
        
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Apply corner radius to the cell
            layer.cornerRadius = 10
            layer.masksToBounds = true
        }
    }
