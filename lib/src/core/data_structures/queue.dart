/// Queue Data Structure Implementation
/// FIFO - First In, First Out principle
/// Used for task scheduling and priority management
class Queue<T> {
  final List<T> _items = [];
  
  /// Enqueue item (add to the end)
  void enqueue(T item) {
    _items.add(item);
  }
  
  /// Dequeue item (remove from the front)
  T? dequeue() {
    if (_items.isEmpty) return null;
    return _items.removeAt(0);
  }
  
  /// Peek at the front item without removing it
  T? peek() {
    if (_items.isEmpty) return null;
    return _items.first;
  }
  
  /// Check if queue is empty
  bool get isEmpty => _items.isEmpty;
  
  /// Get the size of the queue
  int get size => _items.length;
  
  /// Clear all items from the queue
  void clear() {
    _items.clear();
  }
  
  /// Get all items in the queue (for debugging)
  List<T> get items => List.unmodifiable(_items);
}