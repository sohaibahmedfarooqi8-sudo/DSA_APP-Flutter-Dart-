import '../../features/todo/domain/models/task.dart';

/// Sorting Algorithms Implementation
class SortingAlgorithms {
  
  /// Quick Sort Algorithm for tasks
  static List<Task> quickSort(List<Task> tasks) {
    if (tasks.length <= 1) return tasks;
    
    final result = List<Task>.from(tasks);
    _quickSortRecursive(result, 0, result.length - 1);
    return result;
  }
  
  static void _quickSortRecursive(List<Task> tasks, int low, int high) {
    if (low < high) {
      final pivotIndex = _partition(tasks, low, high);
      _quickSortRecursive(tasks, low, pivotIndex - 1);
      _quickSortRecursive(tasks, pivotIndex + 1, high);
    }
  }
  
  static int _partition(List<Task> tasks, int low, int high) {
    final pivot = tasks[high];
    int i = low - 1;
    
    for (int j = low; j < high; j++) {
      if (tasks[j].compareTo(pivot) <= 0) {
        i++;
        _swap(tasks, i, j);
      }
    }
    _swap(tasks, i + 1, high);
    return i + 1;
  }
  
  static void _swap(List<Task> tasks, int i, int j) {
    final temp = tasks[i];
    tasks[i] = tasks[j];
    tasks[j] = temp;
  }
  
  /// Merge Sort Algorithm for tasks
  static List<Task> mergeSort(List<Task> tasks) {
    if (tasks.length <= 1) return tasks;
    
    final middle = tasks.length ~/ 2;
    final left = tasks.sublist(0, middle);
    final right = tasks.sublist(middle);
    
    return _merge(mergeSort(left), mergeSort(right));
  }
  
  static List<Task> _merge(List<Task> left, List<Task> right) {
    final result = <Task>[];
    int leftIndex = 0;
    int rightIndex = 0;
    
    while (leftIndex < left.length && rightIndex < right.length) {
      if (left[leftIndex].compareTo(right[rightIndex]) <= 0) {
        result.add(left[leftIndex]);
        leftIndex++;
      } else {
        result.add(right[rightIndex]);
        rightIndex++;
      }
    }
    
    result.addAll(left.sublist(leftIndex));
    result.addAll(right.sublist(rightIndex));
    
    return result;
  }
  
  /// Bubble Sort Algorithm for tasks
  static List<Task> bubbleSort(List<Task> tasks) {
    final result = List<Task>.from(tasks);
    final n = result.length;
    
    for (int i = 0; i < n - 1; i++) {
      for (int j = 0; j < n - i - 1; j++) {
        if (result[j].compareTo(result[j + 1]) > 0) {
          _swap(result, j, j + 1);
        }
      }
    }
    
    return result;
  }
  
  /// Sort tasks by priority
  static List<Task> sortByPriority(List<Task> tasks) {
    return quickSort(tasks);
  }
  
  /// Sort tasks by due date
  static List<Task> sortByDueDate(List<Task> tasks) {
    final result = List<Task>.from(tasks);
    result.sort((a, b) {
      if (a.dueDate == null && b.dueDate == null) return 0;
      if (a.dueDate == null) return 1;
      if (b.dueDate == null) return -1;
      return a.dueDate!.compareTo(b.dueDate!);
    });
    return result;
  }
  
  /// Sort tasks by creation date
  static List<Task> sortByCreationDate(List<Task> tasks) {
    final result = List<Task>.from(tasks);
    result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return result;
  }
}