# League iOS Challenge

Welcome to my submission for the League iOS Challenge! This app demonstrates a social media feed with authentication, posts, and user profiles built using a hybrid SwiftUI and UIKit approach.

## Features

- **Authentication Flow**
  - Login with username and password
  - Continue as guest option
  - Token-based API authentication

- **Social Feed**
  - Browse posts with user information
  - Clean, responsive UI with loading states
  - Error handling with user feedback

- **User Profiles**
  - Modal presentation
  - Profile details and avatar display
  - Email validation

## Architecture

This project showcases several modern iOS development practices:

- **MVVM Pattern** - Clean separation of view and business logic
- **Router Pattern** - Type-safe navigation between screens
- **Scene Pattern** - Dependency injection and view controller assembly
- **SwiftUI + UIKit Integration** - Best of both worlds approach

## Navigation
The Router implements a reusable navigation pattern:

- Modal and full-screen presentation options
- Generic type constraints for type safety
- Scene-specific routers for dedicated navigation logic

## SwiftUI Integration
The project uses SwiftUIViewController to bridge SwiftUI and UIKit:

Embed SwiftUI views inside UIKit controllers
Maintain UIKit navigation and lifecycle control
Leverage SwiftUI's declarative UI benefits

## Screens
Login Screen

Username/password authentication
Guest mode access
Error handling and loading state

Feed Screen

Displays posts with user information
Pull to refresh functionality
Tapping on users shows their profile

Profile Screen

Modal presentation
User details display
Email validation
