//
//  SearchEventCollectionViewCell.swift
//  Events
//
//  Created by Batch-2 on 27/05/24.
//

import UIKit

class SearchEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var searchImage: UIImageView!
    
    @IBOutlet weak var searchLabel: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        setupConstraints()
        setupCell()
        
//        // Set corner radius for the contentView
//        contentView.layer.cornerRadius = 10
//        contentView.layer.masksToBounds = true
//        
//        // Add shadow to cell
//        layer.shadowColor = UIColor.black.cgColor
//        layer.shadowOpacity = 0.2
//        layer.shadowOffset = CGSize(width: 0, height: 2)
//        layer.shadowRadius = 4
//        layer.masksToBounds = false
        
        // Set corner radius for the imageView
        searchImage.layer.cornerRadius = 10
        searchImage.layer.masksToBounds = true
        
        searchLabel.numberOfLines = 0
        searchLabel.lineBreakMode = .byWordWrapping
    }
    func setupCell() {
        // Apply corner radius, border, and shadow to the cell's contentView
        contentView.backgroundColor = .white
          contentView.layer.cornerRadius = 10
          contentView.layer.masksToBounds = true // Ensure content within contentView is clipped

          contentView.layer.borderWidth = 0.5
          contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 0.5).cgColor // Coral pink

          // Apply shadow to the cell's layer
          layer.shadowColor = UIColor.black.cgColor
          layer.shadowOpacity = 0.5
          layer.shadowOffset = CGSize(width: 3, height: 3)
          layer.shadowRadius = 4
          layer.masksToBounds = false // Ensure the shadow is not clipped

          // Define the shadow path for the cell's layer
          let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
          layer.shadowPath = shadowPath
        
        searchImage.contentMode = .scaleToFill
    }
    
    
    

}
