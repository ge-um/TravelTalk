//
//  SentMessageViewCell.swift
//  TravelTalk
//
//  Created by 금가경 on 7/20/25.
//

import UIKit

// TODO: - 비슷한 셀인 경우에 함수를 재활용할수도 있을지.. ??
class SentMessageViewCell: UITableViewCell {
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var messageBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        configureMessageLabel()
        configureDateLabel()
    }
    
    private func configureMessageLabel() {
        messageLabel.font = .systemFont(ofSize: 14, weight: .regular)
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .right
        configureBackgroundView()
    }
    
    private func configureBackgroundView() {
        messageBackgroundView.layer.cornerRadius = 10
        messageBackgroundView.layer.borderColor = UIColor.systemGray.cgColor
        messageBackgroundView.layer.borderWidth = 1
        messageBackgroundView.backgroundColor = .systemGray5
    }
    
    private func configureDateLabel() {
        dateLabel.font = .systemFont(ofSize: 11, weight: .light)
    }
    
    func configureData(with chat: Chat) {
        messageLabel.text = chat.message
        dateLabel.text = ChatDateFormatter.shared.format(from: chat.date, with: .time)
    }
}
