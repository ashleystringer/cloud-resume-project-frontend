            console.log("url");
    
            let count = 0;
            let url = `https://nqeh8qos1e.execute-api.us-east-2.amazonaws.com/count`; //FIX THIS
    
            //console.log(url);
    
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