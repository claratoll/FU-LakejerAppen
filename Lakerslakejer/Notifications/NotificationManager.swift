//
//  NotificationManager.swift
//  Lakerslakejer
//
//  Created by Julia Petersson  on 2023-05-23.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject{
    @Published private(set) var notifications: [UNNotificationRequest] = []
    //för de andra viewerna @StateObject private var notificationanager = NotificationManager()
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus(){
        
        UNUserNotificationCenter.current().getNotificationSettings{ settings in
            
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
            
        }
            
    }
    
    func requestAuthorization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
            
            
        }
    }
    
    //undrar om vi behöver reloadLocalNotifications då vi inte visa upp de nånstans
    
    func reloadLocalNotificatins(){
        UNUserNotificationCenter.current().getPendingNotificationRequests{ notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    
}
