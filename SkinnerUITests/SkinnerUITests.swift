import XCTest

final class SkinnerUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
        
    func testOneMonthRange() {
        XCTContext.runActivity(named: "Select dates 20/Jul/2018 to 21/Jul/2018") { _ in
            selectFrom((.july, 20, 2018), to: (.july, 21, 2018))
            app.collectionViews.cells.children(matching: .other).element(boundBy: 1).tap()
        }
        XCTContext.runActivity(named: "Check July Scene") { (activity) in
            let scene = "July 2018"
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 6, day: 25...30)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 7, day: 1...19)
            checkAssertTrue(identifier: "dayCell", in: scene, month: 7, day: 20...21)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 7, day: 22...31)
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 8, day: 1...5)
            checkAssertFalse(at: "8.6", in: scene)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
    }
    
    func testTwoMonthRange1() {
        XCTContext.runActivity(named: "Select dates 15/Jul/2018 to 1/Aug/2018") { _ in
            selectFrom((.july, 15, 2018), to: (.august, 1, 2018))
            app.collectionViews.cells.children(matching: .other).element(boundBy: 1).tap()
        }
        XCTContext.runActivity(named: "Check July Scene") { (activity) in
            let scene = "July 2018"
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 6, day: 25...30)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 7, day: 1...14)
            checkAssertTrue(identifier: "dayCell", in: scene, month: 7, day: 15...31)
            checkAssertTrue(identifier: "spacerDayCell 8.1", in: scene)
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 8, day: 2...5)
            checkAssertFalse(at: "8.6", in: scene)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
        XCTContext.runActivity(named: "Check August Scene") { (activity) in
            app.navigationBars["Skinner.CalendarView"].buttons["Next"].tap()
            let scene = "August 2018"
            checkAssertTrue(identifier: "spacerDayCell", in: scene, month: 7, day: 30...31)
            checkAssertTrue(identifier: "dayCell 8.1", in: scene)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 8, day: 2...31)
            checkAssertFalse(at: "9.3", in: scene)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
    }
    
    func testTwoMonthRange2() {
        XCTContext.runActivity(named: "Select dates 28/Jun/2018 to 28/Jul/2018") { _ in
            selectFrom((.june, 28, 2018), to: (.july, 28, 2018))
            app.collectionViews.cells.children(matching: .other).element(boundBy: 1).tap()
        }
        XCTContext.runActivity(named: "Check June Scene") { (activity) in
            let scene = "June 2018"
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 5, day: 28...31)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 6, day: 1...27)
            checkAssertTrue(identifier: "dayCell", in: scene, month: 6, day: 28...30)
            checkAssertTrue(identifier: "spacerDayCell 7.1", in: scene)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
        XCTContext.runActivity(named: "Check July Scene") { (activity) in
            app.navigationBars["Skinner.CalendarView"].buttons["Next"].tap()
            let scene = "July 2018"
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 6, day: 25...27)
            checkAssertTrue(identifier: "spacerDayCell", in: scene, month: 6, day: 28...30)
            checkAssertTrue(identifier: "dayCell", in: scene, month: 7, day: 1...28)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 7, day: 29...31)
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 8, day: 1...5)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
    }
    
    func testThreeMonthRange() {
        XCTContext.runActivity(named: "Select dates 15/Jul/2018 to 1/Sep/2018") { _ in
            selectFrom((.july, 15, 2018), to: (.september, 1, 2018))
            app.collectionViews.cells.children(matching: .other).element(boundBy: 1).tap()
        }
        XCTContext.runActivity(named: "Check July Scene") { (activity) in
            let scene = "July 2018"
            checkAssertTrue(identifier: "invisibleSpacerDayCell", in: scene, month: 6, day: 25...30)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 7, day: 1...14)
            checkAssertTrue(identifier: "dayCell", in: scene, month: 7, day: 15...31)
            checkAssertTrue(identifier: "spacerDayCell", in: scene, month: 8, day: 1...5)
            checkAssertFalse(at: "8.6", in: scene)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
        XCTContext.runActivity(named: "Check August Scene") { (activity) in
            
            // move to august
            app.navigationBars["Skinner.CalendarView"].buttons["Next"].tap()
            
            // wait for UI to arrive
            let predicate = NSPredicate(format: "exists == 1")
            let element = app.collectionViews.cells.matching(identifier: "dayCell 8.1").element
            expectation(for: predicate, evaluatedWith: element, handler: nil)
            waitForExpectations(timeout: 3, handler: nil)
            
            // then test
            let scene = "August 2018"
            checkAssertTrue(identifier: "spacerDayCell", in: scene, month: 7, day: 30...31)
            checkAssertTrue(identifier: "dayCell", in: scene, month: 8, day: 1...31)
            checkAssertTrue(identifier: "spacerDayCell 9.1", in: scene)
            checkAssertTrue(identifier: "invisibleSpacerDayCell 9.2", in: scene)
            checkAssertFalse(at: "9.3", in: scene)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
        XCTContext.runActivity(named: "Check September Scene") { (activity) in
            
            // move to september
            app.navigationBars["Skinner.CalendarView"].buttons["Next"].tap()
            
            // wait for UI to arrive
            let predicate = NSPredicate(format: "exists == 1")
            let element = app.collectionViews.cells.matching(identifier: "dayCell 9.1").element
            expectation(for: predicate, evaluatedWith: element, handler: nil)
            waitForExpectations(timeout: 3, handler: nil)
            
            // then test
            let scene = "September 2018"
            checkAssertTrue(identifier: "spacerDayCell", in: scene, month: 8, day: 27...31)
            checkAssertTrue(identifier: "dayCell 9.1", in: scene)
            checkAssertTrue(identifier: "disabledDayCell", in: scene, month: 9, day: 2...30)
            checkAssertFalse(at: "10.1", in: scene)
            let fullscreenshot = XCUIScreen.main.screenshot()
            let fullScreenshotAttachment = XCTAttachment(screenshot: fullscreenshot)
            fullScreenshotAttachment.lifetime = .deleteOnSuccess
            activity.add(fullScreenshotAttachment)
        }
    }

}

