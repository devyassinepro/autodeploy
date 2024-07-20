<?php
// webhook.php
$secret = '353100e068954a818b1deb9e346ae458210e2fefb556f9ca065dcc6eb6c947fc'; // Ensure this matches the secret in your GitHub/GitLab webhook settings
$payload = file_get_contents('php://input');
$sig_header = $_SERVER['HTTP_X_HUB_SIGNATURE'] ?? '';
list($algo, $sig) = explode('=', $sig_header, 2) + ['', ''];

if (!hash_equals($sig, hash_hmac($algo, $payload, $secret))) {
    http_response_code(403);
    exit('Invalid signature');
}

// Pull the latest changes and deploy
shell_exec('/home/user/deploy.sh > /dev/null 2>/dev/null &');
http_response_code(200);
echo 'Deployment triggered';
