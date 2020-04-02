//
// Created by apploft on 18.12.18.
// Copyright © 2019 apploft GmbH￼￼
// MIT License · http://choosealicense.com/licenses/mit/ 

import XCTest

class UIColorTest: XCTestCase {
    
    func testColorBleding() {
        //Given
        let red = UIColor.red
        let green = UIColor.green
        
        //When
        let blendetColor = UIColor.blend(color1: red, intensity1: 1.0, color2: green, intensity2: 0.5)
        
        //Then
        XCTAssertNotNil(blendetColor)
    }
    
    func testHexString() {
        //Given
        let redColor = UIColor.red
        let redHexString = "#FF0000"
        
        //When
        let testHex = redColor.hexString
        
        //Then
        XCTAssertEqual(testHex, redHexString)
    }
    
    func testAdjustedColorNotEqualToOriginalColor() {
        //Given
        let redColor = UIColor.red
        
        //When
        let adjustedColor = redColor.adjust()
        
        //Then
        XCTAssertNotNil(adjustedColor)
        XCTAssertNotEqual(adjustedColor, redColor)
    }
    
    func testLightedColorNotEqualToOriginalColor() {
        //Given
        let redColor = UIColor.red
        
        //When
        let lightenedColor = redColor.lighter()
        
        //Then
        XCTAssertNotNil(lightenedColor)
        XCTAssertNotEqual(lightenedColor, redColor)
    }
    
    func testDarkedColorNotEqualToOriginalColor() {
        //Given
        let redColor = UIColor.red
        
        //When
        let darkendColor = redColor.adjust()
        
        //Then
        XCTAssertNotNil(darkendColor)
        XCTAssertNotEqual(darkendColor, redColor)
    }
}
