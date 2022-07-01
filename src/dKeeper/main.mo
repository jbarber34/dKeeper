import List "mo:base/List";
import Debug "mo:base/Debug";

actor DKeeper {

  // Create data type for notes
  public type Note = {
    // Add components for note
    title: Text;
    content: Text;
  };

  // Create new Notes variable which is a list type and contains notes inside the list - start as empty list for now, but still a Note object
  stable var notes: List.List<Note> = List.nil<Note>();

  // Create public createNote() function allowing to send title and content to JavaScript frontend
  public func createNote(titleText: Text, contentText: Text){
    // Create new note, notice '=' when creating the new note, but ':' when creating the type above
    let newNote: Note = {
      title = titleText;
      content = contentText;
    };

    // Add new note to the list of Notes by appending notes list
    notes := List.push(newNote, notes);
    Debug.print(debug_show(notes));

  };

  // Create function for reading notes back to the front end - read in the list as an array
  public query func readNotes(): async [Note]{
    return List.toArray(notes);
  };

  // Create function to delete notes from the data array
  public func removeNote(id: Nat){
    // Take the first n (all before the id) and save those
    let listFront =  List.take(notes, id);
    // Drop the first n + 1 (+ 1 is the item we want to delete) and save the remainder
    let listBack = List.drop(notes, id + 1);
    // Append the notes array to include everything besides the item with the input id
    notes := List.append(listFront, listBack);
  };

}
