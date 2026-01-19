/// Stack Data Structure Implementation
/// LIFO - Last In, First Out principle
/// Used for undo/redo functionality in the todo app
class Stack<T> {
  final List<T> _items = [];
  
  /// Push item onto the stack
  void push(T item) {
    _items.add(item);
  }
  
  /// Pop item from the stack
  T? pop() {
    if (_items.isEmpty) return null;
    return _items.removeLast();
  }
  
  /// Peek at the top item without removing it
  T? peek() {
    if (_items.isEmpty) return null;
    return _items.last;
  }
  
  /// Check if stack is empty
  bool get isEmpty => _items.isEmpty;
  
  /// Get the size of the stack
  int get size => _items.length;
  
  /// Clear all items from the stack
  void clear() {
    _items.clear();
  }
  
  /// Get all items in the stack (for debugging)
  List<T> get items => List.unmodifiable(_items);
}