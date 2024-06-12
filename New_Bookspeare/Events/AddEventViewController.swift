//
//  AddEventViewController.swift
//  New_Bookspeare
//
//  Created by Katyayani Singh on 12/06/24.
//

import UIKit
import EventKit
import EventKitUI
   
    
class AddEventViewController: UIViewController,EKEventEditViewDelegate  {
    let eventStore = EKEventStore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
    }
   
    
    @IBAction func addEventsButton(_ sender: Any) {
        switch EKEventStore.authorizationStatus(for: .event) {
                case .notDetermined:
                    eventStore.requestFullAccessToEvents { granted, error in
                        if granted {
                            print("Authorized")
                            DispatchQueue.main.async {
                                self.presentEventVC()
                            }
                        }
                    }
                case .authorized:
                    print("Authorized")
                    DispatchQueue.main.async {
                        self.presentEventVC()
                    }
                default:
                    break
                }
            }
            
            func presentEventVC() {
                let eventVC = EKEventEditViewController()
                eventVC.editViewDelegate = self
                eventVC.eventStore = eventStore
                
                let event = EKEvent(eventStore: eventVC.eventStore)
                //title
                event.title = "Sample Event"
                event.startDate = Date()
                eventVC.event = event
                self.present(eventVC, animated: true, completion: nil)
            }
            
            func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
                controller.dismiss(animated: true, completion: nil)
            }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
