//
//  BookclubChatViewController.swift
//  Register
//
//  Created by Batch-2 on 29/05/24.
//

import UIKit

class BookclubChatViewController: UIViewController {
    
    
    
    @IBOutlet var view1: UIView!
    
    
    
    @IBOutlet var view2: UIView!
    
    
    
    @IBOutlet var label1: UILabel!
    
    @IBOutlet var chatCollectionView: UICollectionView!
    
    let imgCardData = [("1"), ("eight"), ("five"), ("one"), ("four"), ("nine"), ("two"), ("three"), ("1"), ("eight"), ("five"), ("one"), ("four"), ("nine"), ("two"), ("three")]
    let cardTitles = ["Pottergeads", "Demonic Cultivators", "Bookclub Name", "Lit Laurels", "S.G Prince ", "Percy Jackson", "SherlockHolmes", "A Discover", "Pottergeads", "Demonic Cultivators", "Bookclub Name", "Lit Laurels", "S.G Prince ", "Percy Jackson", "SherlockHolmes", "A Discover"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view2.isHidden = true
        
        let cardNib = UINib(nibName: "BookclubChatCollectionViewCell", bundle: nil)
        chatCollectionView.register(cardNib, forCellWithReuseIdentifier: "chatCell")
        
        chatCollectionView.dataSource = self
        chatCollectionView.delegate = self
        chatCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        let layout = UICollectionViewFlowLayout()
               layout.scrollDirection = .vertical
               layout.minimumLineSpacing = 10
               layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
               chatCollectionView.collectionViewLayout = layout

        // Do any additional setup after loading the view.
    }
    

    

    @IBAction func segmedtedControlChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            view2.isHidden = true
            view1.isHidden = false
            
            
        case 1:
            view1.isHidden = true
            view2.isHidden = false
            
        default:
            break
            
            
            
        }
        
    }
}


extension BookclubChatViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
            return imgCardData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! BookclubChatCollectionViewCell
                       cell.bookclubName.text = cardTitles[indexPath.item]
                      
                       cell.bookclubDescription.text = "Misty: Hii Guys.." // Set a default value or fetch from your data source
                       if let imageName = imgCardData[indexPath.item] as String? {
                           cell.myImage.image = UIImage(named: imageName)
                       }
            
//            cell.tapAction = { [weak self] in
//                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
//                       }
                       return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width - 10, height: 65)
        }
    

}

