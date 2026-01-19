import '../../../../../src/core/data_structures/stack.dart';
import '../../../../../src/core/data_structures/queue.dart';
import '../../../../../src/core/data_structures/linked_list.dart';
import '../../../../../src/core/data_structures/binary_search_tree.dart';
import '../../../../../src/core/algorithms/sorting.dart';
import '../../../../../src/core/algorithms/searching.dart';
import '../models/task.dart';

/// Action types for undo/redo functionality
enum TaskActionType { create, update, delete, toggleComplete }

/// Action for undo/redo
class TaskAction {
  final TaskActionType type;
  final Task task;
  final Task? oldTask;
  
  TaskAction({
    required this.type,
    required this.task,
    this.oldTask,
  });
}

/// Main Task Service using DSA concepts
class TaskService {
  // Data Structures
  final LinkedList<Task> _tasks = LinkedList<Task>();
  final Stack<TaskAction> _undoStack = Stack<TaskAction>();
  final Stack<TaskAction> _redoStack = Stack<TaskAction>();
  final Queue<Task> _taskQueue = Queue<Task>();
  late final BinarySearchTree<String> _searchTree;
  
  // Current task list for UI
  List<Task> _currentTasks = [];
  
  TaskService() {
    _searchTree = BinarySearchTree<String>();
    _loadSampleData();
  }
  
  /// Get all tasks
  List<Task> getTasks() {
    _currentTasks = _tasks.toList();
    return _currentTasks;
  }
  
  /// Add a new task
  void addTask(Task task) {
    _tasks.addLast(task);
    _searchTree.insert(task.id);
    _taskQueue.enqueue(task);
    
    // Add to undo stack
    _undoStack.push(TaskAction(
      type: TaskActionType.create,
      task: task,
    ));
    _redoStack.clear(); // Clear redo stack on new action
    
    _updateCurrentTasks();
  }
  
  /// Update an existing task
  void updateTask(String id, Task updatedTask) {
    final oldTask = _findTaskById(id);
    if (oldTask == null) return;
    
    // Remove old task
    _removeTaskFromStructures(oldTask);
    
    // Add updated task
    _tasks.addLast(updatedTask);
    _searchTree.insert(updatedTask.id);
    
    // Add to undo stack
    _undoStack.push(TaskAction(
      type: TaskActionType.update,
      task: updatedTask,
      oldTask: oldTask,
    ));
    _redoStack.clear();
    
    _updateCurrentTasks();
  }
  
  /// Delete a task
  void deleteTask(String id) {
    final task = _findTaskById(id);
    if (task == null) return;
    
    _removeTaskFromStructures(task);
    
    // Add to undo stack
    _undoStack.push(TaskAction(
      type: TaskActionType.delete,
      task: task,
    ));
    _redoStack.clear();
    
    _updateCurrentTasks();
  }
  
  /// Toggle task completion
  void toggleTaskComplete(String id) {
    final task = _findTaskById(id);
    if (task == null) return;
    
    final updatedTask = task.copyWith(
      status: task.status == TaskStatus.completed 
          ? TaskStatus.pending 
          : TaskStatus.completed,
    );
    
    updateTask(id, updatedTask);
    
    // Add specific toggle action for better undo/redo
    _undoStack.push(TaskAction(
      type: TaskActionType.toggleComplete,
      task: updatedTask,
      oldTask: task,
    ));
  }
  
  /// Search tasks using various algorithms
  List<Task> searchTasks(String query) {
    if (query.isEmpty) return _currentTasks;
    
    // Use linear search for flexible text matching
    return SearchingAlgorithms.linearSearchAll(_currentTasks, query);
  }
  
  /// Sort tasks using different algorithms
  List<Task> sortTasks({String algorithm = 'quick'}) {
    switch (algorithm.toLowerCase()) {
      case 'quick':
        return SortingAlgorithms.quickSort(_currentTasks);
      case 'merge':
        return SortingAlgorithms.mergeSort(_currentTasks);
      case 'bubble':
        return SortingAlgorithms.bubbleSort(_currentTasks);
      default:
        return SortingAlgorithms.quickSort(_currentTasks);
    }
  }
  
  /// Filter tasks by criteria
  List<Task> filterTasks({
    TaskPriority? priority,
    TaskStatus? status,
    bool? isStarred,
  }) {
    return SearchingAlgorithms.advancedSearch(
      tasks: _currentTasks,
      priority: priority,
      status: status,
      isStarred: isStarred,
    );
  }
  
