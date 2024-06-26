//
//  EventsInitialViewController.swift
//  Events
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit

class EventsInitialViewController: UIViewController {
    
    
    @IBOutlet var buttonCollectionView: UICollectionView!
    
    @IBOutlet var cardCollectionView: UICollectionView!
    
    
    var eventData : [Event] = [
        Event(title: "Book Event", images: "1"),
        Event(title: "Book Event", images: "eight"),
        Event(title: "Book Event", images: "five"),
        Event(title: "Book Event", images: "one"),
        ]
    
    
    
    var filterButton: [EventFilter] =
    [
        EventFilter(eventFilterButton: "Debates"),
        EventFilter(eventFilterButton: "Meetups"),
        EventFilter(eventFilterButton: "Discussions"),
        EventFilter(eventFilterButton: "QNA"),
        EventFilter(eventFilterButton: "Recommendations"),
        EventFilter(eventFilterButton: "abcd"),
     
    ]
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonCollectionView.dataSource = self
           buttonCollectionView.delegate = self
           cardCollectionView.dataSource = self
           cardCollectionView.delegate = self
           
//           // Register cells with NIB files if they are created with XIB
//           let buttonNib = UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
//           buttonCollectionView.register(buttonNib, forCellWithReuseIdentifier: "buttonCell")
           
           let cardNib = UINib(nibName: "EventCardCollectionViewCell", bundle: nil)
           cardCollectionView.register(cardNib, forCellWithReuseIdentifier: "eventCardCell")
       }
   }

extension EventsInitialViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == buttonCollectionView {
            return filterButton.count
        } else {
            return eventData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == buttonCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventButtonCell", for: indexPath) as! EventButtonCollectionViewCell
            cell.myButton.setTitle(filterButton[indexPath.row].eventFilterButton, for: .normal)
            cell.myButton.titleLabel?.numberOfLines = 1
            cell.myButton.titleLabel?.lineBreakMode = .byTruncatingTail
            cell.myButton.titleLabel?.textAlignment = .center
            cell.myButton.contentVerticalAlignment = .center
            cell.myButton.sizeToFit()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCardCell", for: indexPath) as! EventCardCollectionViewCell
            cell.eventTitle.text = eventData[indexPath.row].title
                       cell.participantsLabel.text = "20+ Registered" // Set a default value or fetch from your data source
                       cell.typeLabel.text = "Virtual" // Set a default value or fetch from your data source
            if let imageName = eventData[indexPath.row].images as String? {
                           cell.myImage.image = UIImage(named: imageName)
                       }
            
            cell.tapAction = { [weak self] in
                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                       }
                       return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == buttonCollectionView {
            let title = filterButton[indexPath.row].eventFilterButton
            let font = UIFont.systemFont(ofSize: 17)
            let tempLabel = UILabel()
            tempLabel.text = title
            tempLabel.font = font
            tempLabel.sizeToFit()
            let width = tempLabel.frame.width + 50
            return CGSize(width: width, height: collectionView.bounds.height)
        } else {
            return CGSize(width: collectionView.bounds.width - 20, height: 200)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // Adjust the section insets as needed
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
