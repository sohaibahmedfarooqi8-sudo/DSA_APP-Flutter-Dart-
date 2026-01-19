/// Linked List Node
class ListNode<T> {
  T data;
  ListNode<T>? next;
  
  ListNode(this.data, [this.next]);
}

/// Linked List Data Structure Implementation
/// Used for efficient task management and memory optimization
class LinkedList<T> {
  ListNode<T>? _head;
  ListNode<T>? _tail;
  int _size = 0;
  
  /// Add item to the beginning of the list
  void addFirst(T data) {
    final newNode = ListNode(data);
    newNode.next = _head;
    _head = newNode;
    
    if (_tail == null) {
      _tail = newNode;
    }
    _size++;
  }
  
  /// Add item to the end of the list
  void addLast(T data) {
    final newNode = ListNode(data);
    
    if (_tail == null) {
      _head = _tail = newNode;
    } else {
      _tail!.next = newNode;
      _tail = newNode;
    }
    _size++;
  }
  
  /// Remove first item from the list
  T? removeFirst() {
    if (_head == null) return null;
    
    final data = _head!.data;
    _head = _head!.next;
    
    if (_head == null) {
      _tail = null;
    }
    _size--;
    return data;
  }
  
  /// Find item in the list
  T? find(bool Function(T) predicate) {
    ListNode<T>? current = _head;
    
    while (current != null) {
      if (predicate(current.data)) {
        return current.data;
      }
      current = current.next;
    }
    return null;
  }
  
  /// Convert to List for UI display
  List<T> toList() {
    final result = <T>[];
    ListNode<T>? current = _head;
    
    while (current != null) {
      result.add(current.data);
      current = current.next;
    }
    return result;
  }
  
  /// Get the size of the list
  int get size => _size;
  
  /// Check if list is empty
  bool get isEmpty => _size == 0;
  
  /// Clear all items from the list
  void clear() {
    _head = null;
    _tail = null;
    _size = 0;
  }
}