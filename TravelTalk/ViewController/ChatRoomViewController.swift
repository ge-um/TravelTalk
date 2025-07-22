//
//  ChatRoomViewController.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

class ChatRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var chatRoomTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    
    var chatRoom = ChatRoom(chatroomId: -1, chatroomImage: "", chatroomName: "")
    
    // TODO: - 패딩..어케줌..
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = .placeholderText
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    // TODO: - scrollToRow geometry 필요할까?
    override func viewDidAppear(_ animated: Bool) {
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
    
    private func configureTableView() {
        print(self, #function)
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
        chatRoomTableView.rowHeight = UITableView.automaticDimension
        chatRoomTableView.separatorColor = .clear
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
        let index = IndexPath(row: chatRoom.chatList.count-1, section: 0)
        chatRoomTableView.scrollToRow(at: index, at: .bottom, animated: true)
    }
    
    @IBAction func messageTextFieldTapped(_ sender: UITextField) {
        view.endEditing(true)
    }
    
    // MARK: - TableView Setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom.chatList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        let chatList = chatRoom.chatList[indexPath.row]
        
        switch chatList.user.name {
            
        case ChatList.me.name:
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "SentMessageTableViewCell") as! SentMessageTableViewCell
            cell.configureData(with: chatList)
            return cell

        default:
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "ReceivedMessageTableViewCell") as! ReceivedMessageTableViewCell
            cell.configureData(with: chatList)
            return cell
        }
    }
}
