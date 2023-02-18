//
//  AccountSummaryCell.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 17/02/2023.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    static let identifier = "AccountSummaryCell"
    
    let balanceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Banking"
        label.adjustsFontForContentSizeCategory = true
        label.font = .systemFont(ofSize: 18, weight: .medium)
        // label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let underlineViewLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        // view.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // view.widthAnchor.constraint(equalToConstant: 100).isActive = true
        view.backgroundColor = .systemBlue
        return view
    }()
    
    let noFeeAllinChequingLabel: UILabel = {
        let label = UILabel()
        label.text = "Account name"
        label.adjustsFontForContentSizeCategory = true
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Some balance"
        label.adjustsFontForContentSizeCategory = true
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var balanceAmountLabel: UILabel = {
        let label = UILabel()
       // label.text = "$929,466.63"
        label.attributedText = makeFormattedBalance(dollar: "929,466", cents: "63")
        label.adjustsFontForContentSizeCategory = true
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightArrowButtonImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "chevron.right"))
        image.tintColor = .systemBlue
        image.image?.withTintColor(.blue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private func makeFormattedBalance(dollar: String, cents: String) -> NSMutableAttributedString {
        
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote),.baselineOffset: 8]
        
        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollar, attributes: dollarAttributes)
        let centsString = NSAttributedString(string: cents, attributes: centAttributes)
        
        rootString.append(dollarString)
        rootString.append(centsString)
        
        return rootString
    }
    
  
    
    override func prepareForReuse() {
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(appNameLabel)
        contentView.addSubview(underlineViewLine)
        contentView.addSubview(noFeeAllinChequingLabel)
        contentView.addSubview(balanceLabel)
        contentView.addSubview(balanceAmountLabel)
        
        contentView.addSubview(balanceStackView)
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        
        contentView.addSubview(rightArrowButtonImage)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        NSLayoutConstraint.activate([
            
            appNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            appNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            
            underlineViewLine.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 10),
            underlineViewLine.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            underlineViewLine.heightAnchor.constraint(equalToConstant: 4),
            underlineViewLine.widthAnchor.constraint(equalToConstant: 90),
            
            noFeeAllinChequingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            noFeeAllinChequingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            balanceStackView.topAnchor.constraint(equalTo: underlineViewLine.bottomAnchor,constant: 8),
            balanceStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            balanceStackView.leadingAnchor.constraint(equalTo: noFeeAllinChequingLabel.trailingAnchor, constant: 10),
           // balanceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -25),
            
           // rightArrowButtonImage.centerYAnchor.constraint(equalTo: balanceStackView.centerYAnchor),
            rightArrowButtonImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            rightArrowButtonImage.topAnchor.constraint(equalTo: underlineViewLine.bottomAnchor, constant: 24),
            
        ])
    }
    
}
