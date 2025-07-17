            //if visitor counter exists in storage, don't increment it.
                // use the GET request to get the count from the backend
                // use the return value of the GET request to update the local storage
                // display the count on the page
             
            //if visitor counter doesn't exist in storage,
                // - create local storage for that vistor counter
                // use the PUT request to increment the counter on the backend
                // use the return value of the PUT request to update the local storage
                // display the count on the page
    
                console.log("url");
    
                let count = 0;
                //let url = `https://${process.env.API_ID}.execute-api.${process.env.REGION}.amazonaws.com/count`; //FIX THIS
                let url = `https://nqeh8qos1e.execute-api.us-east-2.amazonaws.com/count`; //FIX THIS
    
                console.log(url);
    
                if (localStorage.getItem('visitorCount')){
                    fetch(url, { method: "GET" })
                    .then(response => response.json())
                    .then(data => {
                        console.log(data)
                        count = data.count
                        console.log(`count: ${count}`);
                        localStorage.setItem('visitorCount', count)
                        document.querySelector(".visitor-count").innerText = localStorage.getItem('visitorCount');
                    })
                } else {
                    fetch(url, { method: "PUT" })
                    .then(response => response.json())
                    .then(data => {
                        console.log(data)
                        count = data.count
                        localStorage.setItem('visitorCount', count)
                        document.querySelector(".visitor-count").innerText = localStorage.getItem('visitorCount');
                    })
                 }

                console.log(`count: ${count}`);
                console.log(`visitorCount: ${localStorage.getItem('visitorCount')}`);
                console.log(`document.querySelector(".visitor-count"): ${document.querySelector(".visitor-count")}`);

                 
                 if (count){
                    //document.getElementById("visitorCount").innerHTML = count;
                 }