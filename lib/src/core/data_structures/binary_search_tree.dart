/// Binary Search Tree Node
class TreeNode<T extends Comparable<T>> {
  T data;
  TreeNode<T>? left;
  TreeNode<T>? right;
  
  TreeNode(this.data);
}

/// Binary Search Tree Implementation
/// Used for efficient task searching and sorting
class BinarySearchTree<T extends Comparable<T>> {
  TreeNode<T>? _root;
  int _size = 0;
  
  /// Insert item into the tree
  void insert(T data) {
    _root = _insertRecursive(_root, data);
    _size++;
  }
  
  TreeNode<T> _insertRecursive(TreeNode<T>? node, T data) {
    if (node == null) {
      return TreeNode(data);
    }
    
    if (data.compareTo(node.data) < 0) {
      node.left = _insertRecursive(node.left, data);
    } else if (data.compareTo(node.data) > 0) {
      node.right = _insertRecursive(node.right, data);
    }
    
    return node;
  }
  
  /// Search for an item in the tree
  T? search(T data) {
    return _searchRecursive(_root, data);
  }
  
  T? _searchRecursive(TreeNode<T>? node, T data) {
    if (node == null) return null;
    
    if (data.compareTo(node.data) == 0) {
      return node.data;
    } else if (data.compareTo(node.data) < 0) {
      return _searchRecursive(node.left, data);
    } else {
      return _searchRecursive(node.right, data);
    }
  }
  
  /// Get all items in sorted order
  List<T> inOrderTraversal() {
    final result = <T>[];
    _inOrderTraversalRecursive(_root, result);
    return result;
  }
  
  void _inOrderTraversalRecursive(TreeNode<T>? node, List<T> result) {
    if (node != null) {
      _inOrderTraversalRecursive(node.left, result);
      result.add(node.data);
      _inOrderTraversalRecursive(node.right, result);
    }
  }
  
  /// Find minimum value
  T? findMin() {
    if (_root == null) return null;
    return _findMinRecursive(_root!).data;
  }
  
  TreeNode<T> _findMinRecursive(TreeNode<T> node) {
    if (node.left == null) return node;
    return _findMinRecursive(node.left!);
  }
  
  /// Find maximum value
  T? findMax() {
    if (_root == null) return null;
    return _findMaxRecursive(_root!).data;
  }
  
  TreeNode<T> _findMaxRecursive(TreeNode<T> node) {
    if (node.right == null) return node;
    return _findMaxRecursive(node.right!);
  }
  
  /// Get the size of the tree
  int get size => _size;
  
  /// Check if tree is empty
  bool get isEmpty => _size == 0;
}