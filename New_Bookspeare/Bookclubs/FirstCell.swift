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
        // Initialization code
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
