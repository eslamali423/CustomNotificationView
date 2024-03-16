//
//  CustomNotificationView.swift
//  flyers
//
//  Created by Eslam Ali on 09/10/2023.
//

import UIKit
import Lottie
import AVFoundation
import AudioToolbox

public protocol CustomNotificationManager {
    func showPopup(title: String?, message: String, status: CustomNotificationView.Status )
}

public class CustomNotificationView: UIView, CustomNotificationManager {
    
    // MARK: - IBOutlets
    @IBOutlet weak private var overlayView: UIView!
    @IBOutlet weak private var backgroundView: UIView!
    @IBOutlet weak private var messageLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak private var topConstraint: NSLayoutConstraint!
    
    // MARK: - Variables
    public static let manager: CustomNotificationManager = CustomNotificationView()
    public enum Status: String {
        case warning
        case error
        case success
    }
    private var isLoaded = false
    private var animationView: LottieAnimationView?
    private var audioPlayer: AVAudioPlayer?
    private var config = CustomNotificationViewConfiguration.config
    private var hideMessageTimer: Timer?
    private var deinitMessageTimer: Timer?
    
    // MARK: - Initlizers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private Functions
    private func loadViewFromNib(window: UIWindow, message: String) {
        let bundle = Bundle(for: type(of: self))
        bundle.loadNibNamed(String(describing: CustomNotificationView.self), owner: self, options: nil)
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.frame = CGRect(x: 16, y: 50, width: Int(window.frame.width) - 32, height: 100)
        contentView.backgroundColor = .clear
        addSubview(contentView)
    }
    
    private func setupViews(title: String?, message: String, status: Status) {
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 25
        containerView.layer.cornerRadius = 25
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: -1, height: 1)
        containerView.layer.shadowRadius = 15
        
        titleLabel.font = config.titleFont
        messageLabel.font = config.messageFont
        
        switch status {
        case .success:
            containerView.backgroundColor = config.successNotificationBackgroundColor
            titleLabel.textColor = config.successTitleTextColor
            messageLabel.textColor =  config.successMessageTextColor
        case .error:
            containerView.backgroundColor = config.errorNotificationBackgroundColor
            titleLabel.textColor = config.errorTitleTextColor
            messageLabel.textColor =  config.errorMessageTextColor
        case .warning:
            containerView.backgroundColor = config.warningNotificationBackgroundColor
            titleLabel.textColor = config.warningTitleTextColor
            messageLabel.textColor =  config.warningMessageTextColor
        }
        if let title = title, !title.isEmpty {
            titleLabel.isHidden = false
            titleLabel.text = title
        } else {
            titleLabel.isHidden = true
        }
        messageLabel.text = message
        setupAnimation(status: status)
    }
}

// MARK: - Popup View
extension CustomNotificationView {
    
    public func showPopup(title: String? = nil, message: String, status: CustomNotificationView.Status ) {
        guard let window = UIApplication.shared.windows.first(where: \.isKeyWindow) else { return }
        guard !isLoaded else { return }
        deinitMessageTimer?.invalidate()
        addSwipeGesture(window)
        loadViewFromNib(window: window, message: message)
        window.addSubview(self)
        window.bringSubviewToFront(self)
        self.isHidden = false
        setupViews(title: title, message: message, status: status)
        showPopupWithAnimation()
        setupSound(status: status)
        setupVibration(status: status)
        hideMessageTimer = Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { [weak self] timer in
            guard let strongSelf = self else { return }
            guard strongSelf.isLoaded else { return }
            strongSelf.hidePopup(withAnimation: true)
        }
    }
    
    private func showPopupWithAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self ] in
            guard let strongSelf = self else { return }
            strongSelf.topConstraint.constant = 8
            strongSelf.layoutIfNeeded()
            strongSelf.isLoaded = true
        }
    }
    
    private func hidePopup(withAnimation: Bool) {
        guard isLoaded else { return }
        hideMessageTimer?.invalidate()
        deinitPopup()
        if withAnimation {
            UIView.animate(withDuration: 0.3) { [weak self ] in
                guard let strongSelf = self else { return }
                strongSelf.topConstraint.constant = -200
                strongSelf.layoutIfNeeded()
            }
        } else {
            self.topConstraint.constant = -200
        }
    }
    
    private func deinitPopup() {
        isLoaded = false
        deinitMessageTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] timer in
            guard let strongSelf = self else { return }
            strongSelf.removeFromSuperview()
            strongSelf.isHidden = true
        }
    }
}

