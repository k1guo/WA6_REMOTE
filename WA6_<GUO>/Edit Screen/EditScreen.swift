//
//  EditScreen.swift
//  WA6_<GUO>
//
//  Created by 郭 on 2023/11/14.
//


import UIKit

class EditScreen: UIView {

    var textName:UITextField!
    var textEmail:UITextField!
    var textPhone:UITextField!
    var contentWrapper:UIScrollView!
    var buttonSave: UIButton!
    var largeImageView:UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        setupContentWrapper()
        setupLargeImageView()
        setuptextName()
        setuptextEmail()
        setuptextPhone()
        setupbuttonSave()
        initConstraints()
    }
      
    
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }

      
    func setupLargeImageView(){
        largeImageView = UIImageView()
        largeImageView.image = UIImage(named: "image")
        largeImageView.contentMode = .scaleAspectFill
        largeImageView.clipsToBounds = true
        largeImageView.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(largeImageView)
    }

    func setuptextName(){
        textName = UITextField()
        textName.placeholder = "Name"
        textName.borderStyle = .roundedRect
        textName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textName)
    }

    func setuptextEmail(){
        textEmail = UITextField()
        textEmail.placeholder = "Email Address"
        textEmail.borderStyle = .roundedRect
        textEmail.keyboardType = .numberPad
        textEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textEmail)
    }

    
    func setuptextPhone(){
        textPhone = UITextField()
        textPhone.placeholder = "Phone Number"
        textPhone.borderStyle = .roundedRect
        textPhone.keyboardType = .numberPad
        textPhone.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(textPhone)
    }
    
    func setupbuttonSave(){
        buttonSave = UIButton(type: .system)
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(buttonSave)
    }
      
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
        
            textName.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 32),
            textName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
         
            textEmail.topAnchor.constraint(equalTo: textName.bottomAnchor, constant: 8),
            textEmail.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            textPhone.topAnchor.constraint(equalTo: textEmail.bottomAnchor, constant: 8),
            textPhone.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            buttonSave.topAnchor.constraint(equalTo: textPhone.bottomAnchor,constant: 50),
            buttonSave.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            largeImageView.heightAnchor.constraint(equalToConstant: 800),
            largeImageView.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor),
            largeImageView.topAnchor.constraint(equalTo:textPhone.topAnchor, constant: 8),
            largeImageView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            largeImageView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
                    
        ])
    }
      
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
