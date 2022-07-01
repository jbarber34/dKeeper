import React, { useEffect } from "react";
import Header from "./Header";
import Footer from "./Footer";
import { useState } from "react";
import CreateArea from "./CreateArea";
import Note from "./Note.jsx"
import { dKeeper } from "../../../declarations/dKeeper";

// In order to run this app do the following:
// In first terminal tab: dfx start
// In another terminal tab: npm start
// When updates are made to app: dfx deploy

function App() {

    const [notes, setNote] = useState([]);

    function addNote(newNote) {
        setNote((prevItems) => {
            // Call create note function from main.mo
            // Pulling title and content that is created in CreateArea.jsx SetNote
            dKeeper.createNote(newNote.title, newNote.content)
            return [newNote, ...prevItems] // Flipping to have '...prevItems' as the first argument will put the note last (however it will move to first on refresh)
        });
    }

    // Trigger the following each time the page re-renders
    useEffect(() => {
        // Run fetchData() to pull in notes
        fetchData();
    }, []); // Add in array to ensure this only triggers a single time when the site reloads

    // Create function to pull data from Motoko backend
    async function fetchData() {
        const notesArray = await dKeeper.readNotes();
        setNote(notesArray);
    }

    function deleteNote(id) {
        // Delete data from the backend
        dKeeper.removeNote(id);

        // Delete the item from the list with the id entered as a param
        setNote(prevItems => {
            return prevItems.filter(
                (noteItem, index) => {
                    return index !== id;
                });
        });
    }

    return (
        <div>
            <Header />
            <CreateArea
                onAdd={addNote}
            />
            {notes.map((noteItem, i) => (
                <Note
                    key={i}
                    id={i}
                    title={noteItem.title}
                    content={noteItem.content}
                    onDelete={deleteNote}
                />
            ))}
            <Footer />
        </div>
    );
}

export default App;