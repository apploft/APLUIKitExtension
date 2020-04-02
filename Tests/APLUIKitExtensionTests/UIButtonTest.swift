//
//  File.swift
//  
//
//  Created by Ali Ebrahimi Pourasad on 02.04.20.
//

import XCTest
import APLUIKitExtension

class UIButtonTest: XCTestCase {
    
    //MARK:- setBackgroundColor
    func testSetBackgroundColorNotNilForNormalState() {
        //Given
        let button = UIButton()
        
        //When
        button.setBackgroundColor(color: .blue, forState: .normal)
        
        //Then
        XCTAssertNotNil(button.backgroundImage(for: .normal))
    }
    
    func testSetBackgroundColorNotNilForHighlightedState() {
        //Given
        let button = UIButton()
        
        //When
        button.setBackgroundColor(color: .blue, forState: .highlighted)
        
        //Then
        XCTAssertNotNil(button.backgroundImage(for: .highlighted))
    }
    
    //MARK:- setRoundedRectBackgroundImage
    func testSetRoundRectBackgroundImageNotNilForNormalState() {
        //Given
        let button = UIButton()
        
        //When
        button.setRoundedRectBackgroundImage(color: .blue, height: 10, cornerRadius: 10, forState: .normal)
        
        //Then
        XCTAssertNotNil(button.backgroundImage(for: .normal))
    }
    
    func testSetRoundRectBackgroundImageNotNilForHighlightedState() {
        //Given
        let button = UIButton()
        
        //When
        button.setRoundedRectBackgroundImage(color: .blue, height: 10, cornerRadius: 10, forState: .highlighted)
        
        //Then
        XCTAssertNotNil(button.backgroundImage(for: .highlighted))
    }
    
    //MARK:- setGradientBackgroundColor
    func testSetGradientBackgroundColorNotNilForNormalState() {
        //Given
        let button = UIButton()
        
        //When
        button.setGradientBackgroundColor(startColor: .blue, endColor: .black, forState: .normal)
        
        //Then
        XCTAssertNotNil(button.backgroundImage(for: .normal))
    }
    
    func testSetGradientBackgroundColorNotNilForHighlightedState() {
        //Given
        let button = UIButton()
        
        //When
        button.setGradientBackgroundColor(startColor: .blue, endColor: .black, forState: .highlighted)
        
        //Then
        XCTAssertNotNil(button.backgroundImage(for: .highlighted))
    }
}
