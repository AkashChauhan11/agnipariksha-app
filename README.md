# Agni Pariksha - Quiz Application

A comprehensive Flutter quiz application built with clean architecture principles and BLoC pattern for state management.

## Features

### 🎯 Quiz Section
- **Quiz List**: Browse available quizzes with attractive cards
- **Quiz Interface**: Interactive 10-question quiz with multiple choice options
- **Real-time Timer**: Track time spent on each question and total quiz time
- **Progress Tracking**: Visual progress bar and question counter
- **Navigation**: Previous/Next question navigation with answer persistence
- **Attractive Results**: Comprehensive statistics and performance metrics

### 📊 Quiz Categories
1. **Indian Constitution** - Test knowledge about constitutional principles
2. **Indian History** - Explore India's rich historical heritage
3. **Geography of India** - Learn about India's diverse geography
4. **General Knowledge** - Test general awareness and current affairs

### 🎨 User Interface
- **Modern Design**: Clean, attractive UI with gradient backgrounds
- **Responsive Layout**: Works seamlessly across different screen sizes
- **Visual Feedback**: Color-coded options and progress indicators
- **Smooth Animations**: Enhanced user experience with smooth transitions

### 📈 Results & Analytics
- **Score Calculation**: Percentage-based scoring system
- **Performance Metrics**: 
  - Correct/Incorrect answers
  - Time taken per question
  - Overall accuracy and efficiency
- **Visual Statistics**: Progress bars and attractive stat cards
- **Performance Categories**: Excellent, Good, Average, Need Improvement

## Architecture

### Clean Architecture Implementation
```
lib/
├── core/
│   └── app_theme.dart
├── features/
│   └── dashboard/
│       ├── data/
│       │   ├── data_sources/
│       │   │   ├── dashboard_remote_data_source.dart
│       │   │   └── quiz_data_source.dart
│       │   ├── models/
│       │   │   ├── dashboard_model.dart
│       │   │   └── quiz_model.dart
│       │   └── repositories/
│       │       ├── dashboard_repository_impl.dart
│       │       └── quiz_repository_impl.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   ├── dashboard.dart
│       │   │   └── quiz.dart
│       │   ├── repositories/
│       │   │   ├── dashboard_repository.dart
│       │   │   └── quiz_repository.dart
│       │   └── usecases/
│       │       ├── get_dashboard_data.dart
│       │       ├── get_available_quizzes.dart
│       │       ├── get_quiz_questions.dart
│       │       └── save_quiz_result.dart
│       └── presentation/
│           ├── bloc/
│           │   ├── dashboard_bloc.dart
│           │   └── quiz_bloc.dart
│           ├── pages/
│           │   ├── dashboard_screen.dart
│           │   ├── home_page.dart
│           │   ├── profile_page.dart
│           │   └── quiz_page.dart
│           └── widgets/
│               ├── banner_carousel.dart
│               ├── category_grid.dart
│               ├── quiz_list_widget.dart
│               ├── quiz_interface_widget.dart
│               └── quiz_results_widget.dart
└── main.dart
```

### State Management
- **BLoC Pattern**: Clean separation of business logic and UI
- **Event-Driven**: Reactive architecture with event handling
- **State Persistence**: Maintains quiz state throughout the session

## Getting Started

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Android Studio / VS Code

### Installation
1. Clone the repository
```bash
git clone <repository-url>
cd agni_pariksha
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the application
```bash
flutter run
```

### Running Tests
```bash
flutter test
```

## Quiz Flow

1. **Quiz Selection**: User browses available quizzes from the quiz section
2. **Quiz Start**: User clicks "Start Quiz" button to begin
3. **Question Navigation**: User answers questions and navigates through them
4. **Quiz Completion**: User finishes the quiz and views results
5. **Results Analysis**: User reviews performance statistics and can retry

## Technical Features

### Data Management
- **Mock Data**: Comprehensive quiz questions for each category
- **Local Storage**: Quiz results persistence (ready for implementation)
- **Error Handling**: Robust error handling with user-friendly messages

### UI Components
- **Custom Widgets**: Reusable components for quiz interface
- **Responsive Design**: Adapts to different screen orientations
- **Accessibility**: Proper semantic labels and navigation

### Performance
- **Optimized Rendering**: Efficient widget rebuilding
- **Memory Management**: Proper disposal of timers and resources
- **Smooth Animations**: 60fps animations for better UX

## Future Enhancements

- [ ] **User Authentication**: Login/signup functionality
- [ ] **Leaderboards**: Compare scores with other users
- [ ] **Offline Support**: Download quizzes for offline use
- [ ] **Push Notifications**: Reminders for daily practice
- [ ] **Analytics Dashboard**: Detailed performance tracking
- [ ] **Custom Quizzes**: User-generated quiz creation
- [ ] **Social Features**: Share results and challenge friends

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support and questions, please open an issue in the repository or contact the development team.
