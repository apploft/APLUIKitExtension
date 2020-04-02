//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import UIKit

@objc public extension UIViewController {
    
    /// Determine the top visible view controller starting from the given view
    /// controller, considering presented view controller recursively.
    /// - Parameter controller: the staring view controller. Default will be the
    /// 'rootViewController'
    /// - Returns: the top visible view controller or nil
    @available(iOSApplicationExtension, unavailable)
    class func topViewController(of controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let presented = controller?.presentedViewController {
            return topViewController(of: presented)
        }
        if let navigationController = controller as? UINavigationController {
            return topViewController(of: navigationController.topViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(of: selected)
            }
        }
        return controller
    }
}
