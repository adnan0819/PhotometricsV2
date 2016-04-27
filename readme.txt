It's all js. Very simple frontend with angular and backend with node.
(In the end, we do need a backend to run the matlab script. Why? Read below:)

What you need: 
------------------
* Place the mirflickr library in the root folder
* nodejs that you can download in nodejs.org

How it works: 
------------------
* in your root folder(important!), type npm install ( should install two dependencies for nodejs: express and socket.io)
* then type node server.js ( still in your root folder)
* go to your browser, type: localhost:8080/index.html

The user interface has two views: 
a. /images, where user clicks on a picture
b. /images/:id, where user sees similar images from database
 
Executing a matlab script: 
----------------------------
When user selects an image, we execute a matlab script locally (on a computer where matlab is setup).
In nodejs, we can execute a command to run a matlab script and provide its argument (the image).
(https://canvas.harvard.edu/courses/3013/pages/programming-bootcamp-1-9-running-a-matlab-script-from-the-command-line)

Our matlab script populates the results.json file in our root folder. We can use JSONlab to do this. 

The node server listens for the file to be populated and then forwards the data to the frontend via
a socket. This is why we need a server: to be listening for the completion of the matlab script. 
And nodejs simple interface of sockets makes that easy.