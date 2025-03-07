use 'lib.http.server'

server = new HttpServer(2025)
server.route('/hello', hello)

func hello(request) = {
    if (request.get('method') == 'GET') {
        return(new HttpResponse(200, 'world!'))
    } else {
        return(new HttpResponse(404, 'not found!'))
    }
}

server.start()