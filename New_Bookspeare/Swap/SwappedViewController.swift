//
//  SwappedViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class SwappedViewController: UIViewController {
    
    var swapBooks: [Swap] = []
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
        fetchExistingSwaps()
        // Register custom cell class for the card collection view
        cardCollectionView?.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cardCell")
        //card collection layer


        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        // Cornerradius and shadow for sliderCollection
        sliderCollection.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // Adjust the leading constraint as needed
            sliderCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // Adjust the trailing constraint as needed
        ])

        sliderCollection.layer.shadowPath = UIBezierPath(roundedRect: sliderCollection.bounds, cornerRadius: 4).cgPath
        pageControl.numberOfPages = DataController.shared.getSlider().count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSwap" {
            guard let indexPath = sender as? IndexPath else { return }
            let sw = swapBooks[indexPath.row]
            
            if let destinationVC = segue.destination as? SwapDetailViewController {
                destinationVC.swap = sw
            }
        }
    }

    
    
    func fetchExistingSwaps() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            print("Failed to get user email.")
            return
        }
        
        let safeEmail = DataController.safeEmail(email: email)
        
        DataController.shared.fetchSwaps(forEmail: safeEmail) { [weak self] swaps in
            guard let self = self else { return }
            if swaps.isEmpty {
                print("No swap books found.")
            } else {
                print("Fetched \(swaps.count) swap books.")
                for swap in swaps {
                    print(swap.toDictionary()) // Print swap details
                }
                self.swapBooks.append(contentsOf: swaps)
                self.cardCollectionView.reloadData()
                print("Reloaded collection view.")
            }
        }
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
            return DataController.shared.getSlider().count        } else {
            return swapBooks.count
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
            let sw = swapBooks[indexPath.row]
            let imageName = sw.image
            cell.cardLabels?.text = sw.bookTitle
            cell.cardImages?.image = UIImage(named: imageName)
            // Apply corner radius to the image view
                   cell.cardImages.layer.cornerRadius = 10
                   cell.cardImages.layer.masksToBounds = true
            // Apply background color, border, and shadow to the cell's contentView
                   
                    
                    // Adjust spacing between two cells
                    let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                    layout.minimumInteritemSpacing = 10
            
            
            cell.tapAction = { [weak self] in
                self?.performSegue(withIdentifier: "showDetail", sender: indexPath)
        }
            
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

  

