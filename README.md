# Fetch_TakeHome

This repository contains the code for the Fetch Take Home project. Below are the steps to run the project on your local machine using Xcode for iOS development.

---

## Getting Started

Follow these instructions to set up and run the project on your local iOS simulator.

### Prerequisites

- macOS with **Xcode** installed
- iOS 16.6 Simulator or higher

---

## Steps to Run the App

Follow these steps to set up and run the app:

1. Clone the repo
   ```sh
   git clone https://github.com/angusyi103/Fetch_TakeHome.git
   ```

2. Open the Project in Xcode
    * Launch Xcode.
    * Navigate to the cloned project folder.
    * Open the .xcworkspace file (if it exists; otherwise, open the .xcodeproj file).

3. Open the Project in Xcode
    * In Xcode, click on Product > Destination from the top menu.
    * Select an iOS simulator.
    * If no simulators are available, go to Settings > Device Manager and create a new one.

4. Run the app


## Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
In this project, I prioritized implementing a **clear MVVM architecture** to ensure a clean separation of concerns between the UI and business logic. This approach allowed me to focus on structuring the code in a way that is scalable, maintainable, and testable. The `RecipeViewModel` encapsulates all data-fetching and state management logic, ensuring the `ContentView` remains solely responsible for rendering the user interface and reacting to state changes.

By centralizing the logic in the ViewModel, I could handle different scenarios, such as loading, filtering, and error states, effectively while keeping the UI code concise and declarative. Additionally, this structure facilitates unit testing of the business logic independently of the UI, improving the project's overall quality. This focus ensures a robust foundation for future enhancements or modifications to the app.

## Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
I spent approximately 5 hours to complete the whole project. Given my responsibilities as a student with ongoing assignments, I utilized fragmented periods to work on the project. Each session typically lasted one to two hours, during which I focused on implementing specific features or resolving particular issues.

Additionally, I made effective use of commuting time and shorter breaks to mentally strategize and visualize potential solutions. This approach allowed me to conceptualize and refine the project's structure, such as deciding on the MVVM architecture, the best ways to handle API calls, and optimizing user experience, even when I wasn't actively coding. This blend of focused implementation and continuous ideation helped me manage my time efficiently and deliver a complete project within a limited timeframe.

## Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
In this project, I made a few trade-offs to ensure timely completion and a balance between functionality and complexity:

* Simplified Testing: While I implemented unit tests for both the model decoding and view model behavior, the tests focus on easily identifiable issues and common failure scenarios, such as malformed data or empty data. More comprehensive edge-case testing, such as handling large datasets or partial data corruption, was deferred to save time.

* Basic Error Handling: The error messages are functional but not highly descriptive or user-friendly. For example, an invalid endpoint or a failed network request simply displays a general message. A more detailed error-handling mechanism, with user-friendly suggestions or retry options, was not prioritized to streamline development.

* Static Endpoint Selection: I chose to hard-code the API endpoints for simplicity and to avoid spending additional time on a dynamic configuration system. This approach limits the flexibility of the app but allowed me to focus on implementing the core functionality.

* Minimal UI Customization: The user interface, while functional and clean, is relatively basic. Advanced UI features, such as animations or more sophisticated filtering options, were not included to focus on delivering a working prototype within the allocated time.

## Weakest Part of the Project: What do you think is the weakest part of your project?
The weakest part of the project lies in the testing. While I have implemented tests to verify key functionalities, they are not exhaustive and do not cover every potential scenario that could occur in a real-world application.

* UI Design Expertise:** While the functionality of the project is solid, UI design is not my area of expertise. Although the interface is functional and fulfills its purpose, it lacks creativity and refined aesthetics. Creating visually engaging designs remains a challenge for me, and the current UI could benefit from more innovative design elements.

* Limited Test Coverage:** The test cases cover basic scenarios, such as fetching valid data, handling malformed or empty data, and invalid URLs. However, they do not address edge cases like network latency, large data sets, or unexpected server behaviors, which are critical for ensuring robustness in real-world applications.

* Mocking Dependencies:** Tests are dependent on actual endpoints, as there is no mocking of API responses or external dependencies. This reliance on live endpoints means tests could fail if the API changes or the network is unavailable, reducing reliability and reproducibility.

* Asynchronous Handling in Tests:** While asynchronous operations are addressed in tests such as `testFetchRecipesSuccess` and `testFetchRecipesMalformedData`, these tests could be more robust. Incorporating mock data sources, handling timeouts properly, and ensuring that all asynchronous scenarios are well-tested would improve overall reliability.

## External Code and Dependencies: Did you use any external code, libraries, or dependencies?
This project uses the SDWebImageSwiftUI library for caching downloaded images.

The SDWebImageSwiftUI library is a well-known and widely-used tool for managing image downloads and caching in SwiftUI applications. By caching images locally, the library helps avoid repeatedly fetching the same images from the network. This improves the app's performance and enhances the user experience by:

* Reducing Load Times: Cached images are loaded directly from local storage, resulting in faster display times for users.
* Minimizing Network Usage: By avoiding redundant network calls for previously downloaded images, the app consumes less data and reduces server load.
* Smooth Scrolling Experience: Pre-cached images ensure that UI components like lists and grids load smoothly without lags or delays.

The integration of this library aligns with modern app development best practices for efficient resource management and seamless user experience.


## Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.

During the development of this project, I encountered a few constraints and insights worth mentioning:

* Time Constraints: As a student balancing coursework and assignments, I completed the project in fragmented intervals. This required effective time management and planning, ensuring each work session focused on meaningful progress.

* Learning Curve: While I am familiar with the MVVM architecture and SwiftUI, I had to adapt and refine my implementation to handle asynchronous data fetching effectively. This project reinforced my understanding of @MainActor and the importance of managing UI updates on the main thread.

* Limited Scope: Given the project's timeframe, I prioritized implementing essential functionality, such as filtering recipes, which I consider an instinctive UI feature. However, being creative in UI design remains a challenge for me. While I can deliver a product with a complex UI design, it has been difficult for me to come up with a refined and intuitive UI. This project highlighted the need to improve my skills in simplifying and optimizing UI design for better user experiences.