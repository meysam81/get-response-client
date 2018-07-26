# get-response-client
This project is the client side of a service that I have coded before  
and can be accessed using [THIS LINK](https://github.com/meysam81/get-response-server)

## Quick start
To run this application, first you're gonna have to clone this  
repository to your own local computer using the following command:  
`git clone git@github.com:meysam81/get-response-client.git`

Then change your directory to the directory of this repository:  
`cd get-response-client`

### Important notice
You need to start your [SERVER](https://github.com/meysam81/get-response-server) before proceeding any further.

Now to access the __REPL__ of this application you can enter the  
the following command in your **linux** terminal:  
`make rel-dev && make console-dev`

Now you should see the __REPL__ of your application in your terminal,  
from here on, you can enter Erlang commands, or you can test your client.

To test only **one** client you can use the following command:  
`my_client_v2_jactor:start().`

This command will send a request to your [SERVER](https://github.com/meysam81/get-response-server), and the result  
would be the response of that request to your client.

Now if you want to benchmark your server's response time (service time)  
you can first edit the values of the configuration file that exist in the  
following address:  
`config/dev.sys.config`

This configuration file contains various items which we're not gonna use  
all of them. But what we are interested in are the following keys in the  
beginning of the file:  
```
...
[{my_client_v2, [{host, localhost},
 3                 {port, 4040},
 4                 {toveri_ref, my_toveri},
 5                 {mfa, {my_client_v2_worker, start_link, []}},
 6                 {toveri_size, 8},
 7                 {number_of_clients, [10, 100, 1000]},
 8                 {time_between_benchmarks, 1000}]},
 ...
```
**Do NOT edit the keys** of this configuration file, but only the values.

Finally after customizing your application through the configuration file,  
start your application using the following command:  
`my_client_v2_benchmark_initiator:start()`

#### Acknowledgment
Many thanks to my [mentor](https://github.com/mohsenmoqadam), and my _friend_, whom I  
learned a lot from.
