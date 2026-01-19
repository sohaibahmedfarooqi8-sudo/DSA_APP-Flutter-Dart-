import '../../features/todo/domain/models/task.dart';

class SearchingAlgorithms {

  static Task? linearSearch(List<Task> tasks, String query) {
    final lowerQuery = query.toLowerCase();
    
    for (final task in tasks) {
      if (task.title.toLowerCase().contains(lowerQuery) ||
          task.description.toLowerCase().contains(lowerQuery)) {
        return task;
      }
    }
    return null;
  }
  static List<Task> linearSearchAll(List<Task> tasks, String query) {
    final result = <Task>[];
    final lowerQuery = query.toLowerCase();
    for (final task in tasks) {
      if (task.title.toLowerCase().contains(lowerQuery) ||
          task.description.toLowerCase().contains(lowerQuery)) {
        result.add(task);
      }
    }
    return result;
  }
  
  static Task? binarySearch(List<Task> sortedTasks, String query) {
    final lowerQuery = query.toLowerCase();
    int left = 0;
    int right = sortedTasks.length - 1;
    
    while (left <= right) {
      int mid = left + (right - left) ~/ 2;
      final task = sortedTasks[mid];
      
      if (task.title.toLowerCase().contains(lowerQuery)) {
        return task;
      } else if (task.title.toLowerCase().compareTo(lowerQuery) < 0) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
    }
    
    return null;
  }
  
  /// Search by priority
  static List<Task> searchByPriority(List<Task> tasks, TaskPriority priority) {
    return tasks.where((task) => task.priority == priority).toList();
  }
  
  /// Search by status
  static List<Task> searchByStatus(List<Task> tasks, TaskStatus status) {
    return tasks.where((task) => task.status == status).toList();
  }
  
  /// Search by due date range
  static List<Task> searchByDueDateRange(
    List<Task> tasks,
    DateTime startDate,
    DateTime endDate,
  ) {
    return tasks.where((task) {
      if (task.dueDate == null) return false;
      return task.dueDate!.isAfter(startDate) && task.dueDate!.isBefore(endDate);
    }).toList();
  }
  
  /// Filter tasks by multiple criteria
  static List<Task> advancedSearch({
    required List<Task> tasks,
    String? query,
    TaskPriority? priority,
    TaskStatus? status,
    bool? isStarred,
    DateTime? dueDateStart,
    DateTime? dueDateEnd,
  }) {
    return tasks.where((task) {
      // Text search
      if (query != null && query.isNotEmpty) {
        final lowerQuery = query.toLowerCase();
        if (!task.title.toLowerCase().contains(lowerQuery) &&
            !task.description.toLowerCase().contains(lowerQuery)) {
          return false;
        }
      }
      
      // Priority filter
      if (priority != null && task.priority != priority) {
        return false;
      }
      
      // Status filter
      if (status != null && task.status != status) {
        return false;
      }
      
      // Starred filter
      if (isStarred != null && task.isStarred != isStarred) {
        return false;
      }
      
      // Due date range filter
      if (dueDateStart != null || dueDateEnd != null) {
        if (task.dueDate == null) return false;
        
        if (dueDateStart != null && task.dueDate!.isBefore(dueDateStart)) {
          return false;
        }
        
        if (dueDateEnd != null && task.dueDate!.isAfter(dueDateEnd)) {
          return false;
        }
      }
      
      return true;
    }).toList();
  }
}