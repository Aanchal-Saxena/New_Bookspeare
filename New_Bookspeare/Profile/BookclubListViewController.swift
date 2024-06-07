//
//  BookclubListViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class BookclubListViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!

       
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
           return DataController.shared.getBookclubs().count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! BcListCollectionViewCell
           
           
           let bc = DataController.shared.getBookclub(with: indexPath.row)
           let imageName = bc.image
        
           cell.cardLabel?.text = bc.name
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
