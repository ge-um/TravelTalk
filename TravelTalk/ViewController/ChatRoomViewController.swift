//
//  ChatRoomViewController.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

class ChatRoomViewController: UIViewController {
    @IBOutlet var chatRoomTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    
    var chatRoom = ChatRoom(chatroomId: -1, chatroomImage: "", chatroomName: "")
    
    // MARK: - Component
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .placeholderText
        
        return button
    }()
    
    // TODO: - dateLabel 위로
    let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textAlignment = .center
        
        return label
    }()
    
    // MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // TODO: - scrollToRow geometry 필요할까?
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollToEnd()
    }
    
    private func configure() {
        registerNib()
        configureTableView()
        configureMessageTextField()
    }
    
    // MARK: - Initialization
    private func registerNib() {
        print(self, #function)
        let receivedMessageNib = UINib(nibName: "ReceivedMessageTableViewCell", bundle: nil)
        chatRoomTableView.register(receivedMessageNib, forCellReuseIdentifier: "ReceivedMessageTableViewCell")
        
        let sentMessageNib = UINib(nibName: "SentMessageTableViewCell", bundle: nil)
        chatRoomTableView.register(sentMessageNib, forCellReuseIdentifier: "SentMessageTableViewCell")
    }
    
    // MARK: - View UI
    // TODO: - textField같은것도 nib파일 분리가 되나?
    private func configureMessageTextField() {
        messageTextField.backgroundColor = .systemGray6
        messageTextField.placeholder = "메시지를 입력하세요"
        messageTextField.rightView = sendButton
        messageTextField.rightViewMode = .always
    }
    
    // MARK: - View Action
    private func scrollToEnd() {
        guard let lastSection = chatRoom.groupedChatList.indices.last else { return }
        let lastRow = chatRoom.groupedChatList[lastSection].count - 1
        
        let index = IndexPath(row: lastRow, section: lastSection)
        chatRoomTableView.scrollToRow(at: index, at: .bottom, animated: false)
    }
    
    @IBAction func messageTextFieldTapped(_ sender: UITextField) {
        view.endEditing(true)
    }
}

extension ChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    private func configureTableView() {
        print(self, #function)
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        chatRoomTableView.rowHeight = UITableView.automaticDimension
        chatRoomTableView.separatorColor = .clear
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return chatRoom.groupedChatList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom.groupedChatList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        let chat = chatRoom.groupedChatList[indexPath.section][indexPath.row]
        
        switch chat.user.name {
            
        case ChatList.me.name:
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "SentMessageTableViewCell") as! SentMessageTableViewCell
            cell.configureData(with: chat)
            return cell

        default:
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "ReceivedMessageTableViewCell") as! ReceivedMessageTableViewCell
            cell.configureData(with: chat)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let dateString = chatRoom.groupedChatList[section].first?.date, section != 0 else {
            return dateLabel
        }
        
        dateLabel.text = ChatDateFormatter.shared.format(from: dateString, with: .date)
        return dateLabel
    }
}
