# bloc_todo_list

A simple todo app built using bloc architecture and state management

## Purpose of this app
* To demonstrate the implementation of bloc pattern using:
  * BlocListener<Event, State>()
  * BlocBuilder<Event, State>()
  * BlocProvider<Event, State>()
  * BlocObserver<Event, State>()
  * and Cubit<State>
  
* Implementation of a less complex bloc architecture to enable easy maintenance by any other developer

## Challenges encountered
* None, really
> Bloc seems very intuitive. 
> 1. Event goes in, State comes out.
> 2. Listen to state and update UI accordingly

## Folder structure 📂

```.
+-- pubscpec.yaml
+-- README.md
+-- lib
|   +-- business_logic
|       +-- blocs
|       +-- cubits  
|   +-- data
|     +-- data_providers (empty)
|     +-- models
|     +-- repositories (empty)
|   +-- presentation
|     +-- shared
|         +-- colors.dart
|         +-- spacer.dart
|         +-- theme.dart
|     +-- views
|         +-- todo_view.dart
|     +-- widgets
|         +-- todo_widget.dart
|   +-- main.dart
```
  
# TODO
* Describe the contents of key folders in the architecture
