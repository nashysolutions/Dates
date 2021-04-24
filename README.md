<p align="center">
    <img src="Logo.png" width="480" max-width="90%" alt="Dates" />
</p>

<p align="center">
    <a href="https://app.bitrise.io/app/86e40192e5c4de02">
        <img src="https://app.bitrise.io/app/86e40192e5c4de02/status.svg?token=DQRmewaiQchTgbuM_fdOjQ&branch=master" alt="Bitrise"/>
   </a>
    <a href="https://img.shields.io/badge/carthage-compatible-brightgreen.svg">
        <img src="https://img.shields.io/badge/carthage-compatible-brightgreen.svg" alt="Carthage"/>
    </a>
    <a href="https://swift.org/blog/swift-5-released/">
        <img src="https://img.shields.io/badge/swift-5.0-orange.svg" alt="Swift"/>
  </a>
</p>

## Usage

The onus is on the implementing developer to build the following.

* 4 x `UICollectionViewCell` subclasses representing `DayPositions`.
* 2 x `UICollectionReusableView` subclasses representing `TitlePositions`.

Take a look at the [SummerSnowflake](https://github.com/BowdusBrown/Dates/wiki/SummerSnowflake) example.

```swift
let dayTypes = DayPosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
let titleTypes = TitlePosition.allCases.map { SummerSnowflake.userInterface(for: $0) }
let userInterface = UserInterface(dayTypes: dayTypes, titleTypes: titleTypes)

do {
    let calendarView = try PagingGridView(startDate: start, endDate: end, userInterface: userInterface)
    calendarView.backgroundColor = backgroundColor
    // add subview
} catch let error as PagingGridView.Error {
    handleError(error) // The date ranges must make sense.
} catch let error as UserInterface.Error {
    handleError(error) // All UI elements must be present.
} catch {
    fatalError("Unexpected error.")
}

// Switch over the error cases or print like this.
private func handleError(_ error: LocalizedError) {
    let errorDescription = error.errorDescription!
    let failureReason = error.failureReason!
    let recoverySuggestion = error.recoverySuggestion!
    fatalError(errorDescription + failureReason + recoverySuggestion)
}

// Find the current selection like so
let date = calendarView.currentSelection?.date
```

## Demo

Tap the following image to launch [Appetize](https://appetize.io).

<p align="center">
    <a href="https://appetize.io/app/5vz9bxn9ft7gab7ckvu5g4cna0?device=iphonexsmax&scale=75&orientation=portrait&osVersion=12.2&deviceColor=black">
        <img src="https://user-images.githubusercontent.com/51816980/59961554-2f0d7e80-94d1-11e9-83a6-98160bfa19a9.png" alt="Appetize"/>
   </a>
</p>
