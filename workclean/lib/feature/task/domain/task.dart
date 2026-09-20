enum TaskPriority { low, medium, high }

enum TaskStatus { pending, inProgress, done }

class Task {
  final String id; // UUID generado en el cliente (sirve para sincronizar luego)
  final String title;
  final String? description;
  final TaskPriority priority;
  final TaskStatus status;
  final DateTime? dueDate;
  final DateTime createdAt;
  final DateTime updatedAt; // clave para resolver conflictos al sincronizar

  const Task({
    required this.id,
    required this.title,
    this.description,
    this.priority = TaskPriority.medium,
    this.status = TaskStatus.pending,
    this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isOverdue =>
      status != TaskStatus.done &&
      dueDate != null &&
      dueDate!.isBefore(DateTime.now());

  Task copyWith({
    String? title,
    String? description,
    TaskPriority? priority,
    TaskStatus? status,
    DateTime? dueDate,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'description': description,
        'priority': priority.name,
        'status': status.name,
        'due_date': dueDate?.millisecondsSinceEpoch,
        'created_at': createdAt.millisecondsSinceEpoch,
        'updated_at': updatedAt.millisecondsSinceEpoch,
      };

  factory Task.fromMap(Map<String, dynamic> map) => Task(
        id: map['id'] as String,
        title: map['title'] as String,
        description: map['description'] as String?,
        priority: TaskPriority.values.byName(map['priority'] as String),
        status: TaskStatus.values.byName(map['status'] as String),
        dueDate: map['due_date'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(map['due_date'] as int),
        createdAt:
            DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
        updatedAt:
            DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      );
}