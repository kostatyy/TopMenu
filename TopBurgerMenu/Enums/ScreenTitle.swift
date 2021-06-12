//
//  ScreenTitle.swift
//  TopBurgerMenu
//
//  Created by Macbook Pro on 09.06.2021.
//

import Foundation

// MARK: - Screen (Sections) Titles
enum ScreentTitle: Int, CaseIterable, Equatable {
    case Profile, Groups, Chats, Friends, Settings
    
    var index: Int {
        return rawValue
    }
    var stringValue: String {
        return String(describing: self)
    }
}
