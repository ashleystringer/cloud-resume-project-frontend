        
            // 
            //if visitor counter exists in storage, don't increment it.
                // use the GET request to get the count from the backend
                // use the return value of the GET request to update the local storage
                // display the count on the page
             
            //if visitor counter doesn't exist in storage,
                // - create local storage for that vistor counter
                // use the PUT request to increment the counter on the backend
                // use the return value of the PUT request to update the local storage
                // display the count on the page

                let count;
                let url = `https://h67uyj5484.execute-api.us-east-1.amazonaws.com/count`;
    
                console.log(url);
    
                fetch(url, { method: "GET" })
                .then((response) => {
                    console.log(response.json())
                    //count = response.json()
                }
                )
                .catch(err => {
                    console.error(err)
                })
    
                /*if (localStorage.getItem('visitorCount')){
                    //fetch request
                    fetch(url, { method: "GET" })
                    .then(response => {
                        console.log(response.json())
                        count = response.json()
                    }
                );
                } else {
                    fetch(url, { method: "PUT" })
                    .then(response => {
                            console.log(response.json())
                            count = response.json()
                            localStorage.setItem('visitorCount', )
                        }
                    );
    
                    //fetch request
                 }*/

                 
                 if (count){
                    //document.getElementById("visitorCount").innerHTML = count;
                 }