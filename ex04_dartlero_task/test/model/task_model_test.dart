import 'package:unittest/unittest.dart';
//import 'package:dartlero/dartlero.dart';
import 'package:ex04_dartlero_task/ex04_dartlero_task.dart';

testTasks(Tasks tasks) {
  group("Testing Tasks", () {
    setUp(() {
      var taskCount = 0;
      expect(tasks.length, equals(taskCount));

      var task1 = new Task();
      expect(task1, isNotNull);
      task1.idTask = 1; 
      task1.description =
          'Préparer exercice FizzBuzz';
      task1.completed = true;
      tasks.add(task1);
      expect(tasks.length, equals(++taskCount));

      var task2 = new Task();
      expect(task2, isNotNull);
      task2.idTask = 2; 
      task2.description =
          'Lire le 4ème chapitre du livre';
      task2.completed = false;
      tasks.add(task2);
      expect(tasks.length, equals(++taskCount));
      
      var task3 = new Task();
      expect(task3, isNotNull);      
      task3.idTask = 3; 
      task3.description =
          'Travailler le cours SIO-6510';
      task3.completed = true;
      tasks.add(task3);    
      expect(tasks.length, equals(++taskCount));
      
      var task4 = new Task();
      expect(task4, isNotNull);      
      task4.idTask = 4; 
      task4.description =
          'Faire les courses le weekend';
      task4.completed = false;
      tasks.add(task4);    
      expect(tasks.length, equals(++taskCount));      
      
    });
    tearDown(() {
      tasks.clear();
      expect(tasks.isEmpty, isTrue);
    });
    test('Ajouter une tâche', () {
      var task = new Task();
      expect(task, isNotNull);
      task.idTask = 5; 
      task.description =
           'Acheter le nouveau livre Dart learning';
      task.completed = false;
      var added = tasks.add(task);
      expect(added, isTrue);
      tasks.display('Ajouter une tâche');
    });
    test('Ajouter une tâche sans données', () {
      var taskCount = tasks.length;
      var task = new Task();
      expect(task, isNotNull);
      var added = tasks.add(task);
      expect(added, isTrue);
      tasks.display('Ajouter une tâche sans données');
    });
    test('Ajouter une tâche non unique', () {
      var taskCount = tasks.length;
      var task = new Task();
      expect(task, isNotNull);
      task.idTask = 4; 
      task.description = 'Faire les courses le weekend';
      task.completed = false;
      var added = tasks.add(task);
      expect(added, isFalse);
      tasks.display('Ajouter une tâche non unique');
    });
    test('Trouver une tâche par identifiant', () {
      String searchCode = '1';
      var task = tasks.find(searchCode);
      expect(task, isNotNull);
      expect(task.idTask.toString() , equals(searchCode));
      tasks.display('Trouver une tâche par description');
    });
    test('Selection des tâches terminées', () {
      var completedTasks = tasks.select((t) => t.completed);
      expect(completedTasks.isEmpty, isFalse);
      expect(completedTasks.length, equals(2));
      completedTasks.display('Selection des tâches terminées');
    });
    test('Selection des tâches en cours', () {
      var incompletedTasks = tasks.select((t) => !t.completed);
      expect(incompletedTasks.isEmpty, isFalse);
      expect(incompletedTasks.length, equals(2));
      incompletedTasks.display('Selection des tâches en cours');
    });    
    test('Selectionner les taches complétées puis rajouter une complétée', () {
      var completedTasks = tasks.select((t) => t.completed);
      expect(completedTasks.isEmpty, isFalse);
      
      var nouvelleTache = '5';
      var completedTask = new Task();
      expect(completedTask, isNotNull);
      completedTask.idTask = 5; 
      completedTask.description = 
          'Faire les tests unitaires de dartlero';
      completedTask.completed = true;
      var added = completedTasks.add(completedTask);
      expect(added, isTrue);
      completedTasks.display('Selection des taches complétées puis rajouter une complétée');

      var task = tasks.find(nouvelleTache);
      expect(task, isNull);
      tasks.display('Tâches');
    });
    test('Choisir les têches complétées et supprimer une de cette liste', () {
      var taskCount = tasks.length;
      tasks.display('Têches avant suppression');
      var completedTasks = tasks.select((t) => t.completed);
      expect(completedTasks.isEmpty, isFalse);

      var searchName = '3';
      var task = completedTasks.find(searchName);
      expect(task, isNotNull);
      expect(task.idTask.toString(), equals(searchName));
      var completedTaskCount = completedTasks.length;
      completedTasks.remove(task);
      expect(completedTasks.length, equals(--completedTaskCount));
      completedTasks.display('Têches après suppression');
      expect(tasks.length, equals(taskCount));
    });
    test('Tri des taches par statut et description', () {
      tasks.orderByFunction((m,n) => m.compareTo(n));
      tasks.display('Tri des taches par statut et description');
    });
    test('Copier les tâches', () {
      Tasks copiedTasks = tasks.copy();
      expect(copiedTasks.isEmpty, isFalse);
      expect(copiedTasks.length, equals(tasks.length));
      expect(copiedTasks, isNot(same(tasks)));
      expect(copiedTasks, isNot(equals(tasks)));
      copiedTasks.forEach((ct) =>
          expect(ct, isNot(same(tasks.find(ct.idTask.toString())))));
      copiedTasks.display('Tâches copiées');

    });
    test('Vrai pour toutes les tâches', () {
      expect(tasks.every((t) => t.code != null), isTrue);
      expect(tasks.every((t) => t.description != null), isTrue);
    });
    test('From Tasks to JSON', () {
      var json = tasks.toJson();
      expect(json, isNotNull);
      print(json);
    });
    test('From JSON to Task Model', () {
      List<Map<String, Object>> json = tasks.toJson();
      tasks.clear();
      expect(tasks.isEmpty, isTrue);
      tasks.fromJson(json);
      expect(tasks.isEmpty, isFalse);
      tasks.display('From JSON to Tasks');
    });
  });
}

initDisplayModel() {
  TaskModel taskModel = new TaskModel();
  taskModel.init();
  taskModel.display();
}

testModel() {
  TaskModel taskModel = new TaskModel();
  Tasks tasks = taskModel.tasks;
  testTasks(tasks);
}

main() {
  testModel();
}



