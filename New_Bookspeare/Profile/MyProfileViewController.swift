//
//  MyProfileViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit
import FirebaseDatabase

class MyProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    var userEmail: String?
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
            self.tabBarItem.title = "Profile"
            self.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
        }
    
    
    @IBOutlet weak var numberOfShelf: UILabel!
    
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    

    
   
    @IBOutlet weak var bioLabel: UILabel!
    
   
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        numberOfShelf.text = "\(DataController.shared.getBookshelf().count) Shelves"
        fetchUserData()
        if let profileUrlString = UserDefaults.standard.value(forKey: "profile_picture_url") as? String,
               let profileUrl = URL(string: profileUrlString) {
                downloadImage(imageView: profileImage, url: profileUrl)
            } else {
                print("Error: Profile picture URL is not a valid string or could not be converted to URL.")
            }
       
        
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
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.contentMode = .scaleToFill
        reloadView()
        
    }
    
    func reloadView() {
        fetchUserData() // Fetch the latest user data
        
        if let profileUrlString = UserDefaults.standard.value(forKey: "profile_picture_url") as? String,
               let profileUrl = URL(string: profileUrlString) {
                downloadImage(imageView: profileImage, url: profileUrl)
            } else {
                print("Error: Profile picture URL is not a valid string or could not be converted to URL.")
    }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShelfDetail" {
            guard let indexPath = sender as? IndexPath else { return }
            //let bookClub = DataController.shared.getBookclub(with: indexPath.row)
            let bookshelfBook = DataController.shared.getBookshelf(with: indexPath.row).books
            
            if let destinationVC = segue.destination as? BookclubListViewController {
                destinationVC.booksOfShelf = bookshelfBook ?? [Book(title: "Percy Jackson & The Olympians: The Lightning Thief", author: "Rick Riordan", image: "", hooked: "If my life is going to mean anything, I have to live it myself.")]
                destinationVC.bookshelfName = DataController.shared.getBookshelf(with: indexPath.row).name
                destinationVC.shelf = DataController.shared.getBookshelf(with: indexPath.row)
            }
        }
    }

    
    
    func fetchUserData() {
        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
            print("No email found in UserDefaults.")
            return
        }
        
        let safeEmail = DataController.safeEmail(email: email)
        
        // Get references to the database paths
        let bioRef = Database.database().reference().child(safeEmail).child("bio")
        let nameRef = Database.database().reference().child(safeEmail).child("name")
        let pronounsRef = Database.database().reference().child(safeEmail).child("pronouns")
        let imageRef = Database.database().reference().child(safeEmail).child("image")
        
        // Fetch data from database
        bioRef.observeSingleEvent(of: .value) { snapshot in
            if let bio = snapshot.value as? String {
                // Bio fetched successfully

                self.updateBioLabel(with: bio)
                print("Bio: \(bio)")
            } else {
                print("Bio not found.")
            }
        }
        
        nameRef.observeSingleEvent(of: .value) { snapshot in
            if let name = snapshot.value as? String {
                // Name fetched successfully
                self.updateNameLabel(with: name)
                print("Name: \(name)")
            } else {
                print("Name not found.")
            }
        }
        
        
        pronounsRef.observeSingleEvent(of: .value) { snapshot in
            if let pronouns = snapshot.value as? String {
                // Pronouns fetched successfully
                print("Pronouns: \(pronouns)")
            } else {
                print("Pronouns not found.")
            }
        }
        
        imageRef.observeSingleEvent(of: .value) { snapshot in
                if let urlString = snapshot.value as? String, let url = URL(string: urlString) {
                    // Image URL fetched successfully
                    self.updateProfileImage(with: url)
                    print("Image URL: \(url)")
                } else {
                    print("Image URL not found.")
                }
        }
    }
    
    func updateProfileImage(with url: URL) {
        DispatchQueue.main.async {
            self.downloadImage(imageView: self.profileImage, url: url)
        }
    }
    
    func updateNameLabel(with name: String) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
        }
    }

    func updateBioLabel(with bio: String) {
        DispatchQueue.main.async {
            self.bioLabel.text = bio
        }
    }
    
    

    func reloadUserData() {
        fetchUserData() // Fetch the latest user data
    }
    
    @IBAction func unwindToMyProfileViewController(_ segue: UIStoryboardSegue) {
    
        }
        
       
    
//    func getImageUrl() {
//            guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
//                print("No email found in UserDefaults.")
//                return
//            }
//            let safeEmail = DataController.safeEmail(email: email)
//            let filename = safeEmail + "_profil_picture.png"
//            let path = "images/\(filename)"
//            
//            StorageManager.shared.downloadURL(for: path, completion: { [weak self] result in
//                guard let self = self else { return }
//                switch result {
//                case .success(let url):
//                    print("Image URL fetched: \(url)")
//                    self.downloadImage(imageView: self.profileImage, url: url)
//                case .failure(let error):
//                    print("Failed to get download url: \(error)")
//                }
//            })
//        }
    func downloadImage(imageView: UIImageView, url: URL)
    {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to download image data from download image func: \(error!.localizedDescription)")
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
            
        }).resume()
    }
    
    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataController.shared.getBookshelf().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PcardCell", for: indexPath) as! PCardCollectionViewCell
        let bc = DataController.shared.getBookshelf(with: indexPath.row)
        let imageName = bc.image
        cell.cardLabel?.text = bc.name
        cell.booksLabel?.text = "\(bc.books?.count ?? 0) Books"
        cell.cardImage?.image = UIImage(named: imageName)
        
        // Apply corner radius to the image view
        cell.cardImage.layer.cornerRadius = 10
        cell.cardImage.layer.masksToBounds = true
        
        cell.tapAction = { [weak self] in
            self?.performSegue(withIdentifier: "showShelfDetail", sender: indexPath)
        }
       
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
    
//    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
//        switch sender.selectedSegmentIndex {
//        case 0:
//            Label.text = "6 Clubs"
//        case 1:
//            Label.text = "4 Reading Status Lists"
//        default:
//            break
//        }
//    }
}
    




