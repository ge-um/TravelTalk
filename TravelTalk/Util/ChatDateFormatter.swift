//
//  ChatDateFormatter.swift
//  TravelTalk
//
//  Created by 금가경 on 7/19/25.
//

import Foundation

// TODO: - 이 형식이 최선일까? date를 formatting하는 formattedDateString 이런 함수는 차라리 string extension으로 빼는게 나을까? 근데 이런식으로 쓰면 그냥 lazy를 안써도되나?
final class ChatDateFormatter {
    static let shared = ChatDateFormatter()
    
    private init() {}
    
    private lazy var inputDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()

    private lazy var chatDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    private lazy var chatTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "HH:mm a"
        return formatter
    }()

    func format(from date: String, with format: ChatDateFormat) -> String {
        guard let date = inputDateFormatter.date(from: date) else { return "NO DATE"}
                
        switch format {
            
        case .date: return chatDateFormatter.string(from: date)
        case .time: return chatTimeFormatter.string(from: date)
        
        }
    }
}
