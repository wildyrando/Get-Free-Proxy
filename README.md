# Get-Free-Proxy
a simple bash script to get proxy from proxyscrape.com and check it using curl in terminal to get an active proxy

# Installation:
```bash
sudo wget -O /usr/local/bin/getproxy 'https://raw.githubusercontent.com/wildyrando/Get-Free-Proxy/main/get-proxy.sh'
sudo chmod +x /usr/local/bin/getproxy
```

# Usage:
```bash
getproxy --download   : download proxy list from proxyscrape.com
getproxy --check      : run proxy check to check downloaded proxy from proxyscrape.com
getproxy --activate   : activate the proxy in terminal
```
