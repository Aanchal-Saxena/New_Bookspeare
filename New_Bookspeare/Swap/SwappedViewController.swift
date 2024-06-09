//
//  SwappedViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class SwappedViewController: UIViewController {
    
    
    // Outlet for cards
    @IBOutlet var cardCollectionView: UICollectionView!
    // Autoslider outlets
    @IBOutlet var sliderCollection: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!

    
    
       
    // Array for autoslider
    var currentcellIndex = 0
    
    
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register custom cell class for the card collection view
        cardCollectionView?.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cardCell")
        //card collection layer
        cardCollectionView?.layer.cornerRadius = 10
            cardCollectionView.layer.masksToBounds = true
        
        cardCollectionView.layer.cornerRadius = 10
        cardCollectionView.layer.shadowColor = UIColor.black.cgColor
        cardCollectionView.layer.shadowOpacity = 0.5
        cardCollectionView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardCollectionView.layer.shadowRadius = 4

        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        // Cornerradius and shadow for sliderCollection
        sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Adjust the leading constraint as needed
            sliderCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Adjust the trailing constraint as needed
        ])
        sliderCollection.layer.cornerRadius = 10
//        sliderCollection.layer.masksToBounds = false // Allow shadow to be visible
//        sliderCollection.layer.shadowColor = UIColor.black.cgColor
//        sliderCollection.layer.shadowOpacity = 0.5
//        sliderCollection.layer.shadowOffset = CGSize(width: 0, height: 0.5)
//        sliderCollection.layer.shadowRadius = 4
        sliderCollection.layer.shadowPath = UIBezierPath(roundedRect: sliderCollection.bounds, cornerRadius: 4).cgPath
        pageControl.numberOfPages = DataController.shared.getSlider().count
    }
            
    @objc func slideToNext() {
        if currentcellIndex < DataController.shared.getSlider().count - 1 {
            currentcellIndex += 1
        } else {
            currentcellIndex = 0
        }
        pageControl.currentPage = currentcellIndex
        
        UIView.transition(with: sliderCollection, duration: 0.5, options: .transitionCrossDissolve, animations: {
            if let visibleCell = self.sliderCollection.visibleCells.first as? AutoSliderCollectionViewCell {
                
                let sliders = DataController.shared.getSlider()
                    let currentIndex = self.currentcellIndex
                    if currentIndex < sliders.count {
                        let slider = sliders[currentIndex]
                        visibleCell.myImage.image = UIImage(named: slider.image)
                    } else {
                        print("Current index is out of bounds")
                    }
            }
        }, completion: nil)
        
        sliderCollection.scrollToItem(at: IndexPath(item: currentcellIndex, section: 0), at: .right, animated: true)
    }
}

// CollectionView cell
extension SwappedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollection {
            return DataController.shared.getSlider().count
        } else {
            return DataController.shared.getSwapBooks().count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AutoSliderCollectionViewCell
            let slider = DataController.shared.getSlider(with: indexPath.row)
            let img = slider.image
            cell.myImage.image = UIImage(named: img)
            return cell
        } else {
            let cell = cardCollectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
            let sw = DataController.shared.getSwapBook(with: indexPath.row)
            let imageName = sw.image
            cell.cardLabels?.text = sw.bookTitle
            cell.cardImages?.image = UIImage(named: imageName)
            // Apply corner radius to the image view
                   cell.cardImages.layer.cornerRadius = 10
                   cell.cardImages.layer.masksToBounds = true
            // Apply background color, border, and shadow to the cell's contentView
                    cell.contentView.backgroundColor = .white
                    cell.contentView.layer.cornerRadius = 10
                    cell.contentView.layer.masksToBounds = false
            cell.contentView.layer.borderWidth = 1.0
            cell.contentView.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 0.5).cgColor
                    cell.contentView.layer.shadowColor = UIColor.gray.cgColor
            cell.contentView.layer.shadowOpacity = 1.0
                    cell.contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
                    cell.contentView.layer.shadowRadius = 2
                    cell.contentView.layer.shadowPath = UIBezierPath(roundedRect: cell.contentView.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
            cell.layer.cornerRadius = 10
                    cell.layer.masksToBounds = false
                    cell.layer.shadowColor = UIColor.gray.cgColor
                    cell.layer.shadowOpacity = 0.5
                    cell.layer.shadowOffset = CGSize(width: 0, height: 2)
                    cell.layer.shadowRadius = 4
                    cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
                    
                    // Adjust spacing between two cells
                    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                    layout.minimumInteritemSpacing = 10
            
            
            
            
                       return cell
                   
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollection {
            return CGSize(width: sliderCollection.frame.width, height: sliderCollection.frame.height)
        } else {
            // Adjust cell size for cardCollectionView
            return CGSize(width: collectionView.bounds.width - 5, height: 150)
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           
           return 10
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
           // Adjust the section insets as needed
           return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
       }
   }

  

