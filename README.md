# Running the app
Some credentials have been prepared in order to view different features of the app. This account comes with different habits and their progress pre-populated in advance to view how the app looks without actually using the app over an extended period of time.
Username: 123
Password: abc
# Features
- View each habit's details by clicking on the heatmap calendar in the Habit View
- Habits have 3 states:
	- Active: Habits that are ongoing.
	- Archived: Hidden on homescreen by default. Click the button to view archived habits
	- Suspended habits: It will be hidden on the homescreen by default. This was meant to be implemented before the deadline but I ran into some issues.
	
1) Habit View screen:
	- View each habit's details by clicking on the heatmap
	- View archived habits by toggling using the button at the bottom of the screen.
	- This screen can be accessed through the hamburger menu at the left.
2) Log habit:
	- Habits can be logged. When a habit reach their max count, the habit disappears from the logging screen and today's date is automatically logged such that the item on the heatmap calendar is filled.
3) Habit detail screen:
	- The details of each habit can be seen here. 
	- Archived habits cannot be suspended or unarchived.
	- Deleted habits are gone forever.
# Design Decisions
- Opted to follow Perfingo's green colour. 
- From a personal perspective, I was incapable of using such tracking apps because most of them were overcomplicated/slow and I spent disproportionately more time on the apps than my actual goals.
- Tracking should be a very simple process that should not take more than a few seconds. This was my design principle when designing the app -- no frills, just a clean and simple user interface to allow users to focus on the process of cultivating their habits, rather than spending time trying to log their habits.

# Challenges
- Choice of framework: The primary challenge I faced was my unfamiliarity with Flutter -- I had to learn Flutter and Dart (minor concern because it looks similar to Java which I am familiar with) and develop an application in just a few days. I chose Flutter for this project because I wanted to learn a new framework instead of sticking to what I already knew. Admittedly, this resulted in the app being half-baked due to time constraints, with many unimplemented features that could have been implemented in the same timeframe if I had stuck to a framework that I was familiar with.
# Unimplemented things
Due to time constraint, academic workload (midterms week) and my unfamiliarity with Flutter, I was unable to do the following within the deadline, but I'm planning to convert this into my personal project and these features will probably get implemented down the road (you might have tried to access the 'Settings' page which was where I would put some of those features, or seen an unused dropdown button widget which I was planning to use for these settings)
- Suspended: Habits whose streaks have been suspended until a specified date. It has been partially implemented and thus, will warn the user in the dialog box that it doesn't work as intended (for now!)
- Streaks and tie-in with suspension system:
	-  Streaks: When a habit is completed on time for multiple days in a row, streaks accumulate to encourage users to continue with their habit by playing on the sunk cost fallacy, which leads to the next point.
	- While streaks may be fun to accumulate and is a powerful driving force, I didn't want to force users to adhere too strictly to them. The suspension system is to allow users to suspend their habit tracking for a period of time and allow the streaks to ignore those days. For example, it may not be feasible to continue with a habit strictly if a user goes on vacation. 
	- Each suspension is recorded and the user will have to justify their decision (to themselves), to ensure that the feature isn't abused.
- Possibly multiple themes for users to use, including custom themes that allow users to customize the app to their liking. 
- Different views for the habit view window
- Homescreen widgets
- Duration for habits (example: 25 mins a day twice a day) The app may display a timer and also ties in to the next point:
- Notifications: Users can set notifications to inform them to track their habits at a specified time/when they can stop performing the habit + auto logging
- Wearable data integration for sports (if someone wants to run x number of minutes, the data can be retrieved from their smart device)
- Responsive design for different screen sizes
- Icons for each habit, including custom icons
- Different frequencies for tracking: (if a user wants to track a weekly habit, give them the option to do so, and add in a different calendar/view style for different habit frequencies.)
- Dialog confirmation before archiving/deleting habits

# Code specific unimplemented things
- The backend should update the database using IDs as the filter, not the username/title.
- Code deduplication needs to be done for some components. (copied and pasted due to time constraint when they should have been abstracted out for extensibility)
- Look into why the auto-formatter doesn't work for Dart (alignment issues with code, looks quite ugly and hard to read)

# About the backend
- The backend and user authentication experience wasn't required, but I opted to add them in to showcase what I can do in the backend, and also to display this project on my own Github portfolio.
- Of course, since this is an assessment to test how much we can work with unknown requirements, if instructed to develop something and given the scope, I'll stick to the original plan. Especially for production apps where I can't just use a toy database and test credentials.
- Conscious decision to ignore username and password validation (other than null values for usernames/password and duplicates for usernames) for simplicity.
- If the app were completely offline, I use SQLite for storage.
