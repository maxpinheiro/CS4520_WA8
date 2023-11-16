//
//  MessageTableViewCell.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/13/23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView! // holds the timestamp and message
    var messageWrapper: UIView!
    var timeLabel: UILabel!
    var messageLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupComponents()
        initConstraints()
    }
    
    func setupComponents() {
        setupWrapperCellView()
        setupTimeLabel()
        setupMessageWrapper()
        setupMessageLabel()
        applySpecificStyles()
    }
    
    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupTimeLabel() {
        timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 12)
        timeLabel.numberOfLines = 0
        timeLabel.lineBreakMode = .byWordWrapping
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(timeLabel)
    }
    
    func setupMessageWrapper() {
        messageWrapper = UIView()
        messageWrapper.layer.cornerRadius = 12
        messageWrapper.layer.borderWidth = 1
        messageWrapper.layer.shadowColor = UIColor.gray.cgColor
        messageWrapper.layer.shadowOffset = .zero
        messageWrapper.layer.shadowRadius = 1.0
        messageWrapper.layer.shadowOpacity = 0.3
        messageWrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(messageWrapper)
    }
    
    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageWrapper.addSubview(messageLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            timeLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: wrapperCellView.centerXAnchor),
            
            messageWrapper.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            
            messageLabel.topAnchor.constraint(equalTo: messageWrapper.topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: messageWrapper.bottomAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: messageWrapper.leadingAnchor, constant: 14),
            messageLabel.trailingAnchor.constraint(equalTo: messageWrapper.trailingAnchor, constant: -14),
            
            messageWrapper.widthAnchor.constraint(equalTo: messageLabel.widthAnchor, constant: 28),
            messageWrapper.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, constant: -60),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 60)
        ])
        applySpecificConstraints()
    }

    // apply specific styles to each variant
    func applySpecificStyles() {}

    // apply left/right alignment to message wrapper
    func applySpecificConstraints() {}

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


