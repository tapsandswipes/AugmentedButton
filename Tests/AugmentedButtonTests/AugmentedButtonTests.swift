//
//  AugmentedButtonTests.swift
//  AugmentedButtonTests
//
//  Created by Antonio Cabezuelo Vivo on 25/12/16.
//  Copyright © 2016 Antonio Cabezuelo Vivo. All rights reserved.
//

import XCTest
import AugmentedButton

class AugmentedButtonTests: XCTestCase {
    
    static var allTests : [(String, (AugmentedButtonTests) -> () throws -> Void)] {
        return [
            ("testAdvancedButtonSelected", testAdvancedButtonSelected),
            ("testAdvancedButtonHighlighted", testAdvancedButtonHighlighted),
            ("testAdvancedButtonDisabled", testAdvancedButtonDisabled),
            ("testAdvancedButtonHighlightedAndSelected", testAdvancedButtonHighlightedAndSelected),
            ("testValidProperties", testValidProperties),
            ("testValueForStates", testValueForStates),
            ("testActionsRemoval", testActionsRemoval),
            ("testCurrentValues", testCurrentValues),
            ("testCustomProperties", testCustomProperties),
        ]
    }

    var sut: AugmentedButton!
    
    override func setUp() {
        super.setUp()
        
        sut = AugmentedButton(type: .custom)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testAdvancedButtonSelected() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, forState: .selected)
        
