param([string]$proxyaddr) #Must be the first statement in your script

git config --global http.proxy $proxyaddr
git config --global https.proxy $proxyaddr

npm config set http-proxy $proxyaddr
npm config set https-proxy $proxyaddr
