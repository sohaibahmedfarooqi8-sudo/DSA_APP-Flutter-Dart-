import 'package:flutter/material.dart';
import '../../domain/models/task.dart';

class AddTaskDialog extends StatefulWidget {
  final void Function(Task) onTaskAdded;
  
  const AddTaskDialog({super.key, required this.onTaskAdded});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.medium;
  DateTime? _selectedDueDate;
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
   return Dialog(
  insetPadding: EdgeInsets.only(
    top: MediaQuery.of(context).viewInsets.top,   
    left: 24, right: 24, bottom: 24,              
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Container(
    padding: const EdgeInsets.all(24),
    constraints: const BoxConstraints(maxWidth: 500),
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(          // also wrap in a scroll view
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add New Task',
                style: theme.textTheme.headlineSmall,
              ),
              
              const SizedBox(height: 24),
              
              // Title input
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title',
                  hintText: 'Enter task title',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Description input
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter task description (optional)',
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              
              const SizedBox(height: 16),
              
              // Priority selection
              Row(
                children: [
                  const Icon(Icons.priority_high, size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Priority:',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<TaskPriority>(
                    value: _selectedPriority,
                    items: TaskPriority.values.map((priority) {
                      return DropdownMenuItem<TaskPriority>(
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
                    }).toList(),
                    onChanged: (priority) {
                      if (priority != null) {
                        setState(() {
                          _selectedPriority = priority;
                        });
                      }
                    },
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Due date selection
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 1),
                  Text(
                    'Due Date:',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(width: 1),
                  TextButton.icon(
                    onPressed: _selectDueDate,
                    icon: const Icon(Icons.date_range),
                    label: Text(
                      _selectedDueDate == null
                          ? 'Select Date'
                          : _formatDate(_selectedDueDate!),
                    ),
                  ),
                 
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Action buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 28),
                  ElevatedButton(
                    onPressed: _addTask,
                    child: const Text('Add Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
  ),
    );
  }
  
  void _selectDueDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    
    if (date != null) {
      setState(() {
        _selectedDueDate = date;
      });
    }
  }
  
  void _addTask() {
    if (_formKey.currentState!.validate()) {
      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _selectedPriority,
        dueDate: _selectedDueDate,
      );
      
      widget.onTaskAdded(task);
      Navigator.pop(context);
    }
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
  
  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}