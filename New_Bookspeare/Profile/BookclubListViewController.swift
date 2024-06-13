//
//  BookclubListViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class BookclubListViewController: UIViewController , UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!

    
    
    @IBOutlet weak var shelfName: UILabel!
    
    var bookshelfName: String = ""
    
    var booksOfShelf: [Book] = []
    
    var shelf: Bookshelf?
       
       override func viewDidLoad() {
           super.viewDidLoad()
           shelfName.text = shelfName.text
           
           guard collectionView != nil else {
               print("collectionView is nil")
               return
           }

           collectionView.register(UINib(nibName: "BcListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "card")
           
           // Collection view delegate and data source setup
           collectionView.delegate = self
           collectionView.dataSource = self

        
       }
       
       // UICollectionViewDataSource methods
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return booksOfShelf.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "card", for: indexPath) as! BcListCollectionViewCell
           
           
           let bc = booksOfShelf[indexPath.row]
           let imageName = bc.image
        
           cell.cardLabel?.text = bc.title
           cell.cardImage?.image = UIImage(named: bc.image)
           cell.hooked?.text = bc.hooked
           
           // Apply corner radius to the image view
           cell.cardImage.layer.cornerRadius = 10
           cell.cardImage.layer.masksToBounds = true
           
           let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
           layout.minimumInteritemSpacing = 10
           

           return cell
       }
       
       // UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width - 5, height: 500)
        }
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
           return 10
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           // Adjust the section insets as needed
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showBookshelf" {
            guard let indexPath = sender as? IndexPath else { return }
            let bookshelf = shelf
            
            if let destinationVC = segue.destination as? AddBookToShelfViewController {
                destinationVC.shelf = bookshelf
                destinationVC.index = Int(indexPath.row)
            }
        }
    }
    
    
    
    @IBAction func unwindToBookclubsList(_ segue: UIStoryboardSegue) {
    
        }
   }
