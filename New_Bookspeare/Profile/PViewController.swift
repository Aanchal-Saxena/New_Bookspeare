//
//  ViewController.swift
//  profile
//
//  Created by Jasmine Agrawal on 19/05/24.
//

import UIKit

class PViewController: UIViewController {
    
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var profileImage: UIImageView!
    
    @IBOutlet var editButton: UIButton!
    
   
let cardData = [("Card 1", "one"), ("Card 2", "two"), ("Card 3", "three"), ("Card 2", "four"), ("Card 3", "five"), ("Card 3", "six"), ("Card 3", "seven"), ("Card 3", "harry")]
        
let cardTitles = ["S.G Prince ", "Percy Jackson", "SherlockHolmes", "A Discovery Of Witches", "The 5 AM Club","Shadow Born","Do Epic Shit","Harry Potter"]
        
override func viewDidLoad() {
super.viewDidLoad()
    
    
            collectionView.register(UINib(nibName: "CardCollectionView", bundle: nil), forCellWithReuseIdentifier: "PcardCell")
            
            // Collection view layer setup
            collectionView.layer.cornerRadius = 10
            collectionView.layer.masksToBounds = true
            collectionView.layer.shadowColor = UIColor.black.cgColor
            collectionView.layer.shadowOpacity = 0.5
            collectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
            collectionView.layer.shadowRadius = 4
            
            // Edit button setup
            editButton.layer.cornerRadius = 22
            editButton.layer.borderWidth = 1
            editButton.layer.borderColor = UIColor.systemPink.cgColor
            
            // Profile image setup
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true
            
            // Collection view delegate and data source setup
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }

    extension PViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return cardData.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! PCardCollectionViewCell
            let (_, imageName) = cardData[indexPath.item]
            cell.cardLabel?.text = cardTitles[indexPath.item]
            cell.cardName?.image = UIImage(named: imageName)
            
            // Apply corner radius to the image view
            cell.cardName.layer.cornerRadius = 10
            cell.cardName.layer.masksToBounds = true
            
            // Apply background color, border, and shadow to the cell's contentView
            cell.contentView.backgroundColor = .white
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = false
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 1.0).cgColor
            cell.contentView.layer.shadowColor = UIColor.black.cgColor
            cell.contentView.layer.shadowOpacity = 1.0
            cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.contentView.layer.shadowRadius = 4
            cell.contentView.layer.shadowPath = UIBezierPath(roundedRect: cell.contentView.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            cell.layer.cornerRadius = 10
            cell.layer.masksToBounds = false
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.5
            cell.layer.shadowOffset = CGSize(width: 0, height: 2)
            cell.layer.shadowRadius = 4
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            
            // Adjust spacing between two cells
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.minimumInteritemSpacing = 10
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
               // Adjust the spacing between two cards
               return 10 // You can adjust this value as needed
           }
           
    }
