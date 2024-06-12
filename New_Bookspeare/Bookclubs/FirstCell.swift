//
//  FirstCell.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class FirstCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookclubName: UILabel!
    @IBOutlet weak var bookclubDescription: UILabel!
    @IBOutlet weak var bookclubMembers: UILabel!

    var tapAction: (() -> Void)?
       
       override func awakeFromNib() {
           super.awakeFromNib()
           setupGesture()
           setupCell()
       }
       
       func setupCell() {
           // Apply corner radius, border, and shadow to the cell's contentView
           contentView.backgroundColor = .white
           contentView.layer.cornerRadius = 10
           contentView.layer.masksToBounds = true
           contentView.layer.borderWidth = 0.5
           contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 0.5).cgColor // Coral pink
           
           self.layer.shadowColor = UIColor.black.cgColor
           self.layer.shadowOpacity = 0.5
           self.layer.shadowOffset = CGSize(width: 3, height: 3)
           self.layer.shadowRadius = 4
           self.layer.masksToBounds = false
           
           // Apply corner radius to the image view
           imageView.layer.cornerRadius = 10
           imageView.layer.masksToBounds = true
       }
       
       private func setupGesture() {
           self.contentView.isUserInteractionEnabled = true
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
           self.contentView.addGestureRecognizer(tapGesture)
       }
       
       @objc private func handleTap() {
           tapAction?()
       }
   }
