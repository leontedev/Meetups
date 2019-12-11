# Friends Meetup

**#100DaysOfSwiftUI Day 77, Challenge #5: https://www.hackingwithswift.com/guide/ios-swiftui/6/3/challenge**

![](gif.gif)

Have you ever been to a conference or a meetup, chatted to someone new, then realized seconds after you walk away that you’ve already forgotten their name? You’re not alone, and the app you’re building today will help solve that problem and others like it.

Your goal is to build an app that asks users to import a picture from their photo library, then attach a name to whatever they imported. The full collection of pictures they name should be shown in a List, and tapping an item in the list should show a detail screen with a larger version of the picture.

Breaking it down, you should:

Wrap UIImagePickerController so it can be used to select photos.
Detect when a new photo is imported, and immediately ask the user to name the photo.
Save that name and photo somewhere safe.
Show all names and photos in a list, sorted by name.
Create a detail screen that shows a picture full size.
Decide on a way to save all this data.