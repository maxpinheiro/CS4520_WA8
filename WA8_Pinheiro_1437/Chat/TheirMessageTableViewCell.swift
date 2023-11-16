//
//  TheirMessageTableViewCell.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/15/23.
//

import UIKit

class TheirMessageTableViewCell: MessageTableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func applySpecificStyles() {
        messageWrapper.backgroundColor = .systemGray5
        messageWrapper.layer.borderColor = UIColor.systemGray5.cgColor
        messageLabel.textColor = .black
    }

    override func applySpecificConstraints() {
        NSLayoutConstraint.activate([
            messageWrapper.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
