//
//  CardCollectionViewCell.swift
//  Swap
//
//  Created by Katyayani Singh on 14/05/24.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardImages: UIImageView!
    
    @IBOutlet weak var cardLabels: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            setupCell()
        }

        func setupCell() {
            // Apply corner radius, border, and shadow to the cell's contentView
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 10
            contentView.layer.masksToBounds = false
            contentView.layer.borderWidth = 0.5
            contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 0.5).cgColor //coralpink
            contentView.layer.shadowColor = UIColor.black.cgColor
            contentView.layer.shadowOpacity = 0.5
            contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
            contentView.layer.shadowRadius = 4
            contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath

//            // Set up constraints for the card image
//            cardImages.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                cardImages.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0), // Adjust the leading constraint as needed
//                cardImages.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0), // Adjust the trailing constraint as needed
//                cardImages.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0), // Adjust the bottom constraint as needed
//                cardImages.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 0) // Adjust the top constraint as needed
//            ])
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            // Ensure that the shadow path is updated when the cell's layout changes
            contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        }
    }
