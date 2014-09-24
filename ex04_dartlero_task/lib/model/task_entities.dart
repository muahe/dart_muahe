part of ex04_dartlero_task;


class Task extends ConceptEntity<Task> {
  
  int _idTask;
  String description;
  bool completed;
  
  
  int get idTask => _idTask;
  set idTask(int idTask){
    _idTask = idTask;
    if (code == null) {
      code = idTask.toString();
    }
  }
  
  
  Task newEntity() => new Task();
  
  Task copy() {
    var task = super.copy();

    task.idTask = idTask;
    task.description = description;
    task.completed = completed;
    return task;
  }


  String toString() {
    return '  {\n '
           '    ${super.toString()}, \n '
           '    Identifiant tâche : ${idTask}, \n '
           '    Description tâche : ${description}\n'
           '    Statut tâche : ${completed}, \n '
           '  }';
  }
  
  Map<String, Object> toJson() {
    Map<String, Object> entityMap = super.toJson();
    entityMap['idTask'] = idTask;
    entityMap['description'] = description;
    entityMap['completed'] = completed;
    return entityMap;
  }
  
  fromJson(Map<String, Object> entityMap) {
    super.fromJson(entityMap);
    idTask = entityMap['idTask'];
    description = entityMap['description'];
    completed = entityMap['completed'];
  }
  
  
  int compareTo(Task other) {

    if ((completed == other.completed) && (!completed)){
      return description.compareTo(other.description);  
    }else
    {
      return -99;
    }
    
  }
  
  
}


class Tasks extends ConceptEntities<Task> {

  Tasks newEntities() => new Tasks();
  Task newEntity() => new Task();

}