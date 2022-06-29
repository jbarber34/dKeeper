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
  var notes: List.List<Note> = List.nil<Note>();

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


}
