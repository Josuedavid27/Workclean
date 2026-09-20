import 'task.dart';

/// Contrato de acceso a datos. Hoy lo implementa la base local;
/// cuando llegue la sincronización, se agrega otra implementación
/// (o una que combine local + remoto) sin tocar la UI.
abstract class TaskRepository {
  Stream<List<Task>> watchAll();

  Future<void> upsert(Task task);

  Future<void> delete(String id);
}