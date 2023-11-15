//
//  MessageTableViewCell.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/13/23.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView! // holds the timestamp and message
    var messageWrapper: UIStackView! // horizontal container for aligning the message left/right
    var messageBubble: UIView! // the actual message bubble
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
        setupMessageBubble()
        setupMessageLabel()
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
        messageWrapper = UIStackView()
        messageWrapper.axis = .horizontal
        messageWrapper.alignment = .leading
        messageWrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(messageWrapper)
    }

    func setupMessageBubble() {
        messageBubble = UIView()
        messageBubble.backgroundColor = .white
        messageBubble.layer.cornerRadius = 8
        messageBubble.layer.borderWidth = 1
        messageBubble.layer.borderColor = UIColor.systemGray.cgColor
        messageBubble.layer.shadowColor = UIColor.gray.cgColor
        messageBubble.layer.shadowOffset = .zero
        messageBubble.layer.shadowRadius = 1.0
        messageBubble.layer.shadowOpacity = 0.3
        messageBubble.translatesAutoresizingMaskIntoConstraints = false
        messageWrapper.addSubview(messageBubble)
    }
    
    func setupMessageLabel() {
        messageLabel = UILabel()
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        messageLabel.numberOfLines = 0
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageWrapper.addSubview(messageLabel)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            timeLabel.topAnchor.constraint(equalTo: wrapperCellView.topAnchor),
            timeLabel.centerXAnchor.constraint(equalTo: wrapperCellView.centerXAnchor),
            
            messageWrapper.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8),
            messageWrapper.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor),
            messageWrapper.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor),
            
            messageBubble.topAnchor.constraint(equalTo: messageWrapper.topAnchor),
            messageBubble.bottomAnchor.constraint(equalTo: messageWrapper.bottomAnchor),
            messageBubble.widthAnchor.constraint(equalTo: messageWrapper.widthAnchor, constant: -60),
            
            messageLabel.topAnchor.constraint(equalTo: messageBubble.topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: messageBubble.bottomAnchor, constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: messageBubble.leadingAnchor, constant: 12),
            messageLabel.trailingAnchor.constraint(equalTo: messageBubble.trailingAnchor, constant: -12),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 80)
        ])
        
    }

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


