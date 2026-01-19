import 'package:flutter/material.dart';
import '../../domain/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onTap;
  final VoidCallback? onToggleComplete;
  final VoidCallback? onDelete;
  final VoidCallback? onStarToggle;
  
  const TaskCard({
    super.key,
    required this.task,
    this.onTap,
    this.onToggleComplete,
    this.onDelete,
    this.onStarToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Priority indicator
                  Container(
                    width: 4,
                    height: 40,
                    decoration: BoxDecoration(
                      color: task.priorityColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Completion checkbox
                  InkWell(
                    onTap: onToggleComplete,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: task.status == TaskStatus.completed
                            ? theme.colorScheme.primary
                            : Colors.transparent,
                        border: Border.all(
                          color: task.status == TaskStatus.completed
                              ? theme.colorScheme.primary
                              : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: task.status == TaskStatus.completed
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Task content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            decoration: task.status == TaskStatus.completed
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.status == TaskStatus.completed
                                ? theme.textTheme.bodySmall?.color
                                : null,
                          ),
                        ),
                        if (task.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            task.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              decoration: task.status == TaskStatus.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Star button
                  IconButton(
                    onPressed: onStarToggle,
                    icon: Icon(
                      task.isStarred ? Icons.star : Icons.star_outline,
                      color: task.isStarred ? Colors.amber : Colors.grey,
                      size: 20,
                    ),
                  ),
                  
                  // Delete button
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                      size: 20,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Task metadata
              Row(
                children: [
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: task.statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: task.statusColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      _getStatusText(task.status),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: task.statusColor,
                      ),
                    ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Priority badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: task.priorityColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: task.priorityColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      _getPriorityText(task.priority),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: task.priorityColor,
                      ),
                    ),
                  ),
                  
                  const Spacer(),
                  
                  // Due date
                  if (task.dueDate != null) ...[
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(task.dueDate!),
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  String _getStatusText(TaskStatus status) {
    switch (status) {
      case TaskStatus.pending:
        return 'Pending';
      case TaskStatus.inProgress:
        return 'In Progress';
      case TaskStatus.completed:
        return 'Completed';
    }
  }
  
  String _getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
    }
  }
  
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final taskDate = DateTime(date.year, date.month, date.day);
    
    if (taskDate == today) {
      return 'Today';
    } else if (taskDate == today.add(const Duration(days: 1))) {
      return 'Tomorrow';
    } else if (taskDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}