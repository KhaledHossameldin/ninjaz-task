# Interview Task: Ninjaz

The repository contains my submission for the interview task provided by Ninjaz. The task involved developing a mobile application that fulfills specific requirements outlined by Ninjaz, including UI development, testing and GitHub Actions setup.

## Task requirements

The task required the implementation of the following features:

1. **Bottom Navigation:** Create a bottom navigation bar with three tabs: "Posts" (default and active tab), "Tab 2," and "Tab 3."
1. **Tab Navigation Behavior:** Make "Tab 2" and "Tab 3" clickable, displaying a placeholder message "Coming soon" when clicked.
1. **Posts List:** Fetch data from a provided API endpoint, displaying it in a responsive UI with essential information such as owner's full name, creation date, post images, text, title, tags, and number of likes. Handle cases of missing data.
1. **Efficient List:** Implement a list of posts that works offline using Realm, supports pull-to-refresh, and loads more posts when scrolled to the end.
1. **Testing:** Implement both unit and end-to-end testing for the application.
1. **GitHub Repository and GitHub Actions:** Create a public GitHub repository hosting the project and set up a GitHub Actions workflow to run tests, build APK, and send an email notification upon completion.
1. **APK Stability:** Ensure the built APK is stable and doesn't crash during normal usage.
1. **Common Sense:** Use judgment to fill in missing details or features that would enhance the user experience.

## Implementation

I have implemented the task according to the requirements provided by Ninjaz. Here's a brief overview of the key components:

- **UI Development:** Developed a responsive UI with a bottom navigation bar and three tabs. Designed the "Posts" tab to display fetched post data and implemented placeholder behavior for the other tabs.
- **API Integration:** Utilized the provided API endpoint to fetch post data and displayed it in the "Posts" tab. Handled cases of missing data gracefully.
- **Efficient List:** Implemented a highly efficient list of posts using Realm for offline capabilities, pull-to-refresh feature, and infinite scroll for loading more posts.
- **Testing:** Implemented unit tests to ensure the functionality of individual components. Unfortunately, due to unforeseen circumstances, end-to-end testing could not be completed.
- **GitHub Actions:** Set up a GitHub Actions workflow to automate testing, build APK, and send email notifications upon completion. The workflow ensures continuous integration and deployment.

## Usage

To run the application locally, follow these steps:

1. Clone this repository to your local machine.
1. Install dependencies using `flutter pub get`.
1. Run the application using `flutter run` or just launch it with the desired IDE.
1. Access the application in your preferred mobile emulator or device.

## Future Improvements

Although the task requirements have been met, there are areas for potential improvement, including:

- Completing end-to-end testing to ensure comprehensive test coverage.
- Enhancing the UI/UX for a more polished and intuitive user experience.
- Optimizing performance further, especially for handling large volumes of data.

## Contact Information

If you have any questions or feedback regarding this submission, please feel free to contact me at khaled-hossam@outlook.com.

Thank you for considering my submission. I look forward to the opportunity to discuss it further.

Khaled
