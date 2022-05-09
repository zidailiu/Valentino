//
//  VLFeedInteractTableViewCell.swift
//  Valentino
//
//  Created by Liu John on 2022-03-16.
//

import UIKit

class VLFeedInteractTableViewCell: UITableViewCell {

    static let identifier = "VLFeedInteractTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure() {
        // configure the cell
    }

}
