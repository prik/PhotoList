# PhotoList

My first iOS app 🎉 

Created entirely in code, without using Storyboard.


## Features

- MVVM architecture
- Main screen that contains a list of photos from https://jsonplaceholder.typicode.com/photos
  - Showing the title and thumbnail
  - The list is sorted alphabetically on the title of every photo
- Detail screen when a user clicks the photo that contains:
  - The title
  - The image (not the thumbnail)
  - A list of the first 20 comments found at https://jsonplaceholder.typicode.com/photos/{id}/comments
- Loading state on the main screen
- Error state on the main screen (i.e. in case of no internet)
- Error state on the images in case it cannot load
- Pull to refresh on the main screen
- Pull to refresh on the list of comments found in the detail screen
