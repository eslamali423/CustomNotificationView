//
//  ViewController.swift
//  Example
//
//  Created by Eslam Ali on 16/03/2024.
//

import UIKit
import CustomNotificationView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - IBActions
    @IBAction func successButtonAction(_ sender: Any) {
        let successMessage = "Your action has been completed successfully."
        CustomNotificationView.manager.showPopup(title: "Success!",
                                                 message: successMessage,
                                                 status: .success)
    }
    
    @IBAction func warningButtonAction(_ sender: Any) {
        let warningMessage = "Please proceed with caution. This action may have unintended consequences."
        CustomNotificationView.manager.showPopup(title: "Warning!",
                                                 message: warningMessage,
                                                 status: .warning)
    }
    
    @IBAction func errorButtonAction(_ sender: Any) {
        let errorMessage = "An unexpected error occurred.  Please try again later or contact support for assistance."
        CustomNotificationView.manager.showPopup(title: "Error!",
                                                 message: errorMessage,
                                                 status: .error)
    }
}
