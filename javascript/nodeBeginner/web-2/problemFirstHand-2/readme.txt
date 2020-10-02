
http://localhost:8888/start
http://localhost:8888/upload
http://localhost:8888/notfound

with this aproach we are passing response as a parameter to route and subsequently to requesthandler
start function is making use of exec async call and ends response only after sleep and ls -ltr command is completed.
this way it would not block the calls for other request handlers upload and not found
