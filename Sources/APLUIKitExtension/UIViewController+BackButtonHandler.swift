//
//  File.swift
//  
//
//  Created by Ali Ebrahimi Pourasad on 01.04.20.
//

import UIKit

protocol NavigationControllerBackButtonDelegate {
    // Override this method in UIViewController derived class to handle 'Back' button click
    func shouldPopOnBackButtonPress() -> Bool
}

extension UINavigationController {
    
    /// Indicating wether the navigatoin bar top item can be popped. If the top item can be popped, it will also be popped.
    /// - Parameter navigationBar: Navigation bar that the item can be popped from.
    /// - Parameter item: Navigation item that can being popped.
    /// - Returns: A Bool indicating if the item can be popped
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        // Prevents from a synchronization issue of popping too many navigation items
        // and not enough view controllers or viceversa from unusual tapping
        if viewControllers.count < navigationBar.items!.count {
            return true
        }
        
        // Check if we have a view controller that wants to respond to being popped
        var shouldPop = true
        if let viewController = topViewController as? NavigationControllerBackButtonDelegate {
            shouldPop = viewController.shouldPopOnBackButtonPress()
        }
        
        if (shouldPop) {
            DispatchQueue.main.async {
                self.popViewController(animated: true)
            }
        } else {
            // Prevent the back button from staying in an disabled state
            for view in navigationBar.subviews {
                if view.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25, animations: {
                        view.alpha = 1.0
                    })
                }
            }
        }
        return false
    }
}
