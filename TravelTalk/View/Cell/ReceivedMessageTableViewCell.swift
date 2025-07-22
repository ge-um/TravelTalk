//
//  ReceivedMessageViewCell.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

class ReceivedMessageTableViewCell: UITableViewCell, CellProtocol {
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var messageBackgroundView: UIView!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    // MARK: - UI
    internal func configureUI() {
        configureProfileImageView()
        configureNameLabel()
        configureMessageLabel()
        configureDateLabel()
    }
    
    private func configureProfileImageView() {
        profileImageView.contentMode = .scaleAspectFit
    }
    
    private func configureNameLabel() {
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        messageLabel.numberOfLines = 0
    }
    
    private func configureMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        messageLabel.numberOfLines = 0
        configureMessageBackgroundView()
    }
    
    private func configureMessageBackgroundView() {
        messageBackgroundView.layer.cornerRadius = 10
        messageBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
        messageBackgroundView.layer.borderWidth = 1
    }
    
    private func configureDateLabel() {
        dateLabel.font = .systemFont(ofSize: 11, weight: .light)
    }
    
    // MARK: - Data
    internal func configureData(with data: Any) {
        let chat = data as! Chat
        
        print(#function)
        profileImageView.image = UIImage(named: chat.user.image)
        nameLabel.text = chat.user.name
        messageLabel.text = chat.message
        dateLabel.text = ChatDateFormatter.shared.format(from: chat.date, with: .time)
    }
}
