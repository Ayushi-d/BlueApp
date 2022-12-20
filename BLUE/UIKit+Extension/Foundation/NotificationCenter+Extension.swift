//
//  NotificationCenter+Extension.swift
//  BLUE
//
//  Created by Bhikhu on 16/10/22.
//

import Foundation
extension Notification.Name {
    static let fundingTeamMember = Notification.Name("fundingTeamMember")
    static let fundingEdit = Notification.Name("fundingedit")
    static let confirmFundingDetails = Notification.Name("confirmfunding")
    static let profileContainerViewHeight = Notification.Name("profileContainerViewHeight")
    static let postNotificationToContainer = Notification.Name("postNotificationToContainer")
    static let postNotificationToChild = Notification.Name("postNotificationToChild")
    static let videoPauseOnFeed = Notification.Name("videoPauseOnFeed")
    static let refreshPage = Notification.Name("refreshPage")
    static let meetingDataAddUpdated = Notification.Name("meetingDataAddUpdated")
    static let favouriteDataUpdated = Notification.Name("favouriteDataUpdated")
    static let connectionRequestDataUpdated = Notification.Name("connectionRequestDataUpdated")
    static let notificationBadgeCountUpdated = Notification.Name("notificationBadgeCountUpdated")
}
