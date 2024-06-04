//
//  BookclubCardCollectionViewCell.swift
//  Register
//
//  Created by Batch-2 on 28/05/24.
//

import UIKit

class BookclubCardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var myImage: UIImageView!
    
    @IBOutlet var bookclubName: UILabel!
    
    @IBOutlet var bookclubDescription: UILabel!
    
    var tapAction: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
        setupConstraints()
        setupGesture()
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
        // Apply corner radius, border, and shadow to the cell's contentView
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = false
        contentView.layer.borderWidth = 0.5
        contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 0.5).cgColor //coralpink
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 3, height: 3)
        contentView.layer.shadowRadius = 4
        //contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }

    
    func setupConstraints() {
            myImage.translatesAutoresizingMaskIntoConstraints = false
            bookclubName.translatesAutoresizingMaskIntoConstraints = false
        bookclubDescription.translatesAutoresizingMaskIntoConstraints = false
        myImage.contentMode = .scaleToFill

            
        NSLayoutConstraint.activate([
                    // ImageView Constraints
                    myImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                    myImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                    myImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                    myImage.heightAnchor.constraint(equalToConstant: 150),
                    
                    // TitleLabel Constraints
                    bookclubName.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 8),
                    bookclubName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                    bookclubName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                    
                    // DescriptionLabel Constraints
                    bookclubDescription.topAnchor.constraint(equalTo: bookclubName.bottomAnchor, constant: 4),
                    bookclubDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
                    bookclubDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
                    bookclubDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }
    
    static func nib() -> UINib
    {
        return UINib(nibName: "BookclubCardCollectionViewCell", bundle: nil)
    }

}

