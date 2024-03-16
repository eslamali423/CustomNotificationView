//
//  CustomNotificationDefaultSounds.swift
//  CustomNotificationView
//
//  Created by Eslam Ali on 14/03/2024.
//  Copyright © 2024 Macco. All rights reserved.
//

import Foundation


class CustomNotificationDefaultSounds {
   
   static var success: CustomNotificationViewSound =
   CustomNotificationViewSound( soundName: CustomNotificationViewConstants.Sounds.success,
                           soundExtension: CustomNotificationViewConstants.Sounds.mp3)
   static var warning: CustomNotificationViewSound =
   CustomNotificationViewSound( soundName: CustomNotificationViewConstants.Sounds.warning,
                           soundExtension: CustomNotificationViewConstants.Sounds.mp3)
   static var error: CustomNotificationViewSound =
   CustomNotificationViewSound( soundName: CustomNotificationViewConstants.Sounds.error,
                           soundExtension: CustomNotificationViewConstants.Sounds.mp3)
}

