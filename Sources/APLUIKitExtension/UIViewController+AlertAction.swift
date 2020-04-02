//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

public struct AlertButton {
    public let title: String
    public let enabled: Bool
    public let action: () -> Void
    public var style: UIAlertAction.Style
    
    /// Initilizer to create an Alertbutton.
    /// - Parameter title: The title of the Alertbutton.
    /// - Parameter enabled: A bool indicating, if the button is enabled.
    ///     Default: true.
    /// - Parameter style: UIAlertAction.Style to set the button's style.
    ///     Default: .default.
    /// - Parameter action: Closure, which is executed, when button is tapped.
    ///     Default: empty closure.
    public init(title: String, enabled: Bool = true, style: UIAlertAction.Style = .default, action: @escaping () -> Void = {}) {
        self.title = title
        self.action = action
        self.enabled = enabled
        self.style = style
    }
    
    /// Creates an AlertButton for "okay operations".
    /// - Parameter enabled: A bool indicating, if the button is enabled.
    ///     Default: true.
    /// - Parameter action: Closure, which is executed, when button is tapped.
    ///     Default: empty closure.
    public static func okButton(enabled: Bool = true, action: @escaping () -> Void = {}) -> AlertButton {
        return AlertButton(title: NSLocalizedString("ok", comment: ""), enabled: enabled, action: action)
    }
    
    /// Creates an AlertButton for cancalations.
    /// - Parameter enabled: A bool indicating, if the button is enabled.
    ///     Default: true.
    /// - Parameter action: Closure, which is executed, when button is tapped.
    ///     Default: empty closure.
    public static func cancelButton(enabled: Bool = true, action: @escaping () -> Void = {}) -> AlertButton {
        return AlertButton(title: NSLocalizedString("cancel", comment: ""), enabled: enabled, action: action)
    }
}

@available(iOSApplicationExtension, unavailable)
public extension UIViewController {
    
    /// Convenience method in order to present an alert convenientyl on calling view controller. The alert will only have
    /// an "Ok"-button. You can only configure 'title' and 'message'. The method automatically determines the
    /// top most visible view controller to present the alert.
    /// - Parameter title: the alert title.
    /// - Parameter message: the message to show.
    class func presentAlert(withTitle title: String? = nil, message: String? = nil) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: NSLocalizedString("Ok", comment: "ok button"), style: .default, handler: nil)
            
            alertController.addAction(okAction)
            UIViewController.topViewController()?.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// Convenience method in order to present an alert convenientyl on calling view controller. The alert will have
    /// an "Cancle"-button and other buttons can be added, too. You can only configure 'title' and 'message'.
    /// - Parameter title: the alert title.
    /// - Parameter message: the message to show.
    /// - Parameter cancelButton: An AlertButton, which title and action is used as the alert's cancel Button.
    /// - Parameter cancelButton: An array of AlertButtons, which which will be added to the AlertController.
    func alert(title: String?, message: String?, cancelButton: AlertButton, otherButtons: [AlertButton]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancelButton.title, style: .cancel) { (action: UIAlertAction!) -> Void in
            cancelButton.action()
        }
        alertController.addAction(cancelAction)
        for button in otherButtons {
            let action = UIAlertAction(title: button.title, style: button.style) { (action) in
                button.action()
            }
            action.isEnabled = button.enabled
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    /// Convenience method in order to present an alert convenientyl on calling view controller. The alert will only have
    /// an "Ok"-button.
    /// - Parameter title: the alert title.
    /// - Parameter message: the message to show.
    /// - Parameter completionHandler: Closure which is called when the "Ok"- button of the alert is tapped.
    func alertOk(title: String?, message: String?, completionHandler: @escaping () -> Void) {
        let okButton = AlertButton(title: NSLocalizedString("ok", comment: ""), action: completionHandler)
        
        alert(title: title, message: message, cancelButton: okButton, otherButtons: [])
    }
    
    /// Convenience method in order to present an alert convenientyl from anywhere. The alert will only have
    /// an "Error"-button.
    /// - Parameter title: the alert title.
    /// - Parameter message: the message to show.
    /// - Parameter completionHandler: Closure which is called when the "Error"- button of the alert is tapped.
    func alertError(title: String?, message: String?, completionHandler: @escaping () -> Void = {}) {
        let okButton = AlertButton(title: NSLocalizedString("ok", comment: ""), action: completionHandler )
        
        alert(title: title, message: message, cancelButton: okButton, otherButtons: [])
    }
    
    /// Convenience method in order to present an actionSheet on calling view controller.
    /// - Parameter title: the sheet's title.
    ///     Default: No title.
    /// - Parameter message: the message to show.
    ///     Default: No massage.
    /// - Parameter cancelButton: An AlertButton, which title and action is used as the alert's cancel Button.
    ///     Default: No cancelButton.
    /// - Parameter destructiveButtons: An array of buttons to be added as destructiveButtons into the sheet.
    ///     Default: No destructiveButtons.
    /// - Parameter otherButtons: An array of buttons to be added as default buttons into the sheet.
    ///     Default: No otherButtons.
    func actionSheet(_ title: String? = nil,
                     _ message: String? = nil,
                     cancelButton: AlertButton? = nil,
                     destructiveButton: AlertButton? = nil,
                     otherButtons: [AlertButton] = []) {
        let destructiveButtons = destructiveButton.map { [$0] } ?? []
        
        actionSheet(title, message, cancelButton: cancelButton, destructiveButtons: destructiveButtons, otherButtons: otherButtons)
    }
    
    /// Convenience method in order to present an actionSheet on calling view controller.
    /// - Parameter title: the sheet's title.
    ///     Default: No title.
    /// - Parameter message: the message to show.
    ///     Default: No massage.
    /// - Parameter cancelButton: An AlertButton, which title and action is used as the alert's cancel Button.
    ///     Default: No cancelButton.
    /// - Parameter destructiveButtons: An array of buttons to be added as destructiveButtons into the sheet.
    ///     Default: No destructiveButtons.
    /// - Parameter otherButtons: An array of buttons to be added as default buttons into the sheet.
    ///     Default: No otherButtons.
    func actionSheet(_ title: String? = nil,
                     _ message: String? = nil,
                     cancelButton: AlertButton? = nil,
                     destructiveButtons: [AlertButton] = [],
                     otherButtons: [AlertButton] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        if let cancelButton = cancelButton {
            let action = UIAlertAction(title: cancelButton.title, style: .cancel) { (action) in
                cancelButton.action()
            }
            alertController.addAction(action)
        }
        
        for button in otherButtons {
            let action = UIAlertAction(title: button.title, style: .default) { (action: UIAlertAction!) -> Void in
                button.action()
            }
            action.isEnabled = button.enabled
            alertController.addAction(action)
        }
        
        for destructiveButton in destructiveButtons {
            let action = UIAlertAction(title: destructiveButton.title, style: .destructive) { (action) in
                destructiveButton.action()
            }
            action.isEnabled = destructiveButton.enabled
            alertController.addAction(action)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
