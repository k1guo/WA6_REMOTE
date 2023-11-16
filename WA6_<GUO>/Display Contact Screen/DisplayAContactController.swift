//
//  DisplayAContactController.swift
//  WA6_<GUO>
//
//  Created by 郭 on 2023/11/14.
//

import UIKit

class DisplayAContactController: UIViewController {

    let displayContactScreen = DisplayAContact()
    var received : String?
    let notificationCenter = NotificationCenter.default

    
    override func loadView() {
        view = displayContactScreen
        let parts = received?.components(separatedBy: ",")
        if let uwNameInfo = parts?[0].trimmingCharacters(in: .whitespacesAndNewlines), let uwEmailInfo = parts?[1].trimmingCharacters(in: .whitespacesAndNewlines), let uwPhoneInfo = parts?[2].trimmingCharacters(in: .whitespacesAndNewlines){
            if !uwNameInfo.isEmpty && !uwEmailInfo.isEmpty && !uwPhoneInfo.isEmpty{
                if let phone = Int(uwPhoneInfo){
                    displayContactScreen.labelName.text="Name:\(uwNameInfo)"
                    displayContactScreen.labelEmail.text="Email:\(uwEmailInfo)"
                    displayContactScreen.labelPhone.text="Phone:\(phone)"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contact Details"
//        print(received ?? "false","success");
        
        notificationCenter.addObserver(
                   self,
                   selector: #selector(notificationReceivedForTextChanged(notification:)),
                   name: Notification.Name("textFromSecondScreen"),
                   object: nil)

    }
    
    @objc func notificationReceivedForTextChanged(notification: Notification){
        self.received = (notification.object as! String)
        print(notification,"display screen contact's data changed")
       }
}
