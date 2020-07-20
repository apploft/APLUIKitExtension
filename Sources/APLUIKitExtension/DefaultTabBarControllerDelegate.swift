//
//  DefaultTabBarControllerDelegate.swift
//
// Created by apploft on 02.10.2019.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import Foundation
import UIKit


/// The class DefaultTabBarControllerDelegate can be used for performing an action
/// in a view controller if the corresponding tab bar item is selected again.
///
/// Usage:
/*
 class DefaultTabBarControllerDelegateImpl: DefaultTabBarControllerDelegate {

    override func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        super.tabBarController(tabBarController, didSelect: viewController)

    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
 }

 extension MyViewController {
    override func tabBarItemSelectedAgain() {
      // do something
    }
 }
 */

open class DefaultTabBarControllerDelegate: NSObject, UITabBarControllerDelegate {

    /// Property which stores the selected index of tab bar
    private var  currentIndex: Int

    /// Initializer
    ///
    /// - Parameter startIndex: Initially selected index of tab bar
    public init(startIndex: Int = 0) {
        currentIndex = startIndex
    }

    /// Delagate method, which calls generic func if a tab bar item is selected again.
    ///
    /// - Parameter tabBarController: Instance of the tab bar controller
    /// - Parameter viewController: Selected view controller
    open func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let selectedIndex = tabBarController.selectedIndex
        if currentIndex == selectedIndex {
            viewController.tabBarItemSelectedAgain()
        }
        currentIndex = selectedIndex
    }
}


extension UIViewController {
   @objc open func tabBarItemSelectedAgain() {

    }
}

