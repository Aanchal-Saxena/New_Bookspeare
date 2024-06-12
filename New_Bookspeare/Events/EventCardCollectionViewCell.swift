//
//  CardCollectionViewCell.swift
//  Events
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit

class EventCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var myImage: UIImageView!
    
    @IBOutlet var eventTitle: UILabel!
   
   
    @IBOutlet var participantsLabel: UILabel!
    
    @IBOutlet var typeLabel: UILabel!
    
    var tapAction: (() -> Void)?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCell()
            setupGesture()
            setupConstraints()
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
            contentView.layer.masksToBounds = true
            contentView.layer.borderWidth = 0.5
            contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 0.5).cgColor // Coral pink
            
            // Set up shadow for the cell
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 0.5
            self.layer.shadowOffset = CGSize(width: 3, height: 3)
            self.layer.shadowRadius = 4
            self.layer.masksToBounds = false
            
            // Apply corner radius to the image view
            myImage.layer.cornerRadius = 10
            myImage.layer.masksToBounds = true
        }
        
        func setupConstraints() {
            myImage.translatesAutoresizingMaskIntoConstraints = false
            eventTitle.translatesAutoresizingMaskIntoConstraints = false
            participantsLabel.translatesAutoresizingMaskIntoConstraints = false
            typeLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                // ImageView Constraints
                myImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                myImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                myImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                myImage.heightAnchor.constraint(equalToConstant: 150),
                myImage.widthAnchor.constraint(equalToConstant: 250),
                
                // TitleLabel Constraints
                eventTitle.topAnchor.constraint(equalTo: myImage.bottomAnchor, constant: 8),
                eventTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                eventTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                
                // ParticipantsLabel Constraints
                participantsLabel.topAnchor.constraint(equalTo: eventTitle.bottomAnchor, constant: 4),
                participantsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                participantsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                
                // TypeLabel Constraints
                typeLabel.topAnchor.constraint(equalTo: participantsLabel.bottomAnchor, constant: 4),
                typeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                typeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                typeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
            ])
        }
    }
