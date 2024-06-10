//
//  BookclubViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//



import UIKit
import FirebaseAuth
import FirebaseDatabase

class BookclubViewController: UIViewController , UICollectionViewDataSource {
    
    
    required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        self.tabBarItem.title = "Bookclubs"
        self.tabBarItem.image = UIImage(systemName: "person.3.fill")
    }
    
    
    @IBOutlet var exploreView1: UIView!
    
    @IBOutlet var exploreCollectionView: UICollectionView!
    
    @IBOutlet var bookclubSegmentedControl: UISegmentedControl!
    
    
    @IBOutlet var yourClubsView: UIView!
    
    
    @IBOutlet var chatCollectionView: UICollectionView!
    
    var bookclubsSection1 : [BookClub] = []
    


    
    
    
    
    
    
    
    func fetchExistingBookclubs()
    {
        let email = UserDefaults.standard.value(forKey: "email")
        let safeEmail = DataController.safeEmail(email: email as! String)
        DataController.shared.fetchBookClubs(forEmail: safeEmail) { [weak self] result in
            switch result {
            case .success(let bc):
                self?.bookclubsSection1.append(contentsOf: bc)
                self?.exploreCollectionView.reloadData() 
                
                 // Ensure the main bookclubs array is also updated
            case .failure(let error):
                print("Failed to fetch book clubs: \(error)")
            }
            
        }
    }
    
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
                return bookclubsSection1.count
            case 1:
                return DataController.shared.getBookclubs().count
            case 2:
                return DataController.shared.getBookclubs().count
            default:
                return 0
            }
        }
        else if collectionView == chatCollectionView
        {
            return DataController.shared.getGroupchat().count
        }
        else
        {
            return DataController.shared.getFilterButton().count
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == exploreCollectionView
        {
            
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "First", for: indexPath) as! FirstCell
                
                
                let bc = bookclubsSection1[indexPath.row]
                cell.bookclubName.text = bc.name
                // Convert integer to string for bookclubMembers
                cell.bookclubMembers.text = "\(String(describing: bc.members))"
                cell.bookclubDescription.text = bc.description
                if !bc.image.isEmpty {
                    // Fetch image from resources or URL based on imageName
                    cell.imageView.image = UIImage(named: bc.image)
                }
                
                cell.layer.cornerRadius = 10

              
                
                            cell.tapAction = { [weak self] in
                                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                                       }
                return cell
                
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Second", for: indexPath) as! SecondCell
                let bc = DataController.shared.getBookclub(with: indexPath.row)
                cell.bookclubName.text = bc.name
                // Convert integer to string for bookclubMembers
                cell.bookclubMembers.text = "\(String(describing: bc.members))"
                cell.bookclubDescription.text = bc.description
                if !bc.image.isEmpty {
                    // Fetch image from resources or URL based on imageName
                    cell.imageView.image = UIImage(named: bc.image)
                }
                
                cell.layer.cornerRadius = 10
                
                            cell.tapAction = { [weak self] in
                                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                                       }
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Third", for: indexPath) as! ThirdCell
                let bc = DataController.shared.getBookclub(with: indexPath.row)
                cell.bookclubName.text = bc.name
                // Convert integer to string for bookclubMembers
                cell.bookclubMembers.text = "\(String(describing: bc.members))"
                cell.bookclubDescription.text = bc.description
                if !bc.image.isEmpty {
                    // Fetch image from resources or URL based on imageName
                    cell.imageView.image = UIImage(named: bc.image)
                }
                cell.layer.cornerRadius = 10
                
                            cell.tapAction = { [weak self] in
                                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                                       }
                return cell
             
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "First", for: indexPath)
                return cell
            }
        }
        else if collectionView == chatCollectionView
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! BookclubChatCollectionViewCell
            
            
            let gc = DataController.shared.getGroupchat(with: indexPath.row)
            cell.bookclubName.text = gc.name
            cell.bookclubName.text = gc.name
            cell.bookclubDescription.text = "Misty: Hii Guys.." // Set a default value or fetch from your data source
            if !gc.profile.isEmpty {
                // Fetch image from resources or URL based on imageName
                cell.myImage.image = UIImage(named: gc.profile)
            }
                            cell.tapAction = { [weak self] in
                                           self?.performSegue(withIdentifier: "showDetailSegue", sender: indexPath)
                                       }
            return cell
        }
        else
        {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "buttonCell", for: indexPath) as! BookclubButtonCollectionViewCell
            cell.myButton.setTitle(DataController.shared.getFilterBc(with: indexPath.row).bookclubFilterButton, for: .normal)
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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchExistingBookclubs()
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
            let chatNib = UINib(nibName: "BookchatCardCollectionViewCell", bundle: nil)
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
                headerView.headerLabel.text = "Your Clubs"
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
    
    
    @IBAction func unwindToBookclubsViewController(_ segue: UIStoryboardSegue) {
    
        }
    
    
}


