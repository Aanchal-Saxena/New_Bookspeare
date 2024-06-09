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
