import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../domain/models/task.dart';
import '../../domain/services/task_service.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  String _searchQuery = '';
  String _sortAlgorithm = 'quick';
  TaskPriority? _filterPriority;
  TaskStatus? _filterStatus;
  
  @override
  void initState() {
    super.initState();
    _loadTasks();
  }
  
  void _loadTasks() {
    setState(() {
      _tasks = _taskService.getTasks();
    });
  }
  
  void _addTask(Task task) {
    _taskService.addTask(task);
    _loadTasks();
  }
  
  void _updateTask(String id, Task updatedTask) {
    _taskService.updateTask(id, updatedTask);
    _loadTasks();
  }
  
  void _deleteTask(String id) {
    _taskService.deleteTask(id);
    _loadTasks();
  }
  
  void _toggleTaskComplete(String id) {
    _taskService.toggleTaskComplete(id);
    _loadTasks();
  }
  
  void _toggleTaskStar(String id) {
    final task = _tasks.firstWhere((task) => task.id == id);
    final updatedTask = task.copyWith(isStarred: !task.isStarred);
    _updateTask(id, updatedTask);
  }
  
  void _searchTasks(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _loadTasks();
      } else {
        _tasks = _taskService.searchTasks(query);
      }
    });
  }
  
  void _sortTasks(String algorithm) {
    setState(() {
      _sortAlgorithm = algorithm;
      _tasks = _taskService.sortTasks(algorithm: algorithm);
    });
  }
  
  void _filterTasks({TaskPriority? priority, TaskStatus? status}) {
    setState(() {
      _filterPriority = priority;
      _filterStatus = status;
      _tasks = _taskService.filterTasks(
        priority: priority,
        status: status,
      );
    });
  }
  
  void _clearFilters() {
    setState(() {
      _filterPriority = null;
      _filterStatus = null;
      _searchQuery = '';
      _loadTasks();
    });
  }
  
  bool _undo() {
    final success = _taskService.undo();
    if (success) {
      _loadTasks();
    }
    return success;
  }
  
  bool _redo() {
    final success = _taskService.redo();
    if (success) {
      _loadTasks();
    }
    return success;
  }
  
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        onTaskAdded: _addTask,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('DSA Todo Manager'),
        actions: [
          // Undo/Redo buttons
          IconButton(
            onPressed: _taskService.undoStackSize > 0 ? _undo : null,
            icon: const Icon(Icons.undo),
            tooltip: 'Undo (${_taskService.undoStackSize})',
          ),
          IconButton(
            onPressed: _taskService.redoStackSize > 0 ? _redo : null,
            icon: const Icon(Icons.redo),
            tooltip: 'Redo (${_taskService.redoStackSize})',
          ),
          
          // Sort options
          PopupMenuButton<String>(
            onSelected: _sortTasks,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'quick',
                child: Text('Quick Sort'),
              ),
              const PopupMenuItem(
                value: 'merge',
                child: Text('Merge Sort'),
              ),
              const PopupMenuItem(
                value: 'bubble',
                child: Text('Bubble Sort'),
              ),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      
      body: Column(
        children: [
          // Search and filter section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                TextField(
                  onChanged: _searchTasks,
                  decoration: InputDecoration(
                    hintText: 'Search tasks...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            onPressed: () {
                              _searchTasks('');
                            },
                            icon: const Icon(Icons.clear),
                          )
                        : null,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Filter chips
                Row(
                  children: [
                    // Priority filter
                    PopupMenuButton<TaskPriority>(
                      onSelected: (priority) => _filterTasks(priority: priority),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: null,
                          child: Text('All Priorities'),
                        ),
                        ...TaskPriority.values.map((priority) {
                          return PopupMenuItem(
                            value: priority,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: 12,
                                  color: _getPriorityColor(priority),
                                ),
                                const SizedBox(width: 8),
                                Text(_getPriorityText(priority)),
                              ],
                            ),
                          );
                        }),
                      ],
                      child: Chip(
                        label: Text(
                          _filterPriority == null
                              ? 'All Priorities'
                              : _getPriorityText(_filterPriority!),
                        ),
                        avatar: const Icon(Icons.filter_list, size: 16),
                      ),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    // Status filter
                    PopupMenuButton<TaskStatus>(
                      onSelected: (status) => _filterTasks(status: status),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: null,
                          child: Text('All Statuses'),
                        ),
                        ...TaskStatus.values.map((status) {
                          return PopupMenuItem(
                            value: status,
                            child: Text(_getStatusText(status)),
                          );
                        }),
                      ],
                      child: Chip(
                        label: Text(
                          _filterStatus == null
                              ? 'All Statuses'
                              : _getStatusText(_filterStatus!),
                        ),
                        avatar: const Icon(Icons.flag, size: 16),
                      ),
                    ),
                    
                    if (_filterPriority != null || _filterStatus != null || _searchQuery.isNotEmpty)
                      ...[
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: _clearFilters,
                          icon: const Icon(Icons.clear_all),
                          tooltip: 'Clear filters',
                        ),
                      ],
                  ],
                ),
              ],
            ),
          ),
          
          // Statistics
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildStatCard(
                  'Total Tasks',
                  _tasks.length.toString(),
                  Icons.list,
                  theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Completed',
                  _tasks.where((t) => t.status == TaskStatus.completed).length.toString(),
                  Icons.check_circle,
                  theme.colorScheme.secondary,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  'Queue Size',
                  _taskService.queueSize.toString(),
                  Icons.queue,
                  theme.colorScheme.tertiary ?? Colors.orange,
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Task list
          Expanded(
            child: _tasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 64,
                          color: theme.textTheme.bodySmall?.color,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tasks found',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          'Add a new task to get started',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return TaskCard(
                        task: task,
                        onTap: () => _showTaskDetails(task),
                        onToggleComplete: () => _toggleTaskComplete(task.id),
                        onDelete: () => _deleteTask(task.id),
                        onStarToggle: () => _toggleTaskStar(task.id),
                      );
                    },
                  ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
  
  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showTaskDetails(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) ...[
              Text('Description:', style: Theme.of(context).textTheme.titleSmall),
              Text(task.description),
              const SizedBox(height: 16),
            ],
            Text('Priority:', style: Theme.of(context).textTheme.titleSmall),
            Row(
              children: [
                Icon(Icons.circle, size: 12, color: task.priorityColor),
                const SizedBox(width: 4),
                Text(_getPriorityText(task.priority)),
              ],
            ),
            const SizedBox(height: 16),
            Text('Status:', style: Theme.of(context).textTheme.titleSmall),
            Text(_getStatusText(task.status)),
            if (task.dueDate != null) ...[
              const SizedBox(height: 16),
              Text('Due Date:', style: Theme.of(context).textTheme.titleSmall),
              Text(_formatDate(task.dueDate!)),
            ],
            const SizedBox(height: 16),
            Text('Created:', style: Theme.of(context).textTheme.titleSmall),
            Text(_formatDate(task.createdAt)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  
  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return Colors.red;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Colors.green;
    }
  }
  
  String _getPriorityText(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
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
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}