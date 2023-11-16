//
//  ViewController.swift
//  WA6_<GUO>
//
//  Created by 郭 on 2023/11/14.
//


import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let mainScreen = MainScreenView()
    var indexOfCell = Int()
    let notificationCenter = NotificationCenter.default
    var contactNames = [String]()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contacts JSON API"
        mainScreen.tableViewContacts.dataSource = self
        mainScreen.tableViewContacts.delegate = self
        mainScreen.tableViewContacts.separatorStyle = .none
        
        getAllContacts()
        notificationCenter.addObserver(
                   self,
                   selector: #selector(notificationReceivedForTextChanged(notification:)),
                   name: Notification.Name("textFromSecondScreen"),
                   object: nil)
        
        mainScreen.buttonAdd.addTarget(self, action: #selector(onButtonAddTapped), for: .touchUpInside)
    }
    
    @objc func notificationReceivedForTextChanged(notification: Notification){
        if let url = URL(string: APIConfigs.baseURL+"delete"){
            AF.request(url, method:.get,
                       parameters: ["name":self.contactNames[indexOfCell]],
                       encoding: URLEncoding.queryString)
            .responseString(completionHandler: { response in
                let status = response.response?.statusCode
                switch response.result{
                case .success(let data):
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                        case 200...299:
                            self.addANewContact(contact: notification.object as! Contact)
                            break
                        case 400...499:
                            print(data)
                            break

                        default:
                            print(data)
                            break
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }
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
    
    @objc func onButtonAddTapped(){
        if let name = mainScreen.textFieldAddName.text,
           let email = mainScreen.textFieldAddEmail.text,
           let phoneText = mainScreen.textFieldAddPhone.text{
            
            if !name.isEmpty && !email.isEmpty && !phoneText.isEmpty{
                if !isValidEmail(email){
                    showAlertText(text:"please enter valid email~~")
                }
                
                if !isValidPhone(phoneText){
                    showAlertText(text:"please enter valid phone number~~")
                }
                if let phone = Int(phoneText){
                    if  isValidEmail(email) && isValidPhone(phoneText){
                        let contact = Contact(name: name, email: email, phone: phone)
                        addANewContact(contact: contact)
                    }
                  
                }else{
                    
                }
            }else{
                showAlertText(text:"please enter all information~~")
            }
        }
    }
    
    func clearAddViewFields(){
        mainScreen.textFieldAddName.text = ""
        mainScreen.textFieldAddEmail.text = ""
        mainScreen.textFieldAddPhone.text = ""
    }
    
    func addANewContact(contact: Contact){
        if let url = URL(string: APIConfigs.baseURL+"add"){
            
            AF.request(url, method:.post, parameters:
                        [
                            "name": contact.name,
                            "email": contact.email,
                            "phone": contact.phone
                        ])
                .responseString(completionHandler: { response in
                    let status = response.response?.statusCode
                    switch response.result{
                    case .success(let data):
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                                case 200...299:
                                self.getAllContacts()
                                self.clearAddViewFields()
                                    break
                                case 400...499:
                                    print(data)
                                    break
                        
                                default:
                                    print(data)
                                    break
                            }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                })
        }else{
            //alert that the URL is invalid...
        }
    }


    func getAllContacts(){
        if let url = URL(string: APIConfigs.baseURL + "getall"){
            AF.request(url, method: .get).responseString(completionHandler: { response in
                let status = response.response?.statusCode
                switch response.result{
                case .success(let data):
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                                let names = data.components(separatedBy: "\n").sorted()
                                self.contactNames = names
                                self.contactNames.removeFirst()
                                self.mainScreen.tableViewContacts.reloadData()
                                print(self.contactNames,"getAllContacts()")
                                break
                            case 400...499:
                                print(data)
                                break
                            default:
                                print(data)
                                break
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }
    }
    

    func getContactDetails(name: String){
        if let url = URL(string: APIConfigs.baseURL+"details"){
            AF.request(url, method:.get,
                       parameters: ["name":name],
                       encoding: URLEncoding.queryString)
                .responseString(completionHandler: { response in
                let status = response.response?.statusCode
                switch response.result{
                case .success(let data):
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                                let detail = DisplayAContactController()
                                detail.received=data
                                self.navigationController?.pushViewController(detail, animated: true)
                                break
                    
                            case 400...499:
                                print(data)
                                break
                            default:
                                print(data)
                                break
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }
    }
    func editSelectedFor(contact: Int){
        print("Will edit \(contactNames[contact])")
        if let url = URL(string: APIConfigs.baseURL+"details"){
            AF.request(url, method:.get,
                       parameters: ["name":contactNames[contact]],
                       encoding: URLEncoding.queryString)
                .responseString(completionHandler: { response in
                let status = response.response?.statusCode
                switch response.result{
                case .success(let data):
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                                self.indexOfCell=contact
                                let edit = EditScreenController()
                                edit.received = data
                                self.navigationController?.pushViewController(edit, animated: true)
                                break
                            case 400...499:
                                print(data)
                                break
                            default:
                                print(data)
                                break
                        }
                    }
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            })
        }
    }
    
    func deleteSelectedFor(contact: Int){
        print("Will delete \(contactNames[contact])")
        let deleteAlert = UIAlertController(title: "Delete Alert!", message: "Are you sure you want to delete the contact ?", preferredStyle: .alert)
        let deleteAction = UIAlertAction(title:  "Sure", style: .cancel) { [self] (action) in
            
            if let url = URL(string: APIConfigs.baseURL+"delete"){
                AF.request(url, method:.get,
                           parameters: ["name":self.contactNames[contact]],
                           encoding: URLEncoding.queryString)
                .responseString(completionHandler: { response in
                    
                    let status = response.response?.statusCode
                    switch response.result{
                    case .success(let data):
                        if let uwStatusCode = status{
                            switch uwStatusCode{
                            case 200...299:

                                self.contactNames.remove(at: contact)
                                self.mainScreen.tableViewContacts.reloadData()
                                
                                print("delete success!")
                                
                                break
                            case 400...499:
                                print(data)
                                break
                                
                            default:
                                print(data)
                                break
                            }
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                })
            }
            
        }
        deleteAlert.addAction(deleteAction)
        deleteAlert.addAction(UIAlertAction(title: "Recall", style: .default))
        self.present(deleteAlert, animated: true)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "names", for: indexPath) as! ContactsTableViewCell

        cell.labelName.text = contactNames[indexPath.row]
        self.indexOfCell = Int(indexPath.row)
        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        buttonOptions.setImage(UIImage(systemName: "slider.horizontal.3"), for: .normal)
        buttonOptions.menu = UIMenu(title: "Edit/Delete?",
                                    children: [
                                        UIAction(title: "Edit",handler: {(_) in
                                            self.editSelectedFor(contact: indexPath.row)
                                        }),
                                        UIAction(title: "Delete",handler: {(_) in
                                            self.deleteSelectedFor(contact: indexPath.row)
                                        })
                                    ])
        cell.accessoryView = buttonOptions

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getContactDetails(name: self.contactNames[indexPath.row])
        
    }
}

