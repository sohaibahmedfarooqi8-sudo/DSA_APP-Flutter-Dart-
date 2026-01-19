DSA Todo Manager - Flutter Application
A comprehensive Flutter to-do list application that demonstrates multiple Data Structures and Algorithms (DSA) concepts in a real-world mobile application context.
🎯 Project Overview
This project showcases the practical application of fundamental data structures and algorithms by implementing a fully functional to-do list manager. Each DSA concept is integrated naturally into the app's functionality, providing both educational value and practical utility.
🏗️ Architecture & Data Structures
Implemented Data Structures
1. Stack (LIFO - Last In, First Out)
Purpose: Undo/Redo functionality
Implementation: lib/src/core/data_structures/stack.dart
Usage: Tracks user actions for reversible operations
Time Complexity: O(1) for push/pop operations
2. Queue (FIFO - First In, First Out)
Purpose: Task scheduling and priority management
Implementation: lib/src/core/data_structures/queue.dart
Usage: Manages task execution order
Time Complexity: O(1) for enqueue/dequeue operations
3. Linked List
Purpose: Efficient task storage and memory optimization
Implementation: lib/src/core/data_structures/linked_list.dart
Usage: Dynamic task management with O(1) insertion/deletion
Features: AddFirst, AddLast, RemoveFirst, Find operations
4. Binary Search Tree (BST)
Purpose: Efficient task searching and sorting
Implementation: lib/src/core/data_structures/binary_search_tree.dart
Usage: Fast task lookup and sorted retrieval
Time Complexity: O(log n) average case for search/insert
Algorithm Implementations
Sorting Algorithms
Quick Sort: O(n log n) average case
Merge Sort: O(n log n) guaranteed
Bubble Sort: O(n²) for educational purposes
Custom Comparators: Priority-based and date-based sorting
Searching Algorithms
Linear Search: O(n) for flexible text matching
Binary Search: O(log n) for sorted data
Advanced Filtering: Multi-criteria search with priority, status, and dates
🚀 Features
Core Functionality
✅ Task Management: Create, read, update, delete tasks
✅ Priority System: High, Medium, Low priority levels
✅ Status Tracking: Pending, In Progress, Completed states
✅ Due Date Management: Calendar integration with date picking
✅ Search & Filter: Multi-criteria search and filtering
✅ Undo/Redo System: Complete action reversal using Stack
Advanced Features
🎯 DSA Statistics: Real-time display of data structure metrics
🔄 Multiple Sorting Options: Choose from different sorting algorithms
🔍 Advanced Search: Text search with priority and status filters
⭐ Task Starring: Mark important tasks
📊 Visual Indicators: Color-coded priorities and status badges
🎨 Modern UI: Clean, responsive design with Material 3
🛠️ Technical Implementation
Project Structure
Copy
lib/
├── src/
│   ├── app.dart                 # Main app widget
│   ├── core/
│   │   ├── data_structures/     # DSA implementations
│   │   │   ├── stack.dart
│   │   │   ├── queue.dart
│   │   │   ├── linked_list.dart
│   │   │   └── binary_search_tree.dart
│   │   ├── algorithms/          # Sorting and searching
│   │   │   ├── sorting.dart
│   │   │   └── searching.dart
│   │   └── theme/               # App theming
│   │       └── app_theme.dart
│   └── features/
│       └── todo/
│           ├── domain/
│           │   ├── models/        # Task model
│           │   └── services/      # Task service with DSA
│           └── presentation/
│               ├── pages/         # UI pages
│               └── widgets/       # UI components
└── main.dart
Key Classes
Task Model (task.dart)
dart
Copy
class Task implements Comparable<Task> {
  final String id;
  final String title;
  final String description;
  final TaskPriority priority;
  TaskStatus status;
  final DateTime createdAt;
  DateTime? dueDate;
  bool isStarred;
}
Task Service (task_service.dart)
Integrates all data structures
Manages undo/redo operations
Provides search and sort functionality
Handles task CRUD operations
📱 UI/UX Design
Design Principles
Material Design 3: Modern, clean interface
Responsive Layout: Works on all screen sizes
Dark/Light Mode: System-aware theming
Accessibility: Proper contrast ratios and touch targets
Visual Elements
Color Coding: Priority-based color system
Status Indicators: Visual badges for task states
Interactive Elements: Smooth animations and feedback
Statistics Dashboard: Real-time DSA metrics
🎯 DSA Learning Outcomes
Concepts Demonstrated
Stack Operations: Push, pop, peek for undo/redo
Queue Management: FIFO principles in task scheduling
Linked List Efficiency: Dynamic memory management
Binary Search Tree: Fast searching and sorting
Algorithm Complexity: Real-world performance implications
Data Structure Selection: Choosing the right tool for each feature
Performance Considerations
Time Complexity Analysis: Each operation's efficiency
Memory Management: Linked list vs array performance
Search Optimization: BST vs linear search trade-offs
Sorting Efficiency: Algorithm selection based on data size
🚀 Getting Started
Prerequisites
Flutter SDK (3.0.0 or higher)
Dart SDK (2.17.0 or higher)
Android Studio / VS Code
Git
Installation
Clone the Repository
bash
Copy
git clone <repository-url>
cd dsa-todo-manager
Install Dependencies
bash
Copy
flutter pub get
Run the Application
bash
Copy
flutter run
Building for Production
bash
Copy
# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Build Web
flutter build web --release
🧪 Testing
Unit Tests
bash
Copy
flutter test
Integration Tests
bash
Copy
flutter drive --target=test_driver/app.dart
📊 Performance Metrics
Data Structure Performance
Stack Operations: O(1) for all operations
Queue Operations: O(1) for enqueue/dequeue
Linked List: O(1) for head operations, O(n) for search
Binary Search Tree: O(log n) average case
Algorithm Performance
Quick Sort: O(n log n) average, O(n²) worst
Merge Sort: O(n log n) guaranteed
Linear Search: O(n) for n elements
Binary Search: O(log n) for sorted data
🎓 Educational Value
Learning Objectives
Practical DSA Application: See data structures in action
Performance Analysis: Understand time/space complexity
Algorithm Selection: Learn when to use which algorithm
Real-world Implementation: Bridge theory and practice
Study Guide
Examine Data Structures: Study each implementation
Analyze Algorithms: Understand sorting and searching
Trace Operations: Follow undo/redo stack operations
Performance Testing: Measure algorithm efficiency
🔧 Customization
Adding New Data Structures
Create new file in lib/src/core/data_structures/
Implement the data structure with proper methods
Integrate into TaskService class
Update UI to showcase new functionality
Adding New Algorithms
Create new file in lib/src/core/algorithms/
Implement the algorithm with proper documentation
Add to the sorting/searching service
Update UI to include new options
📈 Future Enhancements
Planned Features
[ ] Graph Algorithms: Task dependency management
[ ] Hash Tables: Faster task lookup
[ ] Heap Data Structure: Priority queue optimization
[ ] Advanced Sorting: Heap sort, radix sort implementations
[ ] Data Persistence: Local storage with SQLite
[ ] Cloud Sync: Firebase integration
[ ] Analytics Dashboard: Performance metrics visualization
Contributing
Contributions are welcome! Please read the contributing guidelines and submit pull requests for any improvements.
📄 License
This project is licensed under the MIT License - see the LICENSE file for details.
🙏 Acknowledgments
Flutter Team: For the amazing framework
Material Design Team: For design guidelines
Computer Science Community: For DSA knowledge
Open Source Contributors: For inspiration and tools
📞 Support
For questions, issues, or contributions:
Create an issue in the repository
Check the documentation
Review the code comments
Test with sample data
