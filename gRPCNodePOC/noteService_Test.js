const client = require("./noteServiceClient");

// make request to print sample note
 client.GetSampleNote({}, (error, sampleNote) => {
  if (error) {
    console.log(error);
  } else {
    console.log(sampleNote);
  }
}) 

// simple greeting message
client.Greeting({name: "Ashish"}, (error, respnse) => {
  if (error) {
    console.log(error);
  } else {
    console.log(respnse);
  }
}) */
/*
// make request to get all notes
client.GetNotes({}, (error, respnse) => {
  if (error) {
    console.log(error);
  } else {
    console.log(respnse);
  }
}) 


// add a note
client.AddNote (
  { 
    title: "Title Note 3",
    content: "Body Description 3",
  },
  (error, note) => {
    if (error) throw error;
    console.log("Successfully created a news.");
  }

)

// make request to get all notes
client.GetNotes({}, (error, respnse) => {
  if (error) {
    console.log(error);
  } else {
    console.log("Notes after insert");
    console.log(respnse);
  }
})


// delete a note
client.DeleteNote(
  {
    id: 3,
  },
  (error, news) => {
    if (error) throw error;
    console.log("Successfully deleted a note item.");
  }
);

// get notes after delete item
client.GetNotes({}, (error, respnse) => {
  if (error) {
    console.log(error);
  } else {
    console.log("Notes after delete");
    console.log(respnse);
  }
})

// edit a news
client.EditNote(
  {
    id: 2,
    title: "Body content 2 edited.",
    content: "Image URL edited.",
  },
  (error, news) => {
    if (error) throw error;
    console.log("Successfully edited a note.");
  }
);



