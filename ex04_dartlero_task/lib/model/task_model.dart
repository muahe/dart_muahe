part of ex04_dartlero_task;


class TaskModel extends ConceptModel {
  
  static final String task = 'Task';
  
  Map<String, ConceptEntities> newEntries() {
    var tasks = new Tasks();
    var map = new Map<String, ConceptEntities>();
    map[task] = tasks;
    return map;
  }
  
  Tasks get tasks => getEntry(task);
  
  init() {
    var task1 = new Task();
    task1.idTask = 1; 
    task1.description =
        'Préparer exercice FizzBuzz';
    task1.completed = true;
    tasks.add(task1);

    var task2 = new Task();
    task2.idTask = 2; 
    task2.description =
        'Lire le 4ème chapitre du livre';
    task2.completed = false;
    tasks.add(task2);
    
    var task3 = new Task();
    task3.idTask = 3; 
    task3.description =
        'Travailler le cours SIO-6510';
    task3.completed = true;
    tasks.add(task3);    
    
    var task4 = new Task();
    task4.idTask = 4; 
    task4.description =
        'Faire les courses le weekend';
    task4.completed = false;
    tasks.add(task4);    

  }

  display() {
    print('Task Model');
    print('=============');
    tasks.display('Tasks');
    print(
      '============= ============= ============= '
      '============= ============= ============= '
    );
  }
  
  
  
}