// MARK: - Animation
extension CustomNotificationView {
    private func setupAnimation(status: Status) {
        var resourceFile: String
        var isDefaultAnimation: Bool
        switch status {
        case .warning:
            resourceFile = config.warningNotificationAnimationName ?? CustomNotificationViewConstants.LottieFiles.warning
            isDefaultAnimation = config.warningNotificationAnimationName == nil
        case .error:
            resourceFile = config.errorNotificationAnimationName ?? CustomNotificationViewConstants.LottieFiles.error
            isDefaultAnimation = config.errorNotificationAnimationName == nil
        case .success:
            resourceFile = config.successNotificationAnimationName ?? CustomNotificationViewConstants.LottieFiles.success
            isDefaultAnimation = config.successNotificationAnimationName == nil
        }
        
        playAnimation(resourceFile: resourceFile, isDefaultAnimation: isDefaultAnimation)
    }
    
    private func playAnimation(resourceFile: String, isDefaultAnimation: Bool ) {
        if isDefaultAnimation {
            guard let filePath = Bundle(for: CustomNotificationView.self).path(forResource: resourceFile, ofType: CustomNotificationViewConstants.LottieFiles.json) else  { return }
            animationView = .init(filePath: filePath)
        } else {
            animationView = .init(name: resourceFile)
        }
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        animationView?.animationSpeed = 1
        overlayView?.addSubview(animationView ?? UIView())
        configureAnimationConstraints()
        animationView?.play()
    }
    
    private func configureAnimationConstraints() {
        guard let animationView = animationView else { return }
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerYAnchor.constraint(equalTo: self.overlayView.safeAreaLayoutGuide.centerYAnchor),
            animationView.centerXAnchor.constraint(equalTo: self.overlayView.safeAreaLayoutGuide.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 50),
            animationView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: - Sound
extension CustomNotificationView {
    private func setupSound(status: CustomNotificationView.Status) {
        var soundName: String
        var soundExtension: String
        var isDefaultSound: Bool
        switch status {
        case .success:
            guard config.showSuccessNotificationWithSound  else { return }
            soundName = config.successNotificationSound?.soundName ?? CustomNotificationDefaultSounds.success.soundName
            soundExtension = config.successNotificationSound?.soundExtension ?? CustomNotificationDefaultSounds.success.soundExtension
            isDefaultSound = config.successNotificationSound == nil
            
        case .warning:
            guard config.showWarningNotificationWithSound  else { return }
            soundName = config.warningNotificationSound?.soundName ?? CustomNotificationDefaultSounds.warning.soundName
            soundExtension = config.warningNotificationSound?.soundExtension ?? CustomNotificationDefaultSounds.warning.soundExtension
            isDefaultSound = config.warningNotificationSound == nil
        case .error:
            guard config.showErrorNotificationWithSound  else { return }
            soundName = config.errorNotificationSound?.soundName ?? CustomNotificationDefaultSounds.error.soundName
            soundExtension = config.errorNotificationSound?.soundExtension ?? CustomNotificationDefaultSounds.error.soundExtension
            isDefaultSound = config.errorNotificationSound == nil
        }
        
        playSound(soundName: soundName, withExtension: soundExtension, isDefaultSound: isDefaultSound)
    }
    
    private func playSound(soundName: String, withExtension: String, isDefaultSound: Bool = true) {
        var filePath: URL?
        if isDefaultSound {
            guard let defaultSoundUrl = Bundle(for: CustomNotificationView.self).url(forResource: soundName, withExtension: withExtension) else { return }
            filePath = defaultSoundUrl
        } else {
            guard let soundUrl = Bundle.main.url(forResource: soundName, withExtension: withExtension) else { return }
            filePath = soundUrl
        }
        
        guard let filePath else { return }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}

// MARK: - Vibration
extension CustomNotificationView {
    private func setupVibration(status: CustomNotificationView.Status) {
        switch status {
        case .success:
            guard config.showSuccessNotificationWithVibration else { return }
            playVibration()
        case .warning:
            guard config.showWarningNotificationWithVibration else { return }
            playVibration()
        case .error:
            guard config.showErrorNotificationWithVibration else { return }
            playVibration()
        }
    }
    
    private func playVibration() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
    }
}

// MARK: - Swipe Gesture
extension CustomNotificationView {
    
    private func addSwipeGesture(_ window: UIWindow) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeGesture.direction = .up
        window.addGestureRecognizer(swipeGesture)
    }
    
    @objc func handleSwipeGesture(sender: UISwipeGestureRecognizer) {
        if sender.direction == .up {
            hidePopup(withAnimation: true)
        }
    }
}
