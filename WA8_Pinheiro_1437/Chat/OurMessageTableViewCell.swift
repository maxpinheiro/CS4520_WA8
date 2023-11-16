//
//  OurMessageTableViewCell.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/15/23.
//

import UIKit

class OurMessageTableViewCell: MessageTableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    override func applySpecificStyles() {
        messageWrapper.backgroundColor = .systemBlue
        messageWrapper.layer.borderColor = UIColor.systemBlue.cgColor
        messageLabel.textColor = .white
    }

    override func applySpecificConstraints() {
        NSLayoutConstraint.activate([
            messageWrapper.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
