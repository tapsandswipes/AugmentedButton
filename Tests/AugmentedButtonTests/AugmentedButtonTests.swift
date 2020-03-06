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
            ("testLinuxTestSuiteIncludesAllTests", testLinuxTestSuiteIncludesAllTests),
            ("testAdvancedButtonSelected", testAdvancedButtonSelected),
            ("testAdvancedButtonHighlighted", testAdvancedButtonHighlighted),
            ("testAdvancedButtonDisabled", testAdvancedButtonDisabled),
            ("testAdvancedButtonHighlightedAndSelected", testAdvancedButtonHighlightedAndSelected),
            ("testValueForStates", testValueForStates),
            ("testActionsRemoval", testActionsRemoval),
            ("testCurrentValues", testCurrentValues),
            ("testCustomProperties", testCustomProperties),
            ("testNormalValues", testNormalValues),
            ("testCustomKeyPaths", testCustomKeyPaths),
            ("testNewUIControlEventsAreDistinct", testNewUIControlEventsAreDistinct),
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
    
    func testLinuxTestSuiteIncludesAllTests() {
        #if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
            let darwinTestCount = Int(AugmentedButtonTests.defaultTestSuite.testCaseCount)
            let linuxTestCount = AugmentedButtonTests.allTests.count
            
            XCTAssertEqual(linuxTestCount, darwinTestCount, "allTEsts (used for testing on Linux) is missing \(darwinTestCount - linuxTestCount) tests")
        #endif
    }
    
    func testAdvancedButtonSelected() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, for: .selected)
        
        sut.isSelected = true
        XCTAssertTrue(called, "block not called")
    }
    
    func testAdvancedButtonHighlighted() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, for: .highlighted)
        
        sut.isHighlighted = true
        XCTAssertTrue(called, "block not called")
    }
    
    func testAdvancedButtonDisabled() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, for: .disabled)
        
        sut.isEnabled = false
        XCTAssertTrue(called, "block not called")
    }
    
    func testAdvancedButtonHighlightedAndSelected() {
        
        var called: Bool = false
        let block: AugmentedButton.Actions = { _ in called = true }
        
        sut.setActions(block, for: [.selected, .highlighted])
        
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
    
    func testValueForStates() {
        
        let values: [(UIControl.State, CGFloat)] = [(.normal, 1), (.selected, 2), (.highlighted, 3), (.disabled, 4)]
        
        values.forEach { (state, value) in
            sut.setValue(value, forKeyPath: \.borderWidth, for: state)
        }
        
        values.forEach { (state, value) in
            let v = sut.valueForKeyPath(\.borderWidth, for: state)
            XCTAssertNotNil(v)
            XCTAssertEqual(v!, value)
        }
        
    }
    
    func testActionsRemoval() {
        sut.setActions({ $0.borderWidth = 0 },  for: .normal)
        sut.setActions({ $0.borderWidth = 33 }, for: .selected)
        sut.setActions({ $0.borderWidth = 66 }, for: .highlighted)
        
        sut.isSelected = true
        XCTAssertEqual(sut.borderWidth, 33)
        
        sut.isSelected = false
        sut.isHighlighted = true
        XCTAssertEqual(sut.borderWidth, 66)
        
        sut.clearActions(for: .highlighted)
        XCTAssertEqual(sut.borderWidth, 0)
        
        sut.isSelected = true
        sut.isHighlighted = false
        XCTAssertEqual(sut.borderWidth, 33)
        
        sut.clearAllActions()
        XCTAssertEqual(sut.borderWidth, 0)
        
    }
    
    func testCurrentValues() {
        
        let values: [(UIControl.State, CGFloat)] = [(.normal, 1), (.selected, 2), (.highlighted, 3), (.disabled, 4)]
        
        values.forEach { (state, value) in
            sut.setValue(value, forKeyPath: \.borderWidth, for: state)
        }
        
        XCTAssertEqual(sut.currentValueForKeyPath(\.borderWidth), 1)
        
        sut.isSelected = true
        XCTAssertEqual(sut.currentValueForKeyPath(\.borderWidth), 2)
        
        sut.isSelected = false
        sut.isHighlighted = true
        XCTAssertEqual(sut.currentValueForKeyPath(\.borderWidth), 3)
        
        sut.isHighlighted = false
        sut.isEnabled = false
        XCTAssertEqual(sut.currentValueForKeyPath(\.borderWidth), 4)
    }
    
    func testCustomProperties() {
        
        sut.setBorderWidth(33, for: .normal)
        XCTAssertEqual(sut.borderWidth(for: .normal), 33)
        XCTAssertEqual(sut.currentBorderWidth(), 33)
        XCTAssertEqual(sut.borderWidth(for: .selected), 0)
        XCTAssertEqual(sut.borderWidth, 33)
        
        sut.setCornerRadius(13, for: .normal)
        XCTAssertEqual(sut.cornerRadius(for: .normal), 13)
        XCTAssertEqual(sut.currentCornerRadius(), 13)
        XCTAssertEqual(sut.cornerRadius(for: .selected), 0)
        XCTAssertEqual(sut.cornerRadius, 13)
        
        sut.setBackgroundColor(UIColor.lightGray, for: .normal)
        XCTAssertEqual(sut.backgroundColor(for: .normal), UIColor.lightGray)
        XCTAssertEqual(sut.currentBackgroundColor(), UIColor.lightGray)
        XCTAssertEqual(sut.backgroundColor, UIColor.lightGray)
        
        sut.setBorderColor(UIColor(white: 1, alpha: 0.5), for: .normal)
        XCTAssertEqual(sut.borderColor(for: .normal), UIColor(white: 1, alpha: 0.5))
        XCTAssertEqual(sut.currentBorderColor(), UIColor(white: 1, alpha: 0.5))
        XCTAssertEqual(sut.borderColor, UIColor(white: 1, alpha: 0.5))
        
        sut.setTintColor(UIColor.lightGray, for: .normal)
        XCTAssertEqual(sut.tintColor(for: .normal), UIColor.lightGray)
        XCTAssertEqual(sut.currentTintColor(), UIColor.lightGray)
        XCTAssertEqual(sut.tintColor, UIColor.lightGray)
        
        sut.isSelected = true
        XCTAssertEqual(sut.currentCornerRadius(), 13)
        XCTAssertEqual(sut.currentBorderWidth(), 33)
        
    }
    
    func testNormalValues() {
        sut.borderWidth = 1
        sut.borderColor = .red
        sut.setBorderWidth(3, for: .highlighted)
        sut.setBorderColor(UIColor(white: 1, alpha: 0.5), for: .highlighted)

        XCTAssertEqual(sut.currentBorderWidth(), 1)
        XCTAssertEqual(sut.borderWidth(for: .highlighted), 3)
        XCTAssertEqual(sut.borderColor(for: .highlighted), UIColor(white: 1, alpha: 0.5))

        sut.isHighlighted = true
        
        XCTAssertEqual(sut.currentBorderWidth(), 3)
        XCTAssertEqual(sut.currentBorderColor(), UIColor(white: 1, alpha: 0.5))

        sut.isHighlighted = false
        
        XCTAssertEqual(sut.currentBorderWidth(), 1)
        XCTAssertEqual(sut.currentBorderColor(), .red)

    }
    
    func testCustomKeyPaths() {
        sut.setValue(0.8, forKeyPath: \.layer.opacity, for: .selected)
        
        XCTAssertEqual(sut.currentValueForKeyPath(\.layer.opacity), 1)

        sut.isSelected = true
        XCTAssertEqual(sut.currentValueForKeyPath(\.layer.opacity), 0.8)

        sut.isSelected = false
        XCTAssertEqual(sut.currentValueForKeyPath(\.layer.opacity), 1)

    }
    
    func testNewUIControlEventsAreDistinct() {
        XCTAssertNotEqual(UIControl.Event.stateChanged.rawValue, UIControl.Event.longPress.rawValue)
    }
}
