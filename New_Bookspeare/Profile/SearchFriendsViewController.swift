//
//  SearchFriendsViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 08/06/24.
//

import UIKit

class SearchFriendsViewController: UIViewController {
    
    private var users = [[String: String]]()
    private var hasFetched = false
    private var results = [[String: String]]()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//    
//    func searchBarButtonClicked(_ searchBar: UISearchBar)
//    {
//        guard let text = searchBar.text, !text.replacingOccurrences(of: " ", with: "").isEmpty else {
//            return
//        }
//        results.removeAll()
//        self.searchUsers(query: text)
//        
//    }
//    
//    
//    func searchUsers(query: String)
//    {
//        if hasFetched{
//            filterUsers(with: query)
//            
//        }
//        else {
//            DataController.shared.getAllUsers(completion: { [weak self] result in
//                switch result
//                {
//                case .success(let usersCollection):
//                    self?.hasFetched = true
//                    self?.users = usersCollection
//                    self?.filterUsers(with: query)
//                    
//                case .failure(let error):
//                    print("Failed to get users: \(error)")
//                }
//            })
//        }
//    
//    }
//    cell.label?.text = results[indexPath.row]["name"]
//    
//    func filterUsers(with term: String)
//    {
//        guard hasFetched else {
//            return
//        }
//        
//        var results: [[String: String]] = self.users.filter({
//            guard let name = $0["name"]?.lowercased() else
//            {
//                return false
//            }
//            return name.hasPrefix(term.lowercased())
//        })
//        self.results = results
//        
//    }
//    
//    func updateUI()
//    {
//        if results.isEmpty {
//            self.noResultsLabel.isHidden = false
//            self.tableView.isHidden = true
//        }
//        else
//        {
//            self.noResultsLabel.isHidden = true
//            self.tableView.isHidden = false
//            self.tableView.reloadData()
//
//        }
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//guard let currentUser = Auth.auth().currentUser else {
//        print("No current user found.")
//        return
//    }
//
//print("save button tapped called")
//
//let email = UserDefaults.standard.value(forKey: "email")
//print(email as Any)
//let safeEmail = DataController.safeEmail(email: email as! String)
//print(safeEmail)
//    
//    let newName = nameTextField.text
//    let newBio = bioTextField.text
//    let newPronouns = pronounsTextField.text
//print(newName as Any, newBio as Any, newPronouns!)
//    
//    // Call updateUser function to update the specified properties in the database
//DataController.shared.updateUser(withEmail: safeEmail, name: newName, bio: newBio, pronouns: newPronouns) { success in
//        if success {
//            print("updateUser calling")
//            print("User details updated successfully.")
//            // Perform any additional actions if needed
//        } else {
//            print("Failed to update user details.")
//        }
//    }