  /// Undo the last action
  bool undo() {
    if (_undoStack.isEmpty) return false;
    
    final action = _undoStack.pop()!;
    
    switch (action.type) {
      case TaskActionType.create:
        _removeTaskFromStructures(action.task);
        _redoStack.push(TaskAction(
          type: TaskActionType.delete,
          task: action.task,
        ));
        break;
        
      case TaskActionType.update:
        if (action.oldTask != null) {
          _removeTaskFromStructures(action.task);
          _tasks.addLast(action.oldTask!);
          _searchTree.insert(action.oldTask!.id);
          _redoStack.push(TaskAction(
            type: TaskActionType.update,
            task: action.oldTask!,
            oldTask: action.task,
          ));
        }
        break;
        
      case TaskActionType.delete:
        _tasks.addLast(action.task);
        _searchTree.insert(action.task.id);
        _redoStack.push(TaskAction(
          type: TaskActionType.create,
          task: action.task,
        ));
        break;
        
      case TaskActionType.toggleComplete:
        if (action.oldTask != null) {
          _removeTaskFromStructures(action.task);
          _tasks.addLast(action.oldTask!);
          _searchTree.insert(action.oldTask!.id);
          _redoStack.push(TaskAction(
            type: TaskActionType.toggleComplete,
            task: action.oldTask!,
            oldTask: action.task,
          ));
        }
        break;
    }
    
    _updateCurrentTasks();
    return true;
  }
  
  /// Redo the last undone action
  bool redo() {
    if (_redoStack.isEmpty) return false;
    
    final action = _redoStack.pop()!;
    
    // Essentially redo the action
    switch (action.type) {
      case TaskActionType.create:
        _tasks.addLast(action.task);
        _searchTree.insert(action.task.id);
        _undoStack.push(TaskAction(
          type: TaskActionType.delete,
          task: action.task,
        ));
        break;
        
      case TaskActionType.update:
        if (action.oldTask != null) {
          _removeTaskFromStructures(action.oldTask!);
          _tasks.addLast(action.task);
          _searchTree.insert(action.task.id);
          _undoStack.push(TaskAction(
            type: TaskActionType.update,
            task: action.task,
            oldTask: action.oldTask,
          ));
        }
        break;
        
      case TaskActionType.delete:
        _removeTaskFromStructures(action.task);
        _undoStack.push(TaskAction(
          type: TaskActionType.create,
          task: action.task,
        ));
        break;
        
      case TaskActionType.toggleComplete:
        if (action.oldTask != null) {
          _removeTaskFromStructures(action.oldTask!);
          _tasks.addLast(action.task);
          _searchTree.insert(action.task.id);
          _undoStack.push(TaskAction(
            type: TaskActionType.toggleComplete,
            task: action.task,
            oldTask: action.oldTask,
          ));
        }
        break;
    }
    
    _updateCurrentTasks();
    return true;
  }
  
  /// Get undo stack size
  int get undoStackSize => _undoStack.size;
  
  /// Get redo stack size
  int get redoStackSize => _redoStack.size;
  
  /// Get queue size
  int get queueSize => _taskQueue.size;
  
  /// Get next task from queue
  Task? getNextTaskFromQueue() {
    return _taskQueue.dequeue();
  }
  
  /// Find task by ID using various methods
  Task? findTaskById(String id) {
    // First try BST search
    if (_searchTree.search(id) != null) {
      return _findTaskById(id);
    }
    return null;
  }
  
  /// Helper methods
  Task? _findTaskById(String id) {
    return _tasks.find((task) => task.id == id);
  }
  
  void _removeTaskFromStructures(Task task) {
    // Remove from linked list
    final tempList = LinkedList<Task>();
    Task? current;
    while ((current = _tasks.removeFirst()) != null) {
      if (current!.id != task.id) {
        tempList.addLast(current);
      }
    }
    
    // Rebuild the list
    _tasks.clear();
    current = tempList.removeFirst();
    while (current != null) {
      _tasks.addLast(current);
      current = tempList.removeFirst();
    }
  }
  
  void _updateCurrentTasks() {
    _currentTasks = _tasks.toList();
  }
  
  void _loadSampleData() {
    // Add sample tasks for demonstration
    final sampleTasks = [
      Task(
        id: '1',
        title: 'Implement Stack Data Structure',
        description: 'Create a stack implementation for undo/redo functionality',
        priority: TaskPriority.high,
        dueDate: DateTime.now().add(Duration(days: 1)),
      ),
      Task(
        id: '2',
        title: 'Design Queue for Task Scheduling',
        description: 'Implement queue for managing task priorities',
        priority: TaskPriority.medium,
        dueDate: DateTime.now().add(Duration(days: 2)),
      ),
      Task(
        id: '3',
        title: 'Build Binary Search Tree',
        description: 'Create BST for efficient task searching',
        priority: TaskPriority.high,
        dueDate: DateTime.now().add(Duration(days: 3)),
      ),
      Task(
        id: '4',
        title: 'Write Sorting Algorithms',
        description: 'Implement quicksort, mergesort, and bubblesort',
        priority: TaskPriority.medium,
        status: TaskStatus.inProgress,
      ),
      Task(
        id: '5',
        title: 'Create Searching Algorithms',
        description: 'Implement linear and binary search',
        priority: TaskPriority.low,
        status: TaskStatus.completed,
      ),
    ];
    
    for (final task in sampleTasks) {
      addTask(task);
    }
  }
}