        sut.isSelected = true
        XCTAssertTrue(called, "block not called")
    }
    
    func testAdvancedButtonHighlighted() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, forState: .highlighted)
        
        sut.isHighlighted = true
        XCTAssertTrue(called, "block not called")
    }
    
    func testAdvancedButtonDisabled() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, forState: .disabled)
        
        sut.isEnabled = false
        XCTAssertTrue(called, "block not called")
    }
    
    func testAdvancedButtonHighlightedAndSelected() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, forState: [.selected, .highlighted])
        
        sut.isSelected = true
        XCTAssertFalse(called, "block called on selected only. Should be called on both")
        
        sut.isHighlighted = true
        XCTAssertTrue(called, "block not called")
        
        called = false
        sut.isHighlighted = false
        XCTAssertFalse(called, "block called on selected only. Should be called on both")
        
        sut.isHighlighted = true
        XCTAssertTrue(called, "block not called")
    }
    
    func testValidProperties() {
        
        XCTAssertThrowsError(try sut.setValue(2 as AnyObject?, forKey: "pepe", forState: .normal))
        XCTAssertThrowsError(try sut.valueForKey("pepe", forState: .normal))
        XCTAssertThrowsError(try sut.setValue("Hi" as AnyObject?, forKey: "title", forState: .normal), "-setTitle:forState: is defined in UIButton")
        XCTAssertThrowsError(try sut.setValue(UIColor.white, forKey: "titleColor", forState: .normal), "-setTitleColor:forState: is defined in UIButton")
        XCTAssertThrowsError(try sut.setValue("" as AnyObject?, forKey: "image", forState: .normal), "-setImage:forState: is defined in UIButton")
        
        do {
            try sut.setValue(UIColor.white, forKey: "tintColor", forState: .normal)
        } catch {
            XCTFail("-setTintColor:forState: should not be defined in parent")
        }
        
        do {
            try sut.setValue(UIColor.white, forKey: "borderColor", forState: .normal)
        } catch {
            XCTFail("-setBorderColor:forState: should not be defined in parent")
        }
        
    }
    
    func testValueForStates() {
        
        let values: [(UIControlState, CGFloat)] = [(UIControlState(), 1), (.selected, 2), (.highlighted, 3), (.disabled, 4)]
        
        values.forEach { (state, value) in
            try! sut.setValue(value as AnyObject?, forKey: "borderWidth", forState: state)
        }
        
        values.forEach { (state, value) in
            do {
                let v = try sut.valueForKey("borderWidth", forState: state) as? CGFloat
                XCTAssertNotNil(v)
                XCTAssertEqual(v!, value)
            } catch {
                XCTFail()
            }
        }
        
    }
    
    func testActionsRemoval() {
        sut.setActions({ $0.borderWidth = 0 },  forState: .normal)
        sut.setActions({ $0.borderWidth = 33 }, forState: .selected)
        sut.setActions({ $0.borderWidth = 66 }, forState: .highlighted)
        
        sut.isSelected = true
        XCTAssertEqual(sut.borderWidth, 33)
        
        sut.isSelected = false
        sut.isHighlighted = true
        XCTAssertEqual(sut.borderWidth, 66)
        
        sut.clearActions(forState: .highlighted)
        XCTAssertEqual(sut.borderWidth, 0)
        
        sut.isSelected = true
        sut.isHighlighted = false
        XCTAssertEqual(sut.borderWidth, 33)
        
        sut.clearAllActions()
        XCTAssertEqual(sut.borderWidth, 0)
        
    }
    
    func testCurrentValues() {
        
        let values: [(UIControlState, CGFloat)] = [(UIControlState(), 1), (.selected, 2), (.highlighted, 3), (.disabled, 4)]
        
        values.forEach { (state, value) in
            try! sut.setValue(value as AnyObject?, forKey: "borderWidth", forState: state)
        }
        
        XCTAssertEqual((try! sut.currentValueForKey("borderWidth") as? CGFloat)!, 1)
        
        sut.isSelected = true
        XCTAssertEqual((try! sut.currentValueForKey("borderWidth") as? CGFloat)!, 2)
        
        sut.isSelected = false
        sut.isHighlighted = true
        XCTAssertEqual((try! sut.currentValueForKey("borderWidth") as? CGFloat)!, 3)
        
        sut.isHighlighted = false
        sut.isEnabled = false
        XCTAssertEqual((try! sut.currentValueForKey("borderWidth") as? CGFloat)!, 4)
    }
    
    func testCustomProperties() {
        
        sut.setBorderWidth(33, forState: .normal)
        XCTAssertEqual(sut.borderWidthForState(.normal), 33)
        XCTAssertEqual(sut.currentBorderWidth(), 33)
        XCTAssertEqual(sut.borderWidthForState(.selected), 0)
        XCTAssertEqual(sut.borderWidth, 33)
        
        sut.setCornerRadius(13, forState: .normal)
        XCTAssertEqual(sut.cornerRadiusForState(.normal), 13)
        XCTAssertEqual(sut.currentCornerRadius(), 13)
        XCTAssertEqual(sut.cornerRadiusForState(.selected), 0)
        XCTAssertEqual(sut.cornerRadius, 13)
        
        sut.setBackgroundColor(UIColor.lightGray, forState: .normal)
        XCTAssertEqual(sut.backgroundColorForState(.normal), UIColor.lightGray)
        XCTAssertEqual(sut.currentBackgroundColor(), UIColor.lightGray)
        XCTAssertEqual(sut.backgroundColor, UIColor.lightGray)
        
        sut.setBorderColor(UIColor(white: 1, alpha: 0.5), forState: .normal)
        XCTAssertEqual(sut.borderColorForState(.normal), UIColor(white: 1, alpha: 0.5))
        XCTAssertEqual(sut.currentBorderColor(), UIColor(white: 1, alpha: 0.5))
        XCTAssertEqual(sut.borderColor, UIColor(white: 1, alpha: 0.5))
        
        sut.setTintColor(UIColor.lightGray, forState: .normal)
        XCTAssertEqual(sut.tintColorForState(.normal), UIColor.lightGray)
        XCTAssertEqual(sut.currentTintColor(), UIColor.lightGray)
        XCTAssertEqual(sut.tintColor, UIColor.lightGray)
        
        sut.isSelected = true
        XCTAssertEqual(sut.currentCornerRadius(), 0)
        XCTAssertEqual(sut.currentBorderWidth(), 0)

        
        
    }
    
}