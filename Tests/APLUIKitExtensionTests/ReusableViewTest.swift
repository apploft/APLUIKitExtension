//
// Created by apploft on 02.04.2020.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import XCTest
import APLUIKitExtension

class ReusableViewTest: XCTestCase {
    
    func testReuseIdentifierNotEqual() {
        //Given
        let viewClass1 = ReusableTestView1.self
        let viewClass2 = ReusableTestView2.self
        
        //When
        let reuseIdOfViewClass1 = viewClass1.reuseIdentifier
        let reuseIdOfViewClass2 = viewClass2.reuseIdentifier
        
        //Then
        XCTAssertNotEqual(reuseIdOfViewClass1, reuseIdOfViewClass2)
    }
    
    func testReuseIdentifierEqual() {
        //Given
        let viewClass1 = ReusableTestView1.self
        let viewClass1Refference = viewClass1
        
        //When
        let reuseIdOfViewClass1 = viewClass1.reuseIdentifier
        let reuseIdOfviewClass1Refference = viewClass1Refference.reuseIdentifier
        
        //Then
        XCTAssertEqual(reuseIdOfViewClass1, reuseIdOfviewClass1Refference)
    }
}

private class ReusableTestView1: UIView, ReusableView {
}

private class ReusableTestView2: UIView, ReusableView {
}
