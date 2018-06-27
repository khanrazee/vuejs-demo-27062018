exports.handler = (event, context, callback) => {
    const https = require('https');
    var body = JSON.stringify({
        name: event['name'],
        email: event['email'],
        upwork_name: event['profile_url'],
        message: event['message']
    })
    const options = {
        host: 'hbupworktest.herokuapp.com',
        port: 443,
        path: '/api/v1/gadgets.json',
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Auth_Token': 'xxgtexfrstnayuzcncvwicjtpgpyixjioacfizrlcxetmpeqrp'
        }
    };

    const req = https.request(options, (res) => {
            res.on('data', (d) => {
            process.stdout.write(d);
});
});

    req.on('error', (e) => {
        console.error(e);
});
    req.end(body);
    //callback(null, 'Post back to EC2 and update status with event[email]');
};