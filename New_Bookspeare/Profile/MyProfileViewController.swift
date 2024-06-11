import UIKit
import FirebaseDatabase

// Define the protocol
protocol HookedViewControllerDelegate: AnyObject {
    func didAddNewItem(listName: String, shortDescription: String)
}

class MyProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HookedViewControllerDelegate {
    
    var userEmail: String?
    
    var bookShelfData = [("Card 1", "hook"), ("Card 2", "two"), ("Card 3", "three"), ("Card 4", "four")]
    var bookshelfTitle = ["Create new list", "Want to Read", "Currently Reading", "Finished", "Did Not Finish"]
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var editButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bookclubSegmentedControl: UIStackView!
    @IBOutlet weak var bookshelfSegmentedControl: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData()
        if let profileUrlString = UserDefaults.standard.value(forKey: "profile_picture_url") as? String,
           let profileUrl = URL(string: profileUrlString) {
            downloadImage(imageView: profileImage, url: profileUrl)
        } else {
            print("Error: Profile picture URL is not a valid string or could not be converted to URL.")
        }
        Label.text = "BookClubs"
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        // Edit button setup
        editButton.layer.cornerRadius = 22
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 1.0).cgColor // Custom color
        
        // Profile image setup
        func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
//            // Ensure the profile image view is circular
//            profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
//            profileImage.clipsToBounds = true
        }
        
        // Collection View for Profile View Controller
        collectionView.register(UINib(nibName: "PCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PcardCell")
        // Collection view layer setup
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    @IBAction func unwindToMyProfileViewController(_ segue: UIStoryboardSegue) {}
    
    func downloadImage(imageView: UIImageView, url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { data, _, error in
            guard let data = data, error == nil else {
                print("Failed to download image data from download image func: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                imageView.image = image
            }
        }).resume()
    }
    
    // HookedViewControllerDelegate method
    func didAddNewItem(listName: String, shortDescription: String) {
        // Add new data to the data source
        bookShelfData.append((listName, shortDescription))
        
        // Reload the collection view to reflect the new data
        collectionView.reloadData()
    }
    
    // UICollectionViewDataSource methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookShelfData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PcardCell", for: indexPath) as! PCardCollectionViewCell
        let bookData = bookShelfData[indexPath.row]
        cell.cardLabel?.text = bookData.0
        cell.cardName?.image = UIImage(named: bookData.1)
        
        // Apply corner radius to the image view
        cell.cardName.layer.cornerRadius = 10
        cell.cardName.layer.masksToBounds = true
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    // Share Button Pressed
    @IBAction func shareButtonPressed(_ sender: Any) {
        guard let image = profileImage.image else { return }
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    
    @IBAction func segmentedControlPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
         bookclubSegmentedControl.isHidden = false
            bookshelfSegmentedControl.isHidden = true
            
            
        case 1:
           bookshelfSegmentedControl.isHidden = false
       bookclubSegmentedControl.isHidden = true
        default:
            break
        }
    }

}
