//
//  DisplayAContact.swift
//  WA6_<GUO>
//
//  Created by 郭 on 2023/11/14.
//


import UIKit

class DisplayAContact: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

  
    var labelName:UILabel!
    var labelEmail:UILabel!
    var labelPhone:UILabel!
    var largeImageView:UIImageView!
    var contentWrapper:UIScrollView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupLargeImageView()
        setuplabelName()
        setuplabelEmail()
        setuplabelPhone()
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
    
    func setuplabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 16)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelName)
    }
    
    func setuplabelEmail(){
        labelEmail = UILabel()
        labelEmail.font = UIFont.boldSystemFont(ofSize: 16)
        labelEmail.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelEmail)
    }
    
    func setuplabelPhone(){
        labelPhone = UILabel()
        labelPhone.font = UIFont.boldSystemFont(ofSize: 16)
        labelPhone.translatesAutoresizingMaskIntoConstraints = false
        contentWrapper.addSubview(labelPhone)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            labelName.topAnchor.constraint(equalTo: contentWrapper.topAnchor,constant: 32),
            labelName.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
            labelEmail.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 8),
            labelEmail.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            labelPhone.topAnchor.constraint(equalTo: labelEmail.bottomAnchor, constant: 8),
            labelPhone.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            
            largeImageView.heightAnchor.constraint(equalToConstant: 800),
            largeImageView.widthAnchor.constraint(equalTo: contentWrapper.widthAnchor),
            largeImageView.topAnchor.constraint(equalTo:labelName.topAnchor, constant: 8),
            largeImageView.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            largeImageView.bottomAnchor.constraint(equalTo: contentWrapper.bottomAnchor),
    
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
