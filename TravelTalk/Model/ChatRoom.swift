//
//  ChatRoom.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/18/25.
//

import Foundation

/// 트래블톡 화면에서 사용할 데이터 구조체
struct ChatRoom {
    /// 채팅방 고유 ID
    let chatroomId: Int
    /// 채팅방 이미지
    let chatroomImage: String
    /// 채팅방 이름
    let chatroomName: String
    /// 채팅 화면에서 사용할 데이터
    var chatList: [Chat] = []
}

extension ChatRoom {
    var groupedChatList: [[Chat]] {
        let groupedDic = Dictionary(grouping: chatList) { $0.dateOnly }
        let sortedKeys = groupedDic.keys.sorted()
        let groupedArray = sortedKeys.compactMap { groupedDic[$0] }
        
        return groupedArray
    }
}
