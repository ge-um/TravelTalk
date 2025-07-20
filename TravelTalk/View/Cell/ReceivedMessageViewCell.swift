//
//  ReceivedMessageViewCell.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

class ReceivedMessageViewCell: UITableViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {
        
    }
    
    func configureData(with chat: Chat) {
        print(#function)
        nameLabel.text = chat.user.name
        messageLabel.text = chat.message
        dateLabel.text = ChatDateFormatter.shared.format(from: chat.date, with: .time)
    }
}
