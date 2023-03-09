const express = require("express");
const app = express();
var path = require('path');
var httpProxy = require('http-proxy');

const XMLHttpRequest = require('xmlhttprequest').XMLHttpRequest
var proxy = httpProxy.createProxyServer({});

const rabbitmq_url = process.env.RABBITMQ_URL;
const client_id = process.env.CLIENT_ID;
const client_secret = process.env.CLIENT_SECRET;
const uaa_url = process.env.UAA_URL;

app.engine('.html', require('ejs').__express);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'html');

app.get('/', function(req, res){
  let id =  default_if_blank(req.query.client_id, client_id);
  let secret =  default_if_blank(req.query.client_secret, client_secret);
  res.render('rabbitmq', {
    url: rabbitmq_url.replace(/\/?$/, '/') + "login",
    name: rabbitmq_url + " for " + id,
    access_token: access_token(id, secret)
  });
});
proxy.on('proxyReq', function(proxyReq, req, res, options) {
  proxyReq.setHeader('Authorization', 'Bearer 34343');
});
app.get('/proxy/*', function(req, res) {
    console.log("old request url " + req.url)
    req.url = '/' + req.url.split('/').slice(2).join('/'); // remove the '/proxy' part
    console.log("new request url " + req.url)
    proxy.proxyRequest(req, res, {
        host: "localhost",
        port: 15672
    });
});

app.listen(3000);
console.log('Express started on port 3000');

function default_if_blank(value, defaultValue) {
  if (typeof value === "undefined" || value === null || value == "") {
    return defaultValue;
  } else {
    return value;
  }
}

function access_token(id, secret) {
  const req = new XMLHttpRequest();
  const url = uaa_url + '/oauth/token';
  const params = 'client_id=' + id +
    '&client_secret=' + secret +
    '&grant_type=client_credentials' +
    '&token_format=jwt' +
    '&response_type=token';

  console.debug("Sending " + url + " with params "+  params);

  req.open('POST', url, false);
  req.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  req.setRequestHeader('Accept', 'application/json');
  req.send(params);
  if (req.status == 200) {
    const token = JSON.parse(req.responseText).access_token;
    console.log("Token => " + token)
    return token;
  } else {
    throw new Error(req.status + " : " + req.responseText);
  }
}
