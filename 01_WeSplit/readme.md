# WeSplit – Project 1 from 100 Days of Hacking With Swift

A simple SwiftUI app that calculates how much each person should pay when splitting a check, including tip. This project was based on the first challenge in Paul Hudson’s *100 Days of SwiftUI* and has been expanded with custom logic and UI enhancements.

---

## Features Added

- **Sectioned Form Layout**
  - Moved "Check Amount" and "Number of People" to their own labeled sections for better UX and clarity.
  
- **Dynamic Tip Selection**
  - Introduced a `TipSelectionType` enum to allow users to choose between:
    - Preselected tip percentages (10%, 15%, 20%, etc.)
    - A custom tip amount entered manually

- **Conditional UI Rendering**
  - Used a `switch` statement to toggle between a segmented picker and a text field based on user selection.

- **Input Validation**
  - Clamped custom tip values to stay within a valid range (0–100) to prevent inappropriate inputs.

- **Additional Summary Info**
  - Added a computed "Tip Total" section with formatted currency display.

---

## Tech Highlights

- SwiftUI Forms, NavigationStack, FocusState
- `Picker`, `TextField`, `@State`, and computed properties
- Currency formatting with locale support
- Clean UI structure with segmented controls and dynamic input modes
