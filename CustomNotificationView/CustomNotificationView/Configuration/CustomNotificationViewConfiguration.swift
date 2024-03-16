//
//  CustomNotificationViewConfiguration.swift
//  CustomNotificationView
//
//  Created by Eslam Ali on 08/03/2024.
//  Copyright © 2024 Macco. All rights reserved.
//

import UIKit

/// `CustomNotificationViewConfiguration` is a class designed to configure the appearance and behavior
/// of custom notification views across the application. It employs a Singleton pattern to ensure
/// consistent configurations are used throughout the app. This class allows customization of
/// various attributes including fonts, colors, sounds, and animations for different types of
/// notification such as success, warning, and error.
///
/// ## Example Usage
/// To customize your notification view configuration, you can use the `configure` method typically in
/// your application's AppDelegate. Below is an example of how you might customize various properties:
///
/// ```
/// CustomNotificationViewConfiguration.configure { config in
///     config.titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
///     config.messageFont = UIFont.systemFont(ofSize: 16, weight: .light)
///     config.successNotificationBackgroundColor = .green
///     config.warningNotificationBackgroundColor = .orange
///     config.errorNotificationBackgroundColor = .red
///     config.successTitleTextColor = .white
///     config.warningTitleTextColor = .white
///     config.errorTitleTextColor = .white
///     config.successMessageTextColor = .darkGray
///     config.warningMessageTextColor = .darkGray
///     config.errorMessageTextColor = .darkGray
///     // Additional customization here...
/// }
/// ```
///
/// This approach provides a clear and flexible way to configure the appearance and behavior of
/// your notification views, ensuring consistency throughout the application.

public class CustomNotificationViewConfiguration {
    // MARK: - Singelton
    public static var config = CustomNotificationViewConfiguration()
    
    // MARK: - variables
    // ---- Font ----
    public var titleFont: UIFont
    public var messageFont: UIFont
    // ---- Background Color ----
    public var successNotificationBackgroundColor: UIColor
    public var warningNotificationBackgroundColor: UIColor
    public var errorNotificationBackgroundColor: UIColor
    // ---- Title Text Color ----
    public var successTitleTextColor: UIColor
    public var warningTitleTextColor: UIColor
    public var errorTitleTextColor: UIColor
    // ---- Notification Text Color ----
    public var successMessageTextColor: UIColor = UIColor.black
    public var warningMessageTextColor: UIColor = UIColor.black
    public var errorMessageTextColor: UIColor = UIColor.black
    // ---- Sound ----
    public var showSuccessNotificationWithSound: Bool
    public var showWarningNotificationWithSound: Bool
    public var showErrorNotificationWithSound: Bool
    // ---- Vibration ----
    public var showSuccessNotificationWithVibration: Bool
    public var showWarningNotificationWithVibration: Bool
    public var showErrorNotificationWithVibration: Bool
    // ---- Custom Sound ----
    public var successNotificationSound: CustomNotificationViewSound?
    public var warningNotificationSound: CustomNotificationViewSound?
    public var errorNotificationSound: CustomNotificationViewSound?
    // ---- Custom Animation ----
    public var successNotificationAnimationName: String?
    public var warningNotificationAnimationName: String?
    public var errorNotificationAnimationName: String?
 
    // MARK: - init
    private init(builder: (CustomNotificationViewConfiguration) -> Void = { _ in }) {
        // Set default values
        // ---- Font ----
        titleFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        messageFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        // ---- Background Color ----
        successNotificationBackgroundColor = .white
        warningNotificationBackgroundColor = .white
        errorNotificationBackgroundColor = .white
        // ---- Title Text Color ----
        successTitleTextColor = UIColor.customGreenColor
        warningTitleTextColor = UIColor.customOrangeColor
        errorTitleTextColor = UIColor.customRedColor
        // ---- Message Text Color ----
        successMessageTextColor = .darkGray
        warningMessageTextColor = .darkGray
        errorMessageTextColor = .darkGray
        // ---- Vibration ----
        showSuccessNotificationWithVibration = false
        showWarningNotificationWithVibration = false
        showErrorNotificationWithVibration = false
        // ---- Sound ----
        showSuccessNotificationWithSound = false
        showWarningNotificationWithSound = false
        showErrorNotificationWithSound = false
        // Apply custom configuration
        builder(self)
    }

    // MARK: - Configuration Method
        /// Configures the `CustomNotificationViewConfiguration` singleton instance. This method accepts a closure
        /// that allows customization of the configuration properties. Intended to be called during app initialization,
        /// typically in the `AppDelegate`.
        ///
        /// - Parameter builder: A closure that takes the singleton configuration instance and allows for its customization.
    public static func configure(_ builder: (CustomNotificationViewConfiguration) -> Void) {
        CustomNotificationViewConfiguration.config = CustomNotificationViewConfiguration(builder: builder)
    }
}
