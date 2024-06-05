//
//  BookclubViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class BookclubViewController: UIViewController , UICollectionViewDataSource {
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.tabBarItem.title = "Bookclubs"
        self.tabBarItem.image = UIImage(systemName: "person.3.fill")
    }
    
    
    
    
    @IBOutlet var buttonCollectionView: UICollectionView!
    
    
    @IBOutlet var cardCollectionView: UICollectionView!
    
    @IBOutlet var exploreView: UIView!
    
    @IBOutlet var exploreView1: UIView!
    
    @IBOutlet var exploreCollectionView: UICollectionView!
    
    @IBOutlet var bookclubSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet var yourClubsView: UIView!
    
    
    @IBOutlet var chatCollectionView: UICollectionView!
    
    var groupchat : [GroupChat] =
    [
        GroupChat(name: "Potterheads", profile: "1"),
        GroupChat(name: "Riodenverse", profile: "eight"),
        GroupChat(name: "Mxtxers", profile: "five"),
        GroupChat(name: "Homies", profile: "one"),
        GroupChat(name: "Dead Poet Society", profile: "four"),
        GroupChat(name: "Cultivators", profile: "nine"),
        GroupChat(name: "Wizards", profile: "two"),
        GroupChat(name: "Rinakentverse", profile: "three"),
        GroupChat(name: "Potterheads", profile: "1"),
        GroupChat(name: "Riodenverse", profile: "eight"),
        GroupChat(name: "Mxtxers", profile: "five"),
        GroupChat(name: "Homies", profile: "one"),
        GroupChat(name: "Dead Poet Society", profile: "four"),
        GroupChat(name: "Cultivators", profile: "nine"),
        GroupChat(name: "Wizards", profile: "two"),
        GroupChat(name: "Rinakentverse", profile: "three"),
        
        
    ]
    
    
