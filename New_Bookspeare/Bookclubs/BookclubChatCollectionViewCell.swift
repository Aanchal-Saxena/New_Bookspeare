//
//  BookclubChatCollectionViewCell.swift
//  Register
//
//  Created by Batch-2 on 29/05/24.
//

import UIKit

class BookclubChatCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myImage: UIImageView!
    
    @IBOutlet var bookclubName: UILabel!
    
    @IBOutlet var bookclubDescription: UILabel!
    
    

    var tapAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        
      
        // Initialization code
        setupCell()
        setupGesture()
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        }

    
    
    private func setupGesture() {
            self.contentView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            self.contentView.addGestureRecognizer(tapGesture)
        }
        
        @objc private func handleTap() {
            tapAction?()
        }
    func setupCell() {
        contentView.backgroundColor = .white
                contentView.layer.cornerRadius = 10
                contentView.layer.masksToBounds = false
                contentView.layer.borderWidth = 0.4
                contentView.layer.borderColor = UIColor.gray.cgColor
                contentView.layer.shadowColor = UIColor.black.cgColor
                contentView.layer.shadowOpacity = 0.5
                contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
                contentView.layer.shadowRadius = 4
    }

    
   
    
   

}

