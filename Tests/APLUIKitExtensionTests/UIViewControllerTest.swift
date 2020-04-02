//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH￼￼
// MIT License · http://choosealicense.com/licenses/mit/

import XCTest
import APLUIKitExtension

//Testing view controller's presentedViewController can not be tested inside Swift Package, since AppDelegate and root window are not accessable, and they are needed to to load view hiearchy. -> UI Test needed

@available(iOS 11.0, *)
class UIViewControllerTest: XCTestCase {

    func testGettingTopViewControllerOfNavigationController() {
        //Given
        let bottomViewController = UIViewController()
        let middleViewController = UIViewController()
        let topViewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: bottomViewController)
        
        //When
        navigationController.pushViewController(middleViewController, animated: false)
        navigationController.pushViewController(topViewController, animated: false)
        
        //Then
        XCTAssertEqual(UIViewController.topViewController(of: navigationController), topViewController)
    }
}