//    
//    func cellSelected(indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let SeeAllViewController = storyboard.instantiateViewController(withIdentifier: "SearchEventsViewController") as! SearchEventsViewController
//        SeeAllViewController.number = indexPath.row
//        navigationController?.pushViewController(SeeAllViewController, animated: true)
//    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == exploreCollectionView
        {
            return 3
        }
        else if collectionView == chatCollectionView
        {
            return 1
        }
        else
        {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == exploreCollectionView
        {
            switch section {
            case 0:
                return bookclubs.count
            case 1:
                return bookclubs.count
            case 2:
                return bookclubs.count
            default:
                return 0
            }
        }
        else if collectionView == chatCollectionView
        {
            return groupchat.count
        }
        else
        {
            return filterButton.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exploreCollectionView
        {
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "First", for: indexPath) as! FirstCell
                cell.bookclubName.text = bookclubs[indexPath.row].name
                cell.bookclubMembers.text = "200"
                cell.bookclubDescription.text = "Community for book lovers" // Set a default value or fetch from your data source
                if let imageName = bookclubs[indexPath.row].image as String? {
                    cell.imageView.image = UIImage(named: imageName)
                }
                cell.layer.cornerRadius = 10
                
                //            cell.tapAction = { [weak self] in
                //                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                //                       }
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Second", for: indexPath) as! SecondCell
                cell.bookclubName.text = bookclubs[indexPath.row].name
                cell.bookclubMembers.text = "200"
                cell.bookclubDescription.text = "Community for book lovers" // Set a default value or fetch from your data source
                if let imageName = bookclubs[indexPath.row].image as String? {
                    cell.imageView.image = UIImage(named: imageName)
                }
                cell.layer.cornerRadius = 10
                
                //            cell.tapAction = { [weak self] in
                //                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                //                       }
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Third", for: indexPath) as! ThirdCell
                cell.bookclubName.text = bookclubs[indexPath.row].name
                cell.bookclubMembers.text = "200"
                cell.bookclubDescription.text = "Community for book lovers" // Set a default value or fetch from your data source
                if let imageName = bookclubs[indexPath.row].image as String? {
                    cell.imageView.image = UIImage(named: imageName)
                }
                cell.layer.cornerRadius = 10
                
                //            cell.tapAction = { [weak self] in
                //                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                //                       }
                return cell
                //            switch indexPath.row {
                //            case 0:
                //                cell.button.addTarget(self, action: #selector(openFview), for: .touchUpInside)
                //            case 1:
                //                cell.button.addTarget(self, action: #selector(openSview), for: .touchUpInside)
                //            default:
                //                print("Failed")
                //            }
                //            return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "First", for: indexPath)
                return cell
            }
        }
        else if collectionView == chatCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! BookclubChatCollectionViewCell
                       cell.bookclubName.text = groupchat[indexPath.row].name
           
                                       cell.bookclubDescription.text = "Misty: Hii Guys.." // Set a default value or fetch from your data source
                       if let imageName = groupchat[indexPath.row].profile as String? {
                                           cell.myImage.image = UIImage(named: imageName)
                                       }
           
                //            cell.tapAction = { [weak self] in
                //                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                //                       }
                                       return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! BookclubButtonCollectionViewCell
                        cell.myButton.setTitle(filterButton[indexPath.row].bookclubFilterButton, for: .normal)
                                cell.myButton.titleLabel?.numberOfLines = 1
                                cell.myButton.titleLabel?.lineBreakMode = .byTruncatingTail
                                cell.myButton.titleLabel?.textAlignment = .center
                                cell.myButton.contentVerticalAlignment = .center
                                cell.myButton.sizeToFit()
                                return cell
                
        }
    }
    
    
    
    @IBAction func segmentedControlChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            yourClubsView.isHidden = false
            exploreView1.isHidden = true
            
            
        case 1:
            exploreView1.isHidden = false
            yourClubsView.isHidden = true
            
        default:
            break
            
            
            
        }
        
    }
    //
    
    var filterButton: [BookclubFilter] =
    [
        BookclubFilter(bookclubFilterButton: "Fiction"),
        BookclubFilter(bookclubFilterButton: "Non Fiction"),
        BookclubFilter(bookclubFilterButton: "Fantasy"),
        BookclubFilter(bookclubFilterButton: "Romance"),
        BookclubFilter(bookclubFilterButton: "YA"),
        BookclubFilter(bookclubFilterButton: "Literature")
        
    ]
    
    
    
    
    
    @IBSegueAction func createClub(_ coder: NSCoder) -> ClubsCreateViewController? {
        return ClubsCreateViewController(coder: coder, bookclub: nil)
    }
    
    
    
    @IBAction func unwindToCommunity(unwindSegue: UIStoryboardSegue)
    {
        guard unwindSegue.identifier == "saveUnwind",
              let sourceViewController = unwindSegue.source as? ClubsCreateViewController,
              let bookclub = sourceViewController.bookclub else { return }
        bookclubs.append(bookclub)
        exploreCollectionView.reloadData()
    }
    
    
    var bookclubs : [BookClub] = [
        BookClub(name: "Detectives club", image: "1", genre: "Fiction"),
        BookClub(name: "Homies", image: "eight", genre: "Fiction"),
        BookClub(name: "Potterheads", image: "five", genre: "Fiction"),
        BookClub(name: "Camp Half Blood", image: "one", genre: "Fiction")
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         buttonCollectionView.dataSource = self
//        cardCollectionView.dataSource = self
//        exploreCollectionView.dataSource = self
//        cardCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        chatCollectionView.dataSource = self
       chatCollectionView.collectionViewLayout = UICollectionViewFlowLayout()

            exploreView1.isHidden = true
            yourClubsView.isHidden = false
            
            let firstNib = UINib(nibName: "FirstCell", bundle: nil)
            exploreCollectionView.register(firstNib, forCellWithReuseIdentifier: "First")
            let secondNib = UINib(nibName: "SecondCell", bundle: nil)
            exploreCollectionView.register(secondNib, forCellWithReuseIdentifier: "Second")
            let thirdNib = UINib(nibName: "ThirdCell", bundle: nil)
            exploreCollectionView.register(thirdNib, forCellWithReuseIdentifier: "Third")
            let cardNib = UINib(nibName: "BookclubCardCollectionViewCell", bundle: nil)
            cardCollectionView.register(cardNib, forCellWithReuseIdentifier: "cardCell")
            let chatNib = UINib(nibName: "BookchatCardCollectionViewCell", bundle: nil)
            cardCollectionView.register(chatNib, forCellWithReuseIdentifier: "chatCell")
            exploreCollectionView.setCollectionViewLayout(generateLayout(), animated: true)
            chatCollectionView.setCollectionViewLayout(generateChatLayout(), animated: true)
            exploreCollectionView.dataSource = self
            exploreCollectionView.register(HeaderBookclubCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionView")
        }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionView", for: indexPath) as! HeaderBookclubCollectionReusableView
            
            switch indexPath.section{
            case 0:
                headerView.headerLabel.text = "Section 1"
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.addTarget(self, action: #selector(headerButtonTapped), for: .touchUpInside)
            case 1:
                headerView.headerLabel.text = "Section 2"
                headerView.button.setTitle("See All", for: .normal)
            case 2:
                headerView.headerLabel.text = "Section 3"
                headerView.button.setTitle("See All", for: .normal)
            default:
                headerView.headerLabel.text = "Default Header"
            }
            return headerView
        }
        fatalError("Unexpected element kind")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0:
                section = self.generateSection0()
            case 1:
                section = self.generateSection1()
            case 2:
                section = self.generateSection2()
            default:
                section = self.generateSection0()
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment:  .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
        return layout
        
    }
    
    func generateChatLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            section = self.generateChatbox()
            return section
        }
        return layout
    }
    
    func generateChatbox() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(85))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(294))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        //section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    func generateSection0() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    func generateSection1() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    func generateSection2() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(294))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)
        //section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    @objc func headerButtonTapped() {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "SearchEvent") as! SearchEventsViewController
//        navigationController?.pushViewController(viewController, animated: true)
       }
    
    
    
    
    
}


