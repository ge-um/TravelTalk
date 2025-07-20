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
    
    func configureData(with chat: Chat) {
        print(#function)
        profileImageView.image = UIImage(named: chat.user.image)
        nameLabel.text = chat.user.name
        messageLabel.text = chat.message
        dateLabel.text = ChatDateFormatter.shared.format(from: chat.date, with: .time)
    }
    
    private func configureUI() {
        configureProfileImageView()
        configureNameLabel()
        configureMessageLabel()
        configureDateLabel()
    }
    
    private func configureProfileImageView() {
        profileImageView.contentMode = .scaleAspectFit
    }
    
    private func configureNameLabel() {
        nameLabel.font = .systemFont(ofSize: 13, weight: .light)
        messageLabel.numberOfLines = 0
    }
    
    private func configureMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 13, weight: .light)
        messageLabel.layer.borderWidth = 1
        messageLabel.layer.borderColor = UIColor.systemGray.cgColor
        messageLabel.numberOfLines = 0
    }
    
    private func configureDateLabel() {
        dateLabel.font = .systemFont(ofSize: 11, weight: .light)
    }
}
