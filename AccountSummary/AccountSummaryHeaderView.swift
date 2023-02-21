//
//  AccountSummaryHeaderView.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 17/02/2023.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    
    struct ViewModelHeader {
        let welcomeMessage: String
        let name: String
        let date: Date
        
        var dateFormatted: String {
            return date.monthDayYearString
        }
    }

    let shakeyBellView = ShakeyBellView()
    
    let sunImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "sun.max.fill"))
        image.tintColor = .systemYellow
        image.image?.withTintColor(.yellow)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let appNameLabel: UILabel = {
       let label = UILabel()
        label.text = "MoneyApp"
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let welcomeLabel: UILabel = {
       let label = UILabel()
        label.text = "Good Morning"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Vladlen"
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel: UILabel = {
       let label = UILabel()
        label.text = "Feb 17 2023"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
      
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(sunImage)
        addSubview(appNameLabel)
        addSubview(welcomeLabel)
        addSubview(nameLabel)
        addSubview(dateLabel)
        addSubview(shakeyBellView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(viewModel: ViewModelHeader) {
      
            self.welcomeLabel.text = viewModel.welcomeMessage
            self.nameLabel.text = viewModel.name
            self.dateLabel.text = viewModel.dateFormatted
    }
}
extension AccountSummaryHeaderView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            sunImage.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            sunImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            sunImage.widthAnchor.constraint(equalToConstant: 85),
            sunImage.heightAnchor.constraint(equalToConstant: 85),
            
            appNameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 10),
            appNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            
            welcomeLabel.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor,constant: 10),
            welcomeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            
            nameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor,constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            dateLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
          //  dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
            
            shakeyBellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shakeyBellView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
}
