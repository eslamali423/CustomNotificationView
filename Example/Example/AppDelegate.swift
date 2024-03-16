//
//  AppDelegate.swift
//  Example
//
//  Created by Eslam Ali on 16/03/2024.
//

import UIKit
import CustomNotificationView

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configureCustomNotificationView()
        return true
    }
    
    // MARK: - CustomNotificationView Configuration
    /// Configures the appearance and behavior of the custom notification view.
    private func configureCustomNotificationView() {
        CustomNotificationViewConfiguration.configure { config in
            // --- Fonts ---
            /// Font for the notification title.
            config.titleFont = .systemFont(ofSize: 18, weight: .bold)
            /// Font for the notification message.
            config.messageFont = .systemFont(ofSize: 14, weight: .medium)
            
            // --- Background Color ---
            /// Background color for success notifications. Default is white.
            config.successNotificationBackgroundColor = UIColor.systemGray6
            /// Background color for warning notifications. Default is white.
            config.warningNotificationBackgroundColor = UIColor.systemGray6
            /// Background color for error notifications. Default is white.
            config.errorNotificationBackgroundColor = UIColor.systemGray6
            
            // --- Title Color ---
            /// Title text color for success notification title. Default is custom green.
            config.successTitleTextColor = .systemGreen
            /// Title text color for warning notification title. Default is custom orange.
            config.warningTitleTextColor = .systemOrange
            /// Title text color for error notification title. Default is custom red.
            config.errorTitleTextColor = .systemRed
            
            // --- Message Color ---
            /// Text color for success notification message. Default is dark gray.
            config.successMessageTextColor = .black
            /// Text color for warning notification message. Default is dark gray.
            config.warningMessageTextColor = .black
            /// Text color for error notification message. Default is dark gray.
            config.errorMessageTextColor = .black
            
            // --- Sound ---
            /// Enables playing sound for success notifications. Default is false.
            config.showSuccessNotificationWithSound = true
            /// Enables playing sound for warning notifications. Default is false.
            config.showWarningNotificationWithSound = true
            /// Enables playing sound for error notifications. Default is false.
            config.showErrorNotificationWithSound = true
            
            // --- Vibration ---
            /// Enables vibration for success notifications. Default is false.
            config.showSuccessNotificationWithVibration = true
            /// Enables vibration for warning notifications. Default is false.
            config.showWarningNotificationWithVibration = true
            /// Enables vibration for error notifications. Default is false.
            config.showErrorNotificationWithVibration = true
            
            // --- Animation ---
            /// You can download Lottie animation files from https://lottiefiles.com and add them to your project.
            /// Specifies the name of the JSON file containing animation for success notifications.
            config.successNotificationAnimationName = "successLottie"
            /// Specifies the name of the JSON file containing animation for warning notifications.
            config.warningNotificationAnimationName = "warningLottie"
            /// Specifies the name of the JSON file containing animation for error notifications.
            config.errorNotificationAnimationName = "errorLottie"
            
            // --- Custom Sound ---
            /// - CustomNotificationViewSound Parameters:
            ///   - soundName: The name of the custom sound file.
            ///   - soundExtension: The extension of the custom sound file (e.g., "mp3", "wav").
            /// Specifies a custom sound for success notifications.
            config.successNotificationSound = CustomNotificationViewSound(soundName: "successSound", soundExtension: "mp3")
            /// Specifies a custom sound for warning notifications.
            config.warningNotificationSound = CustomNotificationViewSound(soundName: "warningSound", soundExtension: "mp3")
            /// Specifies a custom sound for error notifications.
            config.errorNotificationSound = CustomNotificationViewSound(soundName: "successSound", soundExtension: "mp3")
        }
    }
}

