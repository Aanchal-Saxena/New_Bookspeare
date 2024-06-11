//
//  SettingsViewController.swift
//  profile
//
//  Created by Jasmine Agrawal on 27/05/24.
//

import UIKit
import FirebaseAuth

struct Section {
    let title: String
    let options: [SettingsOption]
}

struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgroundColor: UIColor
    let handler: (() -> Void)
}

class SettingsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell.identifier")
        return table
    }()

    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
    }

    // Configure method for settings options
   func configure() {
        let customColor = UIColor(red: 1.0, green: 0.5647, blue: 0.5216, alpha: 1.0) // Custom color #FF9085

        models.append(Section(title: "Actions", options: [
            SettingsOption(title: "Notifications", icon: UIImage(systemName: "bell"), iconBackgroundColor: customColor) {
                print("Tapped Notifications")
            },
            SettingsOption(title: "Share Bookspeare", icon: UIImage(systemName: "square.and.arrow.up"), iconBackgroundColor: customColor) {
                print("Tapped Share Bookspeare")
            },
            SettingsOption(title: "Set up Reading Goal", icon: UIImage(systemName: "trophy"), iconBackgroundColor: customColor) {
                print("Tapped Set up Reading Goal")
            },
            SettingsOption(title: "Set an Event Reminder", icon: UIImage(systemName: "calendar"), iconBackgroundColor: customColor) {
                print("Tapped Set an Event Reminder")
            }
        ]))
        
        models.append(Section(title: "Support", options: [
            SettingsOption(title: "Get Help", icon: UIImage(systemName: "questionmark.circle"), iconBackgroundColor: customColor) {
                print("Tapped Get Help")
            },
            SettingsOption(title: "Send Feedback", icon: UIImage(systemName: "envelope"), iconBackgroundColor: customColor) {
                print("Tapped Send Feedback")
            },
            SettingsOption(title: "Privacy Policy", icon: UIImage(systemName: "lock.shield"), iconBackgroundColor: customColor) {
                print("Tapped Privacy Policy")
            }
        ]))
        
        models.append(Section(title: "Account", options: [
            SettingsOption(title: "Devices", icon: UIImage(systemName: "iphone"), iconBackgroundColor: customColor) {
                print("Tapped Devices")
            },
            SettingsOption(title: "Delete Account", icon: UIImage(systemName: "trash"), iconBackgroundColor: customColor) {
                print("Tapped Delete Account")
            },
            SettingsOption(title: "Log out", icon: UIImage(systemName: "arrow.backward.circle"), iconBackgroundColor: customColor) {
                print("Tapped Log out")
                let auth = FirebaseAuth.Auth.auth()
                try? auth.signOut()
                print(auth.currentUser)
                if auth.currentUser == nil{
                    self.navigateToRegisterScreen()
                }
                
            }
        ]))
    }
    
    
    
    private func navigateToRegisterScreen()
    {
        print("naviagtin to register")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerVC = storyboard.instantiateViewController(withIdentifier: "RegisterPage")
       
            setRootViewController(registerVC)
        
    }
    
    private func setRootViewController(_ viewController: UIViewController)
    {
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = viewController
        }
    }
    
 
    // UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell.identifier", for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
}