private extension SkinnerUITests {
    
    typealias PickerDate = (Month, Int, Int)
    
    static let all = ["invisibleSpacerDayCell","dayCell","disabledDayCell", "spacerDayCell"]
    
    func selectFrom(_ from: PickerDate, to: PickerDate) {
        app.textFields["startDateTextField"].tap()
        selectMonth(from.0, day: from.1, year: from.2)
        app.textFields["endDateTextField"].tap()
        selectMonth(to.0, day: to.1, year: to.2)
    }
    
    enum Month: String {
        case january, february, march, april, may, june, july, august, september, october, november, december
    }
    
    func selectMonth(_ month: Month, day: Int, year: Int) {
        let wheel0 = app.pickerWheels.element(boundBy: 0)
        wheel0.adjust(toPickerWheelValue: month.rawValue.capitalized)
        let wheel1 = app.pickerWheels.element(boundBy: 1)
        wheel1.adjust(toPickerWheelValue: String(day))
        let wheel2 = app.pickerWheels.element(boundBy: 2)
        wheel2.adjust(toPickerWheelValue: String(year))
    }
    
    func checkAssertTrue(identifier: String, in scene: String, month: Int, day: CountableClosedRange<Int>) {
        let identifiers: [String] = day.map {
            let value: Int = $0
            return identifier + " " + String(month) + "." + String(value)
        }
        identifiers.forEach {
            checkAssertTrue(identifier: $0, in: scene)
        }
    }
    
    func checkAssertTrue(identifier: String, in scene: String) {
        let exists = app.collectionViews.cells.matching(identifier: identifier).element.exists
        let message = assembleMessage(for: identifier, in: scene, for: .assertTrue)
        XCTAssertTrue(exists, message)
    }
    
    private enum BoolAssert {
        case assertTrue, assertFalse
    }
    
    private func assembleMessage(for identifier: String, in scene: String, for assert: BoolAssert) -> String {
        var components = identifier.components(separatedBy: " ")
        let expecting: String
        switch assert {
        case .assertTrue:
            expecting = "is expecting"
        case .assertFalse:
            expecting = "is not expecting"
        }
        var message = "Scene \(scene) \(expecting) \(components.first!) "
        components = components.last!.components(separatedBy: ".")
        message += "for month \(components.first!) day \(components.last!)."
        return message
    }
    
    func checkAssertFalse(for identifier: String, in scene: String) {
        let exists = app.collectionViews.cells.matching(identifier: identifier).element.exists
        let message = assembleMessage(for: identifier, in: scene, for: .assertFalse)
        XCTAssertFalse(exists, message)
    }
    
    func checkAssertFalse(at position: String, in scene: String) {
        let identifiers = SkinnerUITests.all.map {
            $0 + " " + position
        }
        identifiers.forEach { (identifier) in
            checkAssertFalse(for: identifier, in: scene)
        }
    }
}
