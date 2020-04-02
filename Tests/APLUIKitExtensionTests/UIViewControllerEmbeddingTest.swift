//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH￼￼
// MIT License · http://choosealicense.com/licenses/mit/

import XCTest

class UIViewControllerEmbeddingTest: XCTestCase {

    //MARK:- Embeding
    func testEmbeddingViewControllersViewIntoParentView() {
        // Given
        let parentViewController = UIViewController()
        let childViewController = UIViewController()
        
        // When
        parentViewController.embed(controller: childViewController, into: parentViewController.view)
        
        // Then
        XCTAssertEqual(parentViewController.view, childViewController.view.superview)
    }
    
    func testEmbedingViewControllerAsChildController() {
        // Given
        let parentViewController = UIViewController()
        let childViewController = UIViewController()
        
        // When
        parentViewController.embed(controller: childViewController, into: parentViewController.view)
        
        // Then
        XCTAssertEqual(parentViewController, childViewController.parent)
    }

    //MARK:- Unembeding
    func testUnmbeddingViewControllersViewOfParentView() {
        // Given
        let parentViewController = UIViewController()
        let childViewController = UIViewController()
        parentViewController.embed(controller: childViewController, into: parentViewController.view)
        
        // When
        parentViewController.unembed(controller: childViewController)
        
        // Then
        XCTAssertNil(childViewController.view.superview)
    }
    
    func testUnembedingViewControllerAsChildController() {
        // Given
        let parentViewController = UIViewController()
        let childViewController = UIViewController()
        parentViewController.embed(controller: childViewController, into: parentViewController.view)
        
        //When
        parentViewController.unembed(controller: childViewController)
        
        // Then
        XCTAssertNil(childViewController.parent)
    }
    
    //MARK:- Child
    func testChildViewControllerRefference() {
        // Given
        let parentViewController = UIViewController()
        let childViewController = UIViewController()
        
        //When
        parentViewController.embed(controller: childViewController, into: parentViewController.view)
        
        // Then
        XCTAssertEqual(parentViewController.child(), childViewController)
    }
}
