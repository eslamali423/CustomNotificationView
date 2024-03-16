# CustomNotificationView

Welcome to the CustomNotificationView documentation!

## Table of Contents

- [Introduction](#introduction)
- [Requirements](#requirements)
- [Installation](#installation)
- [Simple Usage](#simple-usage)
- [Customization](#customization)
- [Example](#example)
- [Author](#author)
- [License](#license)

## Introduction

Introducing CustomNotificationView: The ultimate in-app notification framework. With unparalleled customization options including fonts, colors, animations, and sounds, each message becomes a unique experience. Seamlessly integrate with just one line of code, specifying the message content and optional title. Messages elegantly appear from the top with captivating animations, automatically disappearing after a set time. Elevate your user engagement effortlessly with CustomNotificationView.

## Requirements
The CustomNotificationView requires Xcode 10.1 or later and is compatible with apps targeting iOS 13 or above.

## Installation   
You can easily integrate CustomNotificationView into your projects using one of the following methods:

**Method 1:**   
 **Swift Package Manager**

To integrate CustomNotificationView into your iOS project using Swift Package Manager, follow these simple steps:

- Open Your Project: In Xcode  
- open your project workspace or project file where you want to add the framework.  
- Go to the "File" menu.   
- Select "Swift Packages."  
- Choose "Add Package Dependency..."  
- Enter the Repository URL:  
```
https://github.com/eslamali423/CustomNotificationView.git
```
- Click "Next & Finish"  
- Build and Run:  
- Xcode will automatically resolve and fetch the framework package.  
- Build and run your project to start using CustomNotificationView in your application  

And that's it! You've successfully integrated CustomNotificationView into your project using Swift Package Manager. 🚀

---

**Method 2:**   
**Cocoapods**

To effortlessly integrate CustomNotificationView into your iOS project using CocoaPods, follow these straightforward steps:  
First you need to install cocaopods, Here's a comprehensive guide on how to install cocoapods [ Cocoapods documentation ](https://guides.cocoapods.org/using/getting-started.html)  

After installing the Cocoapods successfully  

- Open the Podfile in a text editor and add the following line.
```
 pod 'CustomNotificationView'
```

- Run the following command to install the framework and its dependencies:
 ```
 pod install
```
You can now import and use CustomNotificationView in your iOS project. Xcode will handle the linking and configuration.  
And that's it! You've successfully integrated CustomNotificationView into your project using CocoaPods. 🚀


## Simple Usage
   
- Import the CustomNotificationView framework at the top of your Swift file
```swift
 import CustomNotificationView
```
There are three types of notifications available: Success, Warning, and Error. and it allows you to specify the main message for your notification, while the title is optional.

**Success**
```swift
   CustomNotificationView.manager.showPopup( title: "Success title", message: "success message", status: .success)
```
```swift
   CustomNotificationView.manager.showPopup( message: "success message", status: .success)
```
**Warning**
```swift
   CustomNotificationView.manager.showPopup( title: "Warning title", message: "warning message", status: .warning)
```
```swift
   CustomNotificationView.manager.showPopup( message: "warning message", status: .warning)
```
**Error**
```swift
   CustomNotificationView.manager.showPopup( title: "Error title", message: "error message", status: .error)
```
```swift
   CustomNotificationView.manager.showPopup( message: "error message", status: .error)
```


## Customization

1. Open your app's (`AppDelegate.swift`) file.
- Import CustomNotificationView at the top of (`AppDelegate.swift`) using the following line of code

 ```swift
 import CustomNotificationView
```
 
2. To customize the appearance and behavior of `CustomNotificationView`, you can directly set the configuration within the `didFinishLaunchingWithOptions` method in your AppDelegate file. This may include customizing options such as fonts, background colors, text colors, sounds, vibrations, and animations for different types of notifications.

```swift
import UIKit
import CustomNotificationView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure CustomNotificationView
        CustomNotificationViewConfiguration.configure { config in
           // Your Configuration goas here
        }
        
        return true
    }
}
```
---
### Fonts 
- Customize the font styles for notification titles and messages to match your app's typography and branding.
```      
  /// Font for the notification title.
  config.titleFont = .systemFont(ofSize: 18, weight: .bold)
  /// Font for the notification message.
  config.messageFont = .systemFont(ofSize: 14, weight: .medium)
```
---
### Background Colors
- Define the background colors for different types of notifications (success, warning, error) to ensure consistency with your app's color scheme.
```
  /// Background color for success notifications. Default is white.
  config.successNotificationBackgroundColor = UIColor.systemGray6
  /// Background color for warning notifications. Default is white.
  config.warningNotificationBackgroundColor = UIColor.systemGray6
  /// Background color for error notifications. Default is white.
  config.errorNotificationBackgroundColor = UIColor.systemGray6
```
---
### Notification Title Text Color
- Specify the text colors for notification titles based on their types (success, warning, error) to enhance visual clarity and distinction.
```
  /// Title text color for success notification title. Default is custom green.
  config.successTitleTextColor = .systemGreen
  /// Title text color for warning notification title. Default is custom orange.
  config.warningTitleTextColor = .systemOrange
  /// Title text color for error notification title. Default is custom red.
  config.errorTitleTextColor = .systemRed
```
---
### Notification Message Text Color
- Set the text colors for notification messages based on their types (success, warning, error) to optimize readability and accessibility.
```
  /// Text color for success notification message. Default is dark gray.
  config.successMessageTextColor = .black
  /// Text color for warning notification message. Default is dark gray.
  config.warningMessageTextColor = .black
  /// Text color for error notification message. Default is dark gray.
  config.errorMessageTextColor = .black
```
---
### Enabling Sound
- Enable or disable sound effects for various types of notifications to provide auditory feedback to users.
```         
  /// Enables playing sound for success notifications. Default is false.
  config.showSuccessNotificationWithSound = true
  /// Enables playing sound for warning notifications. Default is false.
  config.showWarningNotificationWithSound = true
  /// Enables playing sound for error notifications. Default is false.
  config.showErrorNotificationWithSound = true
```
---
### Enabling Vibration
- Control the use of device vibrations for different types of notifications to offer tactile feedback and enhance user engagement.
```
   /// Enables vibration for success notifications. Default is false.
   config.showSuccessNotificationWithVibration = true
   /// Enables vibration for warning notifications. Default is false.
   config.showWarningNotificationWithVibration = true
   /// Enables vibration for error notifications. Default is false.
   config.showErrorNotificationWithVibration = true
 ```
---
### Animation Name
- Specify Lottie animation files to add visual interest and dynamism to the user experience. Please ensure that you provide the file name of the JSON containing the animation. You can download animation JSON files from [LottieFiles](https://lottiefiles.com)
```
  /// Specifies the name of the JSON file containing animation for success notifications.
  config.successNotificationAnimationName = "successLottie"
  /// Specifies the name of the JSON file containing animation for warning notifications.
  config.warningNotificationAnimationName = "warningLottie"
  /// Specifies the name of the JSON file containing animation for error notifications.
  config.errorNotificationAnimationName = "errorLottie"
```
---
### Custom Sound
Specify sound effects for various types of notifications to provide auditory feedback to users. To specify custom sound files for notifications, create an instance of the `CustomNotificationViewSound` model, providing the name of the sound file and its extension such as (mp3, wav).
```            
  /// - CustomNotificationViewSound Parameters:
  ///   - soundName: The name of the custom sound file.
  ///   - soundExtension: The extension of the custom sound file (e.g., "mp3", "wav").
  /// Specifies a custom sound for success notifications.
  config.successNotificationSound = CustomNotificationViewSound(soundName: "successSound", soundExtension: "mp3")
  /// Specifies a custom sound for warning notifications.
  config.warningNotificationSound = CustomNotificationViewSound(soundName: "warningSound", soundExtension: "mp3")
  /// Specifies a custom sound for error notifications.
   config.errorNotificationSound = CustomNotificationViewSound(soundName: "successSound", soundExtension: "mp3")
```

## Example
To run the example project and see CustomNotificationView in action 
-  Clone the repository from GitHub and don't forget to run `pod install`

## Author
CustomNotificationView is maintained by [Eslam Ali](https://www.linkedin.com/in/eslam-ali-423/).

If you have any questions, feedback, or suggestions for enhancements, please don't hesitate to reach out! I'm open to discussing any aspect of CustomNotificationView and welcome your input to make it even better.

Thank you for considering CustomNotificationView for your project!

Feel free to reach out directly via email at [eslam.ali4233@gmail.com](mailto:eslam.ali4233@gmail.com).

Your support and contributions are greatly appreciated!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
