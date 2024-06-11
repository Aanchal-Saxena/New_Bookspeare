//
//  EventsViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

    
class EventsViewController: UIViewController {
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.tabBarItem.title = "Events"
        self.tabBarItem.image = UIImage(systemName: "calendar.badge.clock")
    }
    
    @IBOutlet weak var quizView: UIView!
    
    @IBOutlet var buttonCollectionView: UICollectionView!
    
    @IBOutlet var cardCollectionView: UICollectionView!

    var eventsFetched: [Event] = []
    
    var filterButton: [EventFilter] =
    [
        EventFilter(eventFilterButton: "Debates"),
        EventFilter(eventFilterButton: "Meetups"),
        EventFilter(eventFilterButton: "Discussions"),
        EventFilter(eventFilterButton: "QNA"),
        EventFilter(eventFilterButton: "Recommendations"),
        EventFilter(eventFilterButton: "abcd"),
     
    ]
    
    
    
    
    func fetchExistingEvents() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            print("Failed to get user email.")
            return
        }
        
        let safeEmail = DataController.safeEmail(email: email)
        
        DataController.shared.fetchEvents(forEmail: safeEmail) { [weak self] events in
            guard let self = self else { return }
            if events.isEmpty {
                print("No events found.")
            } else {
                print("Fetched \(events.count) events.")
                for event in events {
                    print(event.toDictionary()) // Print event details
                }
                self.eventsFetched.append(contentsOf: events)
                // Reload UI or update collection view, etc.
            }
        }
    }

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExistingEvents()
        self.navigationItem.titleView?.isHidden = true
        buttonCollectionView.dataSource = self
        buttonCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.delegate = self
//        cardCollectionView.layer.masksToBounds = false
        
        
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
                quizView.addGestureRecognizer(tapGestureRecognizer)
                quizView.isUserInteractionEnabled = true
           
//           // Register cells with NIB files if they are created with XIB
//           let buttonNib = UINib(nibName: "ButtonCollectionViewCell", bundle: nil)
//           buttonCollectionView.register(buttonNib, forCellWithReuseIdentifier: "buttonCell")
           
           let cardNib = UINib(nibName: "EventCardCollectionViewCell", bundle: nil)
           cardCollectionView.register(cardNib, forCellWithReuseIdentifier: "eventCardCell")
       }
    
    
    @objc func viewTapped(_ sender: UITapGestureRecognizer) {
           // Handle the tap
           print("View was tapped!")
           if let tappedView = sender.view {
               tappedView.backgroundColor = tappedView.backgroundColor == .blue ? .green : .blue
           }
       }
   }









extension EventsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == buttonCollectionView {
            return filterButton.count
        } else {
            return eventsFetched.count
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
            
            let event = eventsFetched[indexPath.row]
            cell.eventTitle.text = event.title
                       cell.participantsLabel.text = "20+ Registered" // Set a default value or fetch from your data source
                       cell.typeLabel.text = "Virtual" // Set a default value or fetch from your data source
            if !event.images.isEmpty {
                // Fetch image from resources or URL based on imageName
                cell.myImage.image = UIImage(named: event.images)
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

