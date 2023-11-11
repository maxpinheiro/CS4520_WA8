//
//  ChatTableViewCell.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/9/23.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    var wrapperCellView: UIView!
    var label: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabel()
        
        initConstraints()
    }

    func setupWrapperCellView() {
        wrapperCellView = UITableViewCell()
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 10
        wrapperCellView.layer.borderWidth = 1
        wrapperCellView.layer.borderColor = UIColor.systemGray.cgColor
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 1.0
        wrapperCellView.layer.shadowOpacity = 0.3
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupLabel() {
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(label)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor,constant: 8),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            label.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 12),
            label.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 12),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),
            label.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -12),
            
            wrapperCellView.heightAnchor.constraint(greaterThanOrEqualTo: label.heightAnchor, constant: 24)
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

