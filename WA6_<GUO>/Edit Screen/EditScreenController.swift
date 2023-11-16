//
//  EditScreenController.swift
//  WA6_<GUO>
//
//  Created by 郭 on 2023/11/14.
//
import UIKit

class EditScreenController: UIViewController {
    
    let editScreenView = EditScreen()
  
    var received : String?
    
    let notificationCenter = NotificationCenter.default
    
    override func loadView() {
        view = editScreenView
        let parts = received?.components(separatedBy: ",")
        if let uwNameInfo = parts?[0].trimmingCharacters(in: .whitespacesAndNewlines), let uwEmailInfo = parts?[1].trimmingCharacters(in: .whitespacesAndNewlines), let uwPhoneInfo = parts?[2].trimmingCharacters(in: .whitespacesAndNewlines){
            if !uwNameInfo.isEmpty && !uwEmailInfo.isEmpty && !uwPhoneInfo.isEmpty{
                if let phone = Int(uwPhoneInfo){
                    editScreenView.textName.text="\(uwNameInfo)"
                    editScreenView.textEmail.text="\(uwEmailInfo)"
                    editScreenView.textPhone.text="\(phone)"
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        editScreenView.buttonSave.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
    }
    func isValidPhone(_ number:String) -> Bool{
        var res = false
        if number.count == 10{
            var num = (Double)(number)
            if let unwrap = num{
                res = true
            }
        }
        return res
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func showAlertText(text:String){
        let alert = UIAlertController(
            title: "Error!",
            message: "\(text)",
            preferredStyle: .alert
        )
            
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    @objc func saveTapped(){
        
        let name = editScreenView.textName.text
        let phone = editScreenView.textPhone.text
        let email = editScreenView.textEmail.text
        if let uwName = name, let uwPhone = phone, let uwEmail = email{
            if !uwName.isEmpty && !uwEmail.isEmpty && !uwPhone.isEmpty{
                if !isValidEmail(uwEmail){
                    showAlertText(text:"please enter valid email address~~")
                }
                if !isValidPhone(uwPhone){
                    showAlertText(text:"please enter valid phone number~~")
                }
                if let phone = Int(uwPhone){
                    
                    let editedContact = Contact(name: uwName, email: uwEmail, phone: phone)
                    notificationCenter.post(
                        name: Notification.Name("textFromSecondScreen"),
                        object: editedContact)
                    navigationController?.popViewController(animated: true)
                }
            }else{
                showAlertText(text:"please enter all information~~")
            }
        }
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
