//
//  CellProtocol.swift
//  TravelTalk
//
//  Created by 금가경 on 7/22/25.
//

import Foundation

@objc protocol CellProtocol: AnyObject {
    func configureData(with data: Any)
    @objc optional func configureUI()
}
