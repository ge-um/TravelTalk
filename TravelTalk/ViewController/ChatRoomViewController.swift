//
//  ChatRoomViewController.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import UIKit

class ChatRoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var chatRoomTableView: UITableView!
    var chatRoom = ChatRoom(chatroomId: -1, chatroomImage: "", chatroomName: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        chatRoomTableView.rowHeight = 200
    }
    
    func configure() {
        registerNib()
        configureTableView()
    }
    
    // MARK: - Initialization
    private func registerNib() {
        print(self, #function)
        let receivedMessageNib = UINib(nibName: "ReceivedMessageViewCell", bundle: nil)
        chatRoomTableView.register(receivedMessageNib, forCellReuseIdentifier: "ReceivedMessageViewCell")
        
        let sentMessageNib = UINib(nibName: "SentMessageViewCell", bundle: nil)
        chatRoomTableView.register(sentMessageNib, forCellReuseIdentifier: "SentMessageViewCell")
    }
    
    private func configureTableView() {
        print(self, #function)
        chatRoomTableView.delegate = self
        chatRoomTableView.dataSource = self
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
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "SentMessageViewCell") as! SentMessageViewCell
            cell.configureData(with: chatList)
            return cell

        default:
            let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "ReceivedMessageViewCell") as! ReceivedMessageViewCell
            cell.configureData(with: chatList)
            return cell
        }
    }
}
