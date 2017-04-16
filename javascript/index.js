'use strict';

/* eslint no-console: off */

const http = require('http');
const bcrypt = require('bcryptjs');

function handler(req, res) {
    const input = req.url.replace(/^\//, '');
    const salt = bcrypt.genSaltSync(10);
    const hash = bcrypt.hashSync(input, salt);
    const responseBody = `{"status":"OK","hash":"${hash}"}`;
    const headers = {
        'Cache-Control': 'no-cache',
        Connection: 'close',
        'Content-Length': Buffer.byteLength(responseBody),
        'Content-Type': 'application/json'
    };

    res.writeHead(200, headers);
    return res.end(responseBody);
}

function bootstrap() {
    const server = http.createServer(handler);
    const port = 3003;
    server.listen(port, function (err) {
        if (err) {
            console.log('server failed to start');
        }
        console.log(`server is listening on ${port}`);
    });
}

if (!module.parent) {
    bootstrap();
}
