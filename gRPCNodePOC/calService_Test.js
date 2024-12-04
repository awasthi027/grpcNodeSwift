const client = require("./calServiceClient");


client.AddNum(
  {
    first_number: 3,
    second_number: 36,
  },
  (error, response) => {
    if (error) throw error;
    console.log(`Sum:  ${response.sum_result}`);
  }
); 



 let serverStreamCall = client.FiboSeries({ num: 8});
  serverStreamCall.on('data',function(response) {
    console.log(response.num);
  });

  serverStreamCall.on('end',function(){
    console.log('fibonacci calculation has been completed');
  });



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



