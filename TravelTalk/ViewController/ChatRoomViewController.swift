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
        chatRoomTableView.rowHeight = 150
    }
    
    func configure() {
        registerNib()
        configureTableView()
    }
    
    // MARK: - TableView Initialization
    private func registerNib() {
        print(self, #function)
        let nib = UINib(nibName: "ReceivedMessageViewCell", bundle: nil)
        chatRoomTableView.register(nib, forCellReuseIdentifier: "ReceivedMessageViewCell")
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
        let cell = chatRoomTableView.dequeueReusableCell(withIdentifier: "ReceivedMessageViewCell") as! ReceivedMessageViewCell

        cell.configureData(with: chatRoom.chatList[indexPath.row])
        return cell
    }
}
