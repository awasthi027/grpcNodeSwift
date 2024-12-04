// Load up dependencies
const grpc = require("@grpc/grpc-js");
const protoLoader = require("@grpc/proto-loader");
// Path to proto file
const PROTO_FILE = "./note.proto";

// Options needed for loading Proto file
const options = {
  keepCase: true,
  longs: String,
  enums: String,
  defaults: true,
  oneofs: true,
};

// Load Proto File
const pkgDefs = protoLoader.loadSync(PROTO_FILE, options);
// Load Definition into gRPC
const NoteService = grpc.loadPackageDefinition(pkgDefs).NoteService;

// Create the Client
const client = new NoteService (
  "localhost:3500",
  grpc.credentials.createInsecure()
);

module.exports = client;
