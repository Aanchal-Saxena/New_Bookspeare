//
//  FirstBookclubCollectionViewCell.swift
//  Swap
//
//  Created by Sahil Raj on 01/06/24.
//

import UIKit

class FirstBookclubCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bookclubName: UILabel!
    @IBOutlet weak var bookclubDescription: UILabel!
    @IBOutlet weak var bookclubMembers: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
