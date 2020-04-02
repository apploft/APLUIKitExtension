//
// Created by apploft on 02.04.2020.
// Copyright © 2019 apploft GmbH.
// MIT License · http://choosealicense.com/licenses/mit/

import XCTest
import APLUIKitExtension

class NibLoadableTest: XCTestCase {
       
    //MARK:- Nibname
    func testNibNameNotEqual() {
        //Given
        let viewClass1 = NibReusableTestView1.self
        let viewClass2 = NibReusableTestView2.self
        
        //When
        let nibNameOfViewClass1 = viewClass1.nibName
        let nibNameOfViewClass2 = viewClass2.nibName
        
        //Then
        XCTAssertNotEqual(nibNameOfViewClass1, nibNameOfViewClass2)
    }
    
    func testNibNameEqual() {
        //Given
        let viewClass1 = NibReusableTestView1.self
        let viewClass1Refference = viewClass1
        
        //When
        let nibNameOfViewClass1 = viewClass1.nibName
        let nibNameOfviewClass1Refference = viewClass1Refference.nibName
        
        //Then
        XCTAssertEqual(nibNameOfViewClass1, nibNameOfviewClass1Refference)
    }
    
    //MARK:- Nib
    func testNibNotEqual() {
        //Given
        let viewClass1 = NibReusableTestView1.self
        let viewClass2 = NibReusableTestView2.self
        
        //When
        let nibOfViewClass1 = viewClass1.nib
        let nibOfViewClass2 = viewClass2.nib
        
        //Then
        XCTAssertNotEqual(nibOfViewClass1, nibOfViewClass2)
    }
}

private class NibReusableTestView1: UIView, NibReusableView {
}


private class NibReusableTestView2: UIView, NibReusableView {
}
