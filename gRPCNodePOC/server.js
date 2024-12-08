// Load dependencies
const grpc = require("@grpc/grpc-js");
const protoLoader = require("@grpc/proto-loader");

// Path to our proto file
const PROTO_FILE = "./note.proto";

// Path to our proto file
const CalculatorServiceFile = "./calculator.proto";

// Options needed for loading Proto file
const options = {
  keepCase: true,
  longs: String,
  enums: String,
  defaults: true,
  oneofs: true,
};

// Load Proto File
const notePackageDefs = protoLoader.loadSync(PROTO_FILE, options);
// Load Definition into gRPC
const noteProto = grpc.loadPackageDefinition(notePackageDefs);

// Load Calculator Proto Service file
const calPackageDef = protoLoader.loadSync(CalculatorServiceFile, options);
// Load Definition into gRPC
const calProto = grpc.loadPackageDefinition(calPackageDef)


// Create gRPC server
const server = new grpc.Server();

var notes = [{ id: '1', title: 'First Note', content: 'First note description'},
            { id: '2', title: 'Second Note', content: 'Second Note description'} ];

autoGenerateNoteId = (function() {
    let counter = 2;
    return function() {
        counter++;
        return counter;
    }
})();




// Implement NoteService
server.addService(noteProto.NoteService.service, {

  // Basic sample request to get notes
  GetSampleNote: (input, callback) => {
    try {
      callback(null, { id: 1, title: "Just simple Note Titile", description: "This is a sample note description" });
    } catch (error) {
      callback(error, null);
    }
  },

  // Sample greeting message
  Greeting: (input, callback) => {
    try {
       const name = input.request.name;
      callback(null, {message: "Hello " + name});
    } catch (error) {
      callback(error, null);
    }
  },

  // Getting all notes
  GetNotes: (input, callback) => {
    try {
      callback(null, {notes: notes});
    } catch (error) {
      callback(error, null);
    }
  },

  // Add new note 
  AddNote: (input, callback) => {
    const newId = autoGenerateNoteId().toString();
    const _note = {id: newId, title: input.request.title, content: input.request.content };
    notes.push(_note);
    callback(null, _note);
  },

  // Delete note
  DeleteNote: (input, callback) => {
    const noteId = input.request.id;
   //removeing item
    let items = notes.filter(item => item.id !== noteId);
    notes = items;
    callback(null, {});
  },
  
 // Edit Note
  EditNote: (input, callback) => {
    const noteId = input.request.id;
    const noteItem = notes.find(({ id }) => noteId == id);
    noteItem.title = input.request.title;
    noteItem.content = input.request.content;
    callback(null, noteItem);
  },

});

// Register calculator service
server.addService(calProto.CalService.service, {
 // Basic sample request to Add Sum
  AddNum: (input, callback) => {
     let sum = input.request.first_number + input.request.second_number;
      callback(null, {sum_result: sum});
  },

  // Stream server response
  FiboSeries: (call) => {
    let num = call.request.num;
    if (num == 1) {
      call.write({num: 0});
      call.end();
    }
    if (num == 2) {
       call.write({num: 1});
       call.end();
    }
    let num1 = 0;
    let num2 = 1;
    let sum;
    let i = 2;
    while (i < num) {
        sum = num1 + num2;
        num1 = num2;
        num2 = sum;
        i += 1;
       call.write({num: sum});
    }
    call.end();
  },

  // collect client Request, Client Stream 
  ComputeAverage: (call, callback) => {

      var items = [];

      call.on('data',function(numberRequest) {
            let num = numberRequest.number;
            items.push(num);
      });

     call.on('end',function() { 
        let length = items.length;
        const averageValue = items.reduce((a, b) => a + b, 0) / length;
        callback(null, {average: averageValue} );
    });
  },

 // server and client stream
 FindMaximum: (call) => {
      var items = [];
      call.on('data',function(numberRequest) {
            let num = numberRequest.number;
            items.push(num);
            let largest = items.sort((a,b)=>a-b).reverse()[0];
            call.write({ maximum: largest } );
      });

     call.on('end',function() { 
        call.end();
    });
  },

});

// Start the Server
server.bindAsync(
  // Port to serve on
  "127.0.0.1:3500",
  // authentication settings
  grpc.ServerCredentials.createInsecure(),
  //server start callback
  (error, port) => {
    console.log(`listening on port ${port}`);
    server.start();
  }
);