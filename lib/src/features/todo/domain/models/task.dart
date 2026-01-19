import 'package:flutter/material.dart';

enum TaskPriority { low, medium, high }

enum TaskStatus { pending, inProgress, completed }

class Task implements Comparable<Task> {
  final String id;
  final String title;
  final String description;
  final TaskPriority priority;
  TaskStatus status;
  final DateTime createdAt;
  DateTime? dueDate;
  bool isStarred;
  
  Task({
    required this.id,
    required this.title,
    this.description = '',
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    DateTime? createdAt,
    this.dueDate,
    this.isStarred = false,
  }) : createdAt = createdAt ?? DateTime.now();
  
  /// Copy with method for immutable updates
  Task copyWith({
    String? id,
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? createdAt,
    DateTime? dueDate,
    bool? isStarred,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      isStarred: isStarred ?? this.isStarred,
    );
  }
  
  /// Get priority color
  Color get priorityColor {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }
  
  /// Get status color
  Color get statusColor {
    switch (status) {
      case TaskStatus.pending:
        return Colors.grey;
      case TaskStatus.inProgress:
        return Colors.blue;
      case TaskStatus.completed:
        return Colors.green;
    }
  }
  
  /// Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.index,
      'status': status.index,
      'createdAt': createdAt.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'isStarred': isStarred,
    };
  }
  
  /// Create from Map
  factory Task.fromMap(Map<String, dynamic> map) {
    final id = map['id'] as String? ?? '';
    final title = map['title'] as String? ?? '';
    final description = map['description'] as String? ?? '';
    final priorityIndex = map['priority'] as int? ?? 1;
    final statusIndex = map['status'] as int? ?? 0;
    final createdAtString = map['createdAt'] as String? ?? DateTime.now().toIso8601String();
    final dueDateString = map['dueDate'] as String?;
    final isStarred = map['isStarred'] as bool? ?? false;

    return Task(
      id: id,
      title: title,
      description: description,
      priority: TaskPriority.values[priorityIndex],
      status: TaskStatus.values[statusIndex],
      createdAt: DateTime.parse(createdAtString),
      dueDate: dueDateString != null ? DateTime.parse(dueDateString) : null,
      isStarred: isStarred,
    );
  }
  
  @override
  int compareTo(Task other) {
    // Compare by priority first (high to low)
    final priorityComparison = other.priority.index.compareTo(priority.index);
    if (priorityComparison != 0) return priorityComparison;
    
    // Then compare by status (pending first)
    final statusComparison = status.index.compareTo(other.status.index);
    if (statusComparison != 0) return statusComparison;
    
    // Finally compare by creation date (newest first)
    return other.createdAt.compareTo(createdAt);
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Task && other.id == id;
  }
  
  @override
  int get hashCode => id.hashCode;
}