//
//  CardCollectionViewCell.swift
//  profile
//
//  Created by Jasmine Agrawal on 27/05/24.
//

import UIKit

class PCardCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var cardImage: UIImageView!
    
    
    @IBOutlet weak var booksLabel: UILabel!
    
    
    
    
    
    @IBOutlet weak var cardLabel: UILabel!
    
    
    var tapAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
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
                    contentView.layer.masksToBounds = true
                    contentView.layer.borderWidth = 0.5
                    contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 0.5).cgColor //coralpink
                    self.layer.shadowColor = UIColor.black.cgColor
                    self.layer.shadowOpacity = 0.5
                    self.layer.shadowOffset = CGSize(width: 3, height: 3)
                    self.layer.shadowRadius = 4
                    self.layer.masksToBounds = false
                    //contentView.layer.shadowPath = UIBezierPath(roundedRect: contentView.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
                }
            }
    


