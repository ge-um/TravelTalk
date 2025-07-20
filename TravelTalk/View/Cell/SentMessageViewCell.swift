//
//  SentMessageViewCell.swift
//  TravelTalk
//
//  Created by 금가경 on 7/20/25.
//

import UIKit

class SentMessageViewCell: UITableViewCell {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(with chat: Chat) {
        messageLabel.text = chat.message
        dateLabel.text = ChatDateFormatter.shared.format(from: chat.date, with: .time)
    }
}
