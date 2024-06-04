//
//  BcListCollectionViewCell.swift
//  profile
//
//  Created by Jasmine Agrawal on 27/05/24.
//

import UIKit

class BcListCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cardImage: UIImageView!
    
    
    @IBOutlet weak var cardLabel: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           setupCell()
       }
       
       func setupCell() {
           // Apply corner radius, border, and shadow to the cell's contentView
           contentView.backgroundColor = .white
           contentView.layer.cornerRadius = 10
           contentView.layer.masksToBounds = false
           contentView.layer.borderWidth = 1.0
           contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 1.0).cgColor // FF9085
           contentView.layer.shadowColor = UIColor.black.cgColor
           contentView.layer.shadowOpacity = 0.5
           contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
           contentView.layer.shadowRadius = 4
           contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
       }
       
       override func layoutSubviews() {
           super.layoutSubviews()
           // Ensure that the shadow path is updated when the cell's layout changes
           contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
       }
   }
