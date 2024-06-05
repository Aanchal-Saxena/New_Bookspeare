//
//  UserFriendsTableViewController.swift
//  New_Bookspeare
//
//  Created by Sahil Raj on 05/06/24.
//

import UIKit

class UserFriendsTableViewController: UITableViewController {

    
   var users: [Users] = [
    Users(firstName: "Ishika", lastName: "Chaudhary", email: "ishika0812@gmail.com", image: "ishika"),
                        Users(firstName: "Anuj", lastName: "Singh", email: "anuj0812@gmail.com", image: "anuj"),
                        Users(firstName: "Nitin", lastName: "Upreti", email: "nitin890812@gmail.com", image: "Nitin"),
                        Users(firstName: "Fahar", lastName: "Imran", email: "faharxx0812@gmail.com", image: "Fahar"),
                        Users(firstName: "Mohit", lastName: "Gupta", email: "mohit12@gmail.com", image: "Mohit"),
                        Users(firstName: "Divyansh", lastName: "Kaushik", email: "div90812@gmail.com", image: "Divyansh"),
                        Users(firstName: "Katyani", lastName: "Singh", email: "ishika0812@gmail.com", image: "Katyani"),
                        Users( firstName: "Shekhar", lastName: "Patel", email: "ishika0812@gmail.com", image: "Shekhar"),
                        Users(firstName: "Amit", lastName: "Saxena", email: "ishika0812@gmail.com", image: "Amit"),
                        Users( firstName: "Shruti", lastName: "Agrawal", email: "ishika0812@gmail.com", image: "Shruti"),
                        Users( firstName: "Arpita", lastName: "Gupta", email: "ishika0812@gmail.com", image: "Arpita"),
                        Users(firstName: "Peter", lastName: "Kapoor", email: "ishika0812@gmail.com", image: "Peter"),
                        Users(firstName: "Jasmine", lastName: "Sandals", email: "jas@gmail.com", image: "Jasmine"),
                        Users(firstName: "Prince", lastName: "Agrawal", email: "Prince@gmail.com", image: "Prince"),
                        Users(firstName: "Deepak", lastName: "Singhal", email: "deepak@gmail.com", image: "Deepak"),
                        Users(firstName: "Vaishali", lastName: "Goyal", email: "vaishali@gmail.com", image: "Vaishali"),
                        
                        
   ]

    override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return users.count
        }

        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as! FriendsTableViewCell
            let user = users[indexPath.row]
            cell.update(with: user)
            return cell
        }

        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let user = users[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let userProfileVC = storyboard.instantiateViewController(withIdentifier: "UserProfileViewController") as? UserProfileViewController {
                userProfileVC.user = user
                navigationController?.pushViewController(userProfileVC, animated: true)
            }
        }

        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                users.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            }
        }
        
        override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
            let movedUser = users.remove(at: fromIndexPath.row)
            users.insert(movedUser, at: to.row)
        }
        
        override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            tableView.reloadData()
        }
    }
