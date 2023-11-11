//
//  NotificationNames.swift
//  WA8_Pinheiro_1437
//
//  Created by Max Pinheiro on 11/6/23.
//

import Foundation
import UIKit

extension Notification.Name {
    static let signupSuccessful = Notification.Name("signupSuccessful")
    static let loginSuccessful = Notification.Name("loginSuccessful")
    static let logoutSuccessful = Notification.Name("logoutSuccessful")
    static let reloadNotes = Notification.Name("reloadNotes")
    static let deleteNote = Notification.Name("deleteNote")
    static let deleteSuccessful = Notification.Name("deleteSuccessful")
}
