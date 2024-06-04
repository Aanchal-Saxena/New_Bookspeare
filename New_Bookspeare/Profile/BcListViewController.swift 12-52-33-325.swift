//
//  BcListViewController.swift
//  profile
//
//  Created by Jasmine Agrawal on 27/05/24.
//

import UIKit

class BcListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cardData = [("Card 1", "one"), ("Card 2", "two"), ("Card 3", "three"), ("Card 2", "four"), ("Card 3", "five"),("Card 3", "six"),("Card 3", "seven"),("Card 3", "harry"),("Card 3", "8"),("Card 3", "9"),("Card 3", "10"),("Card 3", "sorcerstone"),("Card 3", "chamber"),("Card 3", "Azkaban"),("Card 3", "goblet"),("Card 3", "order"),("Card 3", "prince")]
       
       let cardTitles = ["S.G Prince ", "Percy Jackson", "Sherlock Holmes", "A Discovery Of Witches", "The 5 AM Club","Shadow Born","Do Epic Shit","Harry Potter and the Deathly Hallows ","It Ends With Us","It Starts With Us","A Christmas Carol","Harry Potter and the Sorcerer's Stone","Harry Potter and the Chamber of Secrets","Harry Potter and the Prisoner of Azkaban ","Harry Potter and the Goblet of Fire","Harry Potter and the Order of Phoenix","Harry Potter and the Half-Blood Prince"]
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           guard collectionView != nil else {
               print("collectionView is nil")
               return
           }

           collectionView.register(UINib(nibName: "BcListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "card")
           
           // Collection view delegate and data source setup
           collectionView.delegate = self
           collectionView.dataSource = self

           // Configure layout
           let layout = UICollectionViewFlowLayout()
           layout.scrollDirection = .horizontal
           layout.minimumInteritemSpacing = 10
           layout.minimumLineSpacing = 20
           layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
           collectionView.collectionViewLayout = layout
       }
       
       // UICollectionViewDataSource methods
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return cardData.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! BcListCollectionViewCell
           let (_, imageName) = cardData[indexPath.item]
           cell.cardLabel?.text = cardTitles[indexPath.item]
           cell.cardImage?.image = UIImage(named: imageName)
           
           // Apply corner radius to the image view
           cell.cardImage.layer.cornerRadius = 10
           cell.cardImage.layer.masksToBounds = true
           
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
           
           return cell
       }
       
       // UICollectionViewDelegateFlowLayout methods
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let width = collectionView.bounds.height * 0.6
           let height = collectionView.bounds.height - 40
           return CGSize(width: width, height: height)
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 20
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }
   }
