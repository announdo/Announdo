
# Annondo

An app made with Flutter. This app helps students to find their school announcements, Annondo helps students that are not present in school know about the events of school, or even if they forgot about a specific event they can just open the app and find the announcements.

This app is currently only available for Thornhill secondary school, soon other schools will be added to the YRDSB region.

With ANNONDO you can read all the announcements and never forget what happened that day.
ANNONDO is the app you need to remember your announcements :)
## How does it work?!
when teachers import the announcement of the day, you can view and never forget about it.
each school will have a specific password and without the password and the code that is attached to that password, you cannot view the school's announcements.
Only teachers can change the announcements and they are predetermined.


## Available on!


<div><a href="https://play.google.com/store/apps/details?id=com.announdo.announdo"><img src="https://www.svgrepo.com/show/303139/google-play-badge-logo.svg" width="15%" height="120"></a>
<a href="https://apps.apple.com/us/app/annondo/id1623010127"><img src="https://www.svgrepo.com/show/303128/download-on-the-app-store-apple-logo.svg" width="15%" height="120"></a></div>

## Demo:


https://user-images.githubusercontent.com/68626539/167960448-b966af8e-a30f-40b6-85ca-c2db49590d6f.mp4

# Security, boring but required.

## How auth works:

A ticket is created by a trusted user via the app. The following info is stored onto firebase: (if the ticket is deleted, then users that used the ticket to login will be denied access)

Code Phrase, Token (unique), Phrase Expiry Date, Token Expiry Date, Type (auth)

Users are able to request the Auth Token given the code phrase, Firebase will check the expiry date. (Note: The token will NOT expire after this date)

This token is stored on the client, and is used in every authenticated request.

Trusted users can login with their email and password, which is created on the Firebase console.

## How announcement submission works

A ticket is created by a trusted user via the app. The following info is stored onto firebase:

Code Phrase, Type (submission), Submitter Alias

The code phrase is then shared to a student/staff who is designated to submit announcements to the app.

When submitting an announcement, firebase checks the phrase against the list of tickets.

Submission record:

Title, Description, Start Time, End Time, Priority, Is Draft (true), Submitter Alias, Priority (0)

The submission may be approved by a trusted user, and the draft status can be set to false, and they may give a priority to the post.

## Created by who???!

Created By AlPHA & encodeous With ❤️
