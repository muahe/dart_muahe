import 'dart:html';
import 'package:dartlero/dartlero.dart';
import 'package:ex04_dartlero_task/ex04_dartlero_task.dart';


InputElement inputTask;
UListElement list;
DivElement countDiv,completedCountDiv, uncompletedCountDiv;

TaskModel taskModel = new TaskModel();
Tasks tasks = taskModel.tasks;
const AUTO_SEQ = 0;


main() {
  inputTask = querySelector('#new-todo');
  list = querySelector('#todo-list');
  countDiv = querySelector('#count');
  completedCountDiv = querySelector('#countCompleted');
  uncompletedCountDiv = querySelector('#countUncompleted');
  inputTask.onChange.listen(addItem);
  //list.onClick.listen(changeStatus);
}

void addItem(e) {

 // inputTask.value = 'je suis la';
  //tasks.
  var task = new Task();
  task.description = inputTask.value;
  task.idTask =  tasks.length; 
  
  task.completed = false;
  tasks.add(task);
  
  printLine(task);
  
}

void changeStatus(e){
  var clickedElem = e.target;
  Task task = tasks.find(clickedElem.id);
  task.completed = !task.completed;
  if ( task.completed ){
    clickedElem.classes.add('lineThrough');
  }else{
    clickedElem.classes.clear();
  }
  updateCounter();

}

void removeLine(e){
  var clickedElem = e.target;
  Task task = tasks.find(clickedElem.id);
  clickedElem.remove();
  tasks.remove(task); 
  updateCounter();

}

void updateCounter(){
  var completedTasks = tasks.select((t) => t.completed);
  var incompletedTasks = tasks.select((it) => !it.completed);
  
  countDiv.text = 'nombre de taches ' 
              + tasks.length.toString();
  completedCountDiv.text = 'nombre de taches complétées ' 
              + completedTasks.length.toString();
  uncompletedCountDiv.text = 'nombre de taches en cours ' 
              + incompletedTasks.length.toString();
  
}

void printLine(task) {
  var newListTask = new LIElement();
  var newCheckBox = new CheckboxInputElement();
  var myDiv = new DivElement();
  newListTask.id =  task.idTask.toString();
  newListTask.text = task.description; 
  newListTask.onClick.listen(changeStatus);
  newListTask.onDoubleClick.listen(removeLine);
  inputTask.value = '';
  list.children.add(newListTask);
  updateCounter();
  
}
