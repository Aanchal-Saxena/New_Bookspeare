//
//  EventsSearchViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class EventsSearchViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    var number: Int = -1
   
    @IBOutlet var searchEvents: UISearchBar!
    
    
    
    
    @IBOutlet var searchCards: UICollectionView!


    var eventData : [Event] = [
        Event(title: "Book Event 1", images: "nine"),
        Event(title: "My Meetup", images: "two"),
        Event(title: "Debatees", images: "three"),
        Event(title: "Potterheads Competition", images: "four"),
        Event(title: "Do Epic Shit Motivation Session", images: "five"),
        Event(title: "The 5 AM Club Games", images: "six"),
        Event(title: "Recommendations", images: "seven"),
        Event(title: "Book Event 2", images: "eight")
        ]
    
    typealias CardData = (title: String, imageName: String)
    
    let cardData: [CardData] = [
        ("Event 1", "nine"),
        ("My Meetup", "two"),
        ("Debatees", "three"),
        ("A Discovery Of Witches Discussion", "four"),
        ("The 5 AM Club Games", "five"),
        ("Recommendations", "six"),
        ("Do Epic Shit Motivation Session", "seven"),
        ("Harry Potter Potterheads Competition", "eight")
    ]
    
    var filteredData: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchCards.dataSource = self
        searchCards.delegate = self
        searchEvents.delegate = self
        
        searchCards.register(UINib(nibName: "SearchEventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        filteredData = eventData
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        searchCards.collectionViewLayout = layout
    }
    
    // MARK: - Collection View Data Source Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchEventCollectionViewCell
        
        let card = eventData[indexPath.row]
        cell.searchLabel.text = card.title
    
        cell.searchImage.image = UIImage(named: card.images)
        
        return cell
    }
    
    // MARK: - Collection View Delegate Flow Layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        let labelHeight = heightForLabel(text: filteredData[indexPath.item].title, font: UIFont.systemFont(ofSize: 17), width: width)
        
        // Adjust the height as needed
        
        return CGSize(width: width, height: 106)
    }
    
    // Helper function to calculate the height of the label based on its content
    func heightForLabel(text: String, font: UIFont, width: CGFloat) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    // MARK: - Search Bar Delegate Methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = eventData
        } else {
            filteredData = eventData.filter { $0.title.range(of: searchText, options: .caseInsensitive) != nil }
        }
        
        searchCards.reloadData()
    }
}

