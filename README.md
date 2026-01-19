# DSA Todo Manager - Flutter Application

A comprehensive Flutter to-do list application demonstrating multiple Data Structures and Algorithms (DSA) concepts in a real-world mobile application context.

---

## 🎯 Project Overview

### 🏗️ Architecture & Data Structures

#### Implemented Data Structures

1. **Stack (LIFO - Last In, First Out)**  
   - Purpose: Undo/Redo functionality  
   - Implementation: `lib/src/core/data_structures/stack.dart`  
   - Usage: Tracks user actions for reversible operations  
   - Time Complexity: O(1) for push/pop operations

2. **Queue (FIFO - First In, First Out)**  
   - Purpose: Task scheduling and priority management  
   - Implementation: `lib/src/core/data_structures/queue.dart`  
   - Usage: Manages task execution order  
   - Time Complexity: O(1) for enqueue/dequeue operations

3. **Linked List**  
   - Purpose: Efficient task storage and memory optimization  
   - Implementation: `lib/src/core/data_structures/linked_list.dart`  
   - Usage: Dynamic task management with O(1) insertion/deletion  
   - Features: AddFirst, AddLast, RemoveFirst, Find operations

4. **Binary Search Tree (BST)**  
   - Purpose: Efficient task searching and sorting  
   - Implementation: `lib/src/core/data_structures/binary_search_tree.dart`  
   - Usage: Fast task lookup and sorted retrieval  
   - Time Complexity: O(log n) average case for search/insert

---

### Screen Shot 

##Adding new task UI

![image alt](https://github.com/sohaibahmedfarooqi8-sudo/DSA_APP-Flutter-Dart-/blob/ff3169bce4c9d00c3431a337d365f20ee58416e7/WhatsApp%20Image%202025-12-08%20at%2012.07.03%20AM%2C%2C%2C%2C%2C%2C%2C%2C.jpeg)

### Search task UI 

![image alt](https://github.com/sohaibahmedfarooqi8-sudo/DSA_APP-Flutter-Dart-/blob/7eaf10b5e442d6b30168638b840c47d3bd895678/WhatsApp%20Image%202025-12-08%20at%2012.07.03%20AM%2C%2C.jpeg)

### Home page ui 

 ![image alt]()

### Algorithm Implementations

 ![image alt]()

 ### DSA Algorithm 

 ![image alt]()

#### Sorting Algorithms
- Quick Sort: O(n log n) average case  
- Merge Sort: O(n log n) guaranteed  
- Bubble Sort: O(n²) for educational purposes  
- Custom Comparators: Priority-based and date-based sorting

#### Searching Algorithms
- Linear Search: O(n) for flexible text matching  
- Binary Search: O(log n) for sorted data  
- Advanced Filtering: Multi-criteria search with priority, status, and dates

---

## 🚀 Features

### Core Functionality
- ✅ Task Management: Create, read, update, delete tasks  
- ✅ Priority System: High, Medium, Low priority levels  
- ✅ Status Tracking: Pending, In Progress, Completed states  
- ✅ Due Date Management: Calendar integration with date picking  
- ✅ Search & Filter: Multi-criteria search and filtering  
- ✅ Undo/Redo System: Complete action reversal using Stack

### Advanced Features
- 🎯 DSA Statistics: Real-time display of data structure metrics  
- 🔄 Multiple Sorting Options: Choose from different sorting algorithms  
- 🔍 Advanced Search: Text search with priority and status filters  
- ⭐ Task Starring: Mark important tasks  
- 📊 Visual Indicators: Color-coded priorities and status badges  
- 🎨 Modern UI: Clean, responsive design with Material 3

---

## 🛠️ Technical Implementation

### Project Structure

lib/
├── src/
│ ├── app.dart # Main app widget
│ ├── core/
│ │ ├── data_structures/ # DSA implementations
│ │ │ ├── stack.dart
│ │ │ ├── queue.dart
│ │ │ ├── linked_list.dart
│ │ │ └── binary_search_tree.dart
│ │ ├── algorithms/ # Sorting and searching
│ │ │ ├── sorting.dart
│ │ │ └── searching.dart
│ │ └── theme/ # App theming
│ │ └── app_theme.dart
│ └── features/
│ └── todo/
│ ├── domain/
│ │ ├── models/ # Task model
│ │ └── services/ # Task service with DSA
│ └── presentation/
│ ├── pages/ # UI pages
│ └── widgets/ # UI components
└── main.dart

yaml
Copy code

---

### Key Classes

**Task Model (`task.dart`)**

```dart
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
