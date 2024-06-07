//
//  MyProfileViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class MyProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.tabBarItem.title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    @IBOutlet weak var bookshelfSegmentedcontrol: UIView!
    
    @IBOutlet weak var bookclubSegmentedControl: UIView!


    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
     
        
        // Edit button setup
        editButton.layer.cornerRadius = 22
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 1.0).cgColor // Custom color
        
        // Profile image setup
        func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            // Ensure the profile image view is circular
            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
            profileImage.clipsToBounds = true
        }
        
        //Collection View for Profile View Controller
        collectionView.register(UINib(nibName: "PCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PcardCell")
        // Collection view layer setup
        collectionView.layer.cornerRadius = 10
        collectionView.layer.masksToBounds = true
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.3
        collectionView.layer.shadowOffset = CGSize(width: 3, height: 2)
        collectionView.layer.shadowRadius = 2
        // Collection view delegate and data source setup
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataController.shared.getBookclubs().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PcardCell", for: indexPath) as! PCardCollectionViewCell
        let bc = DataController.shared.getBookclub(with: indexPath.row)
        let imageName = bc.image
        cell.cardLabel?.text = bc.name
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
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    
    //Share Button Pressed
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = profileImage.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender as? UIView
        present(activityController, animated: true, completion: nil)
    }
    
    
    //Segmented Control Setup
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            
        case 0:
        bookclubSegmentedControl.isHidden = false
        bookshelfSegmentedcontrol.isHidden = true
            
            
        case 1:
        bookshelfSegmentedcontrol.isHidden = false
        bookclubSegmentedControl.isHidden = true
            
        default:
            break
        }
    }
}
    




