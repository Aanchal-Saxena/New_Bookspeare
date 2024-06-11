//
//  createNewListViewController.swift
//  New_Bookspeare
//
//  Created by Jasmine Agrawal on 11/06/24.
//

//import UIKit
//
//// Define the protocol at the top of the file
//protocol HookedViewControllerDelegate: AnyObject {
//    func didAddNewItem(listName: String, shortDescription: String)
//}
//
//class createNewListViewController: UIViewController, HookedViewControllerDelegate {
//    
//    @IBOutlet weak var bookshelfCollectionView: UICollectionView!
//    
//    var bookShelfData = [("Card 1", "hook"), ("Card 2", "two"), ("Card 3", "three"), ("Card 4", "four")]
//    var bookshelfTitle = ["Create new list","Want to Read", "Currently Reading", "Finished", "Did Not Finish"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Set the collection view delegate and data source
//        bookshelfCollectionView.delegate = self
//        bookshelfCollectionView.dataSource = self
//    }
//    
//    func didAddNewItem(listName: String, shortDescription: String) {
//        // Add new data to the data source
//        bookShelfData.append((listName, shortDescription))
//        
//        // Reload the collection view to reflect the new data
//        bookshelfCollectionView.reloadData()
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toHookedViewController" {
//            if let destinationVC = segue.destination as? hookedViewController {
//                destinationVC.delegate = self
//            }
//        }
//    }
//}
//
//extension createNewListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return bookShelfData.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = bookshelfCollectionView.dequeueReusableCell(withReuseIdentifier: "newListCell", for: indexPath) as! myNewCollectionViewCell
//        let bookData = bookShelfData[indexPath.row]
//        cell.bookshelfImage.image = UIImage(named: bookData.1)
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: bookshelfCollectionView.frame.width, height: bookshelfCollectionView.frame.height)
//    }
//}
