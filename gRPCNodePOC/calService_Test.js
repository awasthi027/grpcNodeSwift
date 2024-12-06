const client = require("./calServiceClient");
/*
// sample request to add number
client.AddNum(
  {
    first_number: 3,
    second_number: 36,
  },
  (error, response) => {
    if (error) throw error;
    console.log(`Sum:  ${response.sum_result}`);
  }
); */


/*
// Server stream call 
 let serverStreamCall = client.FiboSeries({ num: 8});
  serverStreamCall.on('data',function(response) {
    console.log(response.num);
  });

  serverStreamCall.on('end',function(){
    console.log('fibonacci calculation has been completed');
  });
*/

/*
// client stream call 
let clientStreamCall = client.ComputeAverage({},
  (error, response) => {
    if (error) throw error;
    console.log(`Average Number:  ${response.average}`);
  }
);

clientStreamCall.write({number: 5});
clientStreamCall.write({number: 4});
clientStreamCall.write({number: 3});
clientStreamCall.write({number: 10});
clientStreamCall.write({number: 12});
clientStreamCall.end();
*/


// Client and server stream 
let serverAndClientSteamCall = client.FindMaximum({})
  serverAndClientSteamCall.on('data',function(response) {
     console.log(`Maximum Number:  ${response.maximum}`);
  });

  serverAndClientSteamCall.on('end',function(){
    console.log('Find Maximum Number call has been end');
  });

serverAndClientSteamCall.write({number: 5});
serverAndClientSteamCall.write({number: 4});
serverAndClientSteamCall.write({number: 3});
serverAndClientSteamCall.write({number: 10});
serverAndClientSteamCall.write({number: 12});
serverAndClientSteamCall.end();





