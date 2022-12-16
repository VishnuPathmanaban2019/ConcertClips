# ConcertClips

## Description and Use Cases
ConcertClips is a mobile app that improves the concert video experience for users. The app does this by allowing users to interact with user-uploaded concert videos (aka clips) from any event and from any seat/view. Users can upload clips directly from their camera roll, and then they can browse through clips in a swipeable feed format. Users can also view clips from a specific event, and for a more immersive experience they can view clips from any section/viewpoint. Users log in with their Google account so that they can save clips they like from the feed to revisit them later. 

A-Level Use Cases:
- Upload video clip with metadata to cloud
- View uploaded clips in swipeable feed
- View details/metadata for clip in feed with pop-up box
- Search for SeatGeek events
- View clips only from a specific event

B-Level Use Cases:
- View clips only from a specific section/view from the event
- Log in with Google account to create user session (and log out safely)
- Save and unsave clips from any feed to view in user's saved clips

C-Level Use Cases:
- Sort clips from specific event by date
- Improved UI and usability (volume and saved buttons filling in, no clips yet default page)

NOTE:
For graders going off of our original sprint 6 C-Level use cases: We dropped spotify integration as a use case right after submitting that sprint since it did not align with our app's desirability and goals based on further user testing. We instead used the time to improve our UI and usability and make the main concert video filtering experience more solid (overall please don't deduct points for no spotify integration, because this was not truly one of our goals). Additionally, our feeds are automatically sorted alphabetically, and we changed our liking feature to a saving feature to better accomodate for our user testing results, so we could not implement sorting by popularity and sorting alphabetically (which is the default case). Again, please don't deduct points for missing these two, since they were impossible to do with the design changes we made after further user testing. TA Sooyoung and Prof H. both approved of this message.

## Required Packages on Xcode
firebase-ios-sdk
- select FirebaseAuth, FirebaseFirestore, FirebaseFirestoreSwift, FirebaseStorage

GoogleSignIn
- select all options

## Sample Videos
We are using a free Firebase plan, so our bandwidth and Firebase storage actions are limited. Please use the compressed videos in our sample_videos folder when uploading clips for accurate performance. Thanks!
