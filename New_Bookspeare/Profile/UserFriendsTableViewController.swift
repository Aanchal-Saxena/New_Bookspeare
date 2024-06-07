//
//  UserFriendsTableViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class UserFriendsTableViewController: UITableViewController {

    
   

    override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return DataController.shared.user.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let user = DataController.shared.getUser(with: indexPath.row)
            cell.update(with: user)
            return cell
        }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        print("Attempting to instantiate UserProfileViewController")
        if let userProfileVC = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController {
            print("Successfully instantiated UserProfileViewController")
            userProfileVC.user = user
            navigationController?.pushViewController(userProfileVC, animated: true)
        } else {
            print("Failed to instantiate UserProfileViewController")
        }
    }


        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                DataController.shared.removeUser(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            let movedUser = DataController.shared.removeUser(at: fromIndexPath.row)
            DataController.shared.addUser(user1: movedUser, at: to.row)
    
        }
        
        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    }
