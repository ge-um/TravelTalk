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
    // TODO: - messageLabel로 만들어서 통일성 키우기
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    lazy var stringToDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd hh:mm"
        
        return formatter
    }()
    
    lazy var dateToStringFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - UI
    private func configureUI() {
        configureProfileImageView()
    }
    
    private func configureProfileImageView() {
        profileImageView.contentMode = .scaleAspectFit
    }
    
    // MARK: - Data
    func configureData(with chatRoom: ChatRoom) {
        profileImageView.image = UIImage(named: chatRoom.chatroomImage)
        nameLabel.text = chatRoom.chatroomName
        
        let lastChatList = chatRoom.chatList.last!
        
        contentLabel.text = lastChatList.message
        dateLabel.text = formattedDateString(from: lastChatList.date)
    }
    
    private func formattedDateString(from date: String) -> String {
        let dateString = stringToDateFormatter.date(from: date) ?? Date()
        return dateToStringFormatter.string(from: dateString)
    }
}
