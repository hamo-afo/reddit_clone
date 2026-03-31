# Reddit Tutorial App

A full-featured Flutter mobile application that replicates core Reddit functionality, built with Firebase and Riverpod state management.

## 🎯 Project Overview

This project demonstrates modern Flutter development practices by implementing a Reddit-like social platform with user authentication, community management, post creation, and real-time interactions. It serves as a comprehensive reference for building scalable mobile applications with Firebase backend integration.

## ✨ Features

### Authentication

- **Google Sign-In**: OAuth integration using Firebase Authentication
- **User Registration & Login**: Custom authentication with email/password
- **Persistent Sessions**: Automatic login on app restart with shared preferences

### Communities

- **Create Communities**: Users can create and manage communities
- **Community Directory**: Browse and join existing communities
- **Community Rules & Settings**: Manage community-specific configurations

### Feed & Posts

- **Dynamic Feed**: Real-time feed displaying posts from followed communities
- **Create Posts**: Support for text-based and link-based posts
- **Post Management**: Edit and delete own posts
- **Post Interactions**: Upvote/downvote system with awards

### User Profiles

- **User Profiles**: View user information and post history
- **Karma System**: Track user reputation and contributions
- **Follow/Unfollow**: Connect with other users

### Comments & Discussions

- **Nested Comments**: Reply to posts and other comments
- **Comment Editing**: Modify or delete comments
- **Real-time Updates**: Live comment feeds using Firestore listeners

### Awards System

- **Award Badges**: Give awards to posts and comments
- **Award Display**: Visual representation of received awards

## 🏗️ Architecture

### State Management

- **Flutter Riverpod**: Provider-based state management for efficient data handling
- **Controllers**: Business logic separated into feature-specific controllers
- **Providers**: Reactive data flow for UI updates

### Code Organization

```
lib/
├── features/          # Feature modules
│   ├── auth/         # Authentication screens & logic
│   ├── community/    # Community management
│   ├── feed/         # Feed display
│   ├── home/         # Home screen
│   ├── post/         # Post creation & management
│   └── user_profile/ # User profiles
├── model/            # Data models
├── core/             # Core utilities & common widgets
│   ├── common/       # Shared UI components
│   ├── constants/    # App constants
│   ├── enums/        # Enumerations
│   ├── providers/    # Global providers
│   ├── utils.dart    # Utility functions
│   ├── failure.dart  # Error handling
│   └── type_defs.dart # Type definitions
├── theme/            # App theming
├── main.dart         # App entry point
├── router.dart       # Route management
└── firebase_options.dart # Firebase configuration
```

## 🛠️ Tech Stack

### Frontend

- **Flutter 3.5.0+**: Cross-platform mobile UI framework
- **Dart 3.5.0+**: Programming language
- **Riverpod 2.6.1**: State management and dependency injection
- **Routemaster 1.0.1**: Navigation and routing

### Backend & Services

- **Firebase Authentication**: User identity management
- **Cloud Firestore**: Real-time NoSQL database
- **Firebase Storage**: File storage for user content
- **Google Sign-In 6.2.2**: OAuth authentication

### Additional Libraries

- **fpdart 1.1.0**: Functional programming utilities
- **file_picker 6.0.0**: File selection for uploads
- **uuid 4.5.3**: Unique identifier generation
- **any_link_preview 3.0.3**: Link preview widget
- **shared_preferences 2.5.3**: Local storage
- **dotted_border 2.1.0**: UI components

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (version 3.5.0 or higher)
- Dart SDK (version 3.5.0 or higher)
- Firebase project account
- Android Studio + Android SDK or Xcode + iOS SDK

### Installation Steps

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/reddit_tutorial.git
   cd reddit_tutorial
   ```

2. **Install Dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Go to [Firebase Console](https://console.firebase.google.com)
   - Create a new project or select an existing one
   - Download `google-services.json` from Firebase Console
   - Place it at `android/app/google-services.json`

4. **Generate Firebase Options**

   ```bash
   dart run flutterfire configure
   ```

   - Select your Firebase project when prompted
   - This generates `lib/firebase_options.dart` automatically

5. **Run the App**
   ```bash
   flutter run
   ```

   - For Android: `flutter run -d android`
   - For iOS: `flutter run -d ios`

### Security Setup

⚠️ **Important**: The following files contain sensitive information and must never be committed:

- `google-services.json` - Firebase Android configuration
- `lib/firebase_options.dart` - Firebase project settings
- `android/local.properties` - Local build configuration
- `.env` or any `.env.local` files - Environment variables
- `.dart_tool/` - Build artifacts
- `build/` - Build output directory

These files are listed in `.gitignore` and should be generated locally or downloaded from Firebase Console.

## 📁 Project Structure Details

### Models (`lib/model/`)

- `user_model.dart`: User data structure and serialization
- `community_model.dart`: Community information and management
- `post_model.dart`: Post content and metadata
- `comment_model.dart`: Comment structure and relationships

### Core (`lib/core/`)

- **common/**: Reusable UI widgets (ErrorText, Loader, etc.)
- **constants/**: App-wide constants and configuration
- **enums/**: Enumeration types for status, user roles, etc.
- **providers/**: Global state providers (theme, user auth state)
- **failure.dart**: Error/exception handling classes
- **type_defs.dart**: Typedef definitions for common patterns
- **utils.dart**: Utility functions and helpers

### Features

Each feature follows a clean architecture pattern:

```
feature/
├── controllers/      # Business logic
├── screens/          # UI screens
├── repositories/     # Data access layer
└── providers/        # Feature-specific providers
```

## 🔄 Data Flow

1. **UI Layer**: Flutter widgets display data from providers
2. **Provider Layer**: Riverpod manages state and data synchronization
3. **Controller Layer**: Business logic processes user actions
4. **Repository Layer**: Handles Firestore queries and data operations
5. **Firebase Layer**: Cloud Firestore stores and retrieves data

## 📱 Supported Platforms

- ✅ Android (minimum API level 21)
- ✅ iOS (minimum iOS 11.0)
- ⚠️ Web (partial support)
- ⚠️ Windows (partial support)
- ⚠️ macOS (partial support)
- ⚠️ Linux (partial support)

## 🔐 Firebase Configuration

### Firestore Rules

- Located in `firestore.rules`
- Implements role-based access control
- Restricts data access to authenticated users only

### Storage Rules

- Located in `storage.rules`
- Manages file upload permissions
- Validates file types and sizes

### Indexes

- Located in `firestore.indexes.json`
- Optimizes complex queries
- Auto-generated by Firebase CLI

## 🐛 Known Issues & Limitations

- Web platform has limited Firebase Storage support
- Some native features not available on desktop platforms
- Real-time syncing may have latency on slow connections

## 📚 Learning Resources

- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase for Flutter](https://firebase.flutter.dev)
- [Riverpod Guide](https://riverpod.dev)
- [Clean Architecture in Flutter](https://resocoder.com/flutter-clean-architecture)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Guidelines

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Author

Created as a Flutter tutorial project demonstrating modern app development practices.

## 🎓 Educational Value

This project is an excellent resource for:

- Learning Flutter fundamentals and advanced concepts
- Understanding Firebase integration patterns
- Implementing Riverpod state management
- Clean Architecture principles in mobile development
- Real-world application patterns and best practices

## 📞 Support

For questions or issues, please open an issue on the GitHub repository.

---

**Last Updated**: March 2026  
**Flutter Version**: 3.5.0+  
**Dart Version**: 3.5.0+
