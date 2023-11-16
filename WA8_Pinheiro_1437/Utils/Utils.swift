//
//  Utils.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import UIKit

/**
 Display an alert message within the specified controller.
 */
func showErrorAlert(_ error: String, controller: UIViewController) {
    let alert = UIAlertController(title: "Error:", message: error, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default))
    controller.present(alert, animated: true)
}

func organizeChatsForUser(chats: [Chat], currentUserName: String) -> [ChatDisplay] {
    var chatList = [ChatDisplay]()
    for chat in chats {
        let otherName = chat.source_user_name == currentUserName ? chat.target_user_name : chat.source_user_name
        let chatDisplay = ChatDisplay(otherUsername: otherName!, chat: chat)
        chatList.append(chatDisplay)
    }
    return chatList
}

func formatDate(date: Date, currDate: Date) -> String {
    let dateFormatter = DateFormatter()
    let calendar = Calendar.current
    let dateDay = calendar.component(.day, from: date)
    let currDay = calendar.component(.day, from: currDate)
    let dayDiff = currDay - dateDay
    // today
    if dayDiff == 0 {
        return "Today \(date.formatted(date: .omitted, time: .shortened))"
    }
    // yesterday
    if dayDiff == 1 {
        return "Yesterday \(date.formatted(date: .omitted, time: .shortened))"
    }
    // otherwise include date and time
    dateFormatter.setLocalizedDateFormatFromTemplate("EEEE, MMM d h:mm a")
    return dateFormatter.string(from: date)
}
