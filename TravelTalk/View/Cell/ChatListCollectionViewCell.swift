//
//  ChatListCollectionViewCell.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

class ChatListCollectionViewCell: UICollectionViewCell {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
//    }
    // MARK: - UI
    private func configureUI() {
        configureProfileImageView()
        configureNameLabel()
        configureMessageLabel()
        configureDateLabel()
    }
    
    private func configureProfileImageView() {
        profileImageView.contentMode = .scaleAspectFit
//        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    private func configureNameLabel() {
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        messageLabel.textColor = .darkGray
    }
    
    private func configureMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 15, weight: .medium)
        messageLabel.textColor = .darkGray
    }
    
    private func configureDateLabel() {
        dateLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = .systemGray
        dateLabel.textAlignment = .right
    }
    
    // MARK: - Data
    func configureData(with chatRoom: ChatRoom) {
        profileImageView.image = UIImage(named: chatRoom.chatroomImage)
        nameLabel.text = chatRoom.chatroomName
        
        let lastChatList = chatRoom.chatList.last!
        
        messageLabel.text = lastChatList.message
        dateLabel.text = ChatDateFormatter.shared.format(from: lastChatList.date, with: .date)
    }
}
