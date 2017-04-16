'use strict';

const request = require('request');

function validateResponse(headers, body) {
	if (headers.statusCode !== 200) {
		return false;
	}

	if (body.status !== 'OK' || !body.hash) {
		return false;
	}

	console.log(headers.statusCode + ': ' + body.hash);
	return true;
}

function makeRequest(params, callback) {
	request(params, function (err, headers, body) {
		if (err) {
			return callback(err);
		} else if (!validateResponse(headers, JSON.parse(body))) {
			return callback(new Error('Failed validation'));
		}
		return callback(null, true);
	});
}

function run() {
	const params = {
		url: 'http://localhost:3002/testing-words',
		method: 'GET',
		headers: {
			'Content-Type': 'application/json'
		}
	};

	let error;
	for (let i = 0; i < 10000; i++) {
		makeRequest(params, function (err, pass) {
			error = err;
		});
	}
	console.log(error);
	// console.log(error.stack);
}

if (!module.parent) {
	run();
}
