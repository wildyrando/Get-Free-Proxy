#!/bin/bash
# Author: Wildy Sheverando
# Contact: hai@wildyrando.com
# License: MIT License

function download() {
    if ! command -V wget > /dev/null 2>&1; then
       echo "Wget not installed"
       exit
    fi

    rm -rf $(pwd)/proxy.txt
    wget -O $(pwd)/proxy.txt 'https://api.proxyscrape.com/?request=getproxies&proxytype=http&timeout=5000&country=all&ssl=all&anonymity=all' > /dev/null 2>&1
    if [[ -f $(pwd)/proxy.txt ]]; then
       echo "Proxy has been downloaded, and saved in $(pwd)/proxy.txt"
       exit
    else
       echo "Download failed"
       exit
    fi
}

function check() {
    if [[ ! -f "$(pwd)/proxy.txt" ]]; then
        echo "No have 'proxy.txt' file in the current directory."
        exit
    fi

    while IFS= read -r proxy; do
        proxy=$(echo "$proxy" | sed 's/ //g' | tr -d '\n' | tr -d '\r\n')
        export http_proxy="http://$proxy"
        export https_proxy="http://$proxy"
        test=$(timeout 1 wget -qO- 'https://raw.githubusercontent.com/wildyrando/Get-Free-Proxy/main/testing')

        if [[ $test == "passed" ]]; then
            echo -e $"\n\n+++++ INFO +++++\nActive Proxy success be found !\nsaved in $(pwd)/isact.txt"
            echo "$proxy" > isact.txt
            exit
        else
            echo "$proxy not active"
        fi
    done < "proxy.txt"
}

if [[ $1 == "--download" ]]; then
    download
elif [[ $1 == "--check" ]]; then
    check
elif [[ $1 == "--activate" ]]; then
    if [[ ! -f "$(pwd)/isact.txt" ]]; then
        echo "No have 'isact.txt' file in the current directory."
        exit
    fi
    
    test=$(cat "$(pwd)/isact.txt") > /dev/null 2>&1
    if [[ $test == "" ]]; then
        echo "No have any active proxy saved in isact.txt"
        exit
    fi
echo " Paste this command to terminal:
------------------------------------------------------
export http_proxy=http://$(cat $(pwd)/isact.txt)
export https_proxy=https://$(cat $(pwd)/isact.txt)
------------------------------------------------------
"
else
echo 'Usage:
   getproxy --download   : download proxy list from proxyscrape.com
   getproxy --check      : run proxy check to check downloaded proxy from proxyscrape.com
   getproxy --activate   : activate the proxy in terminal
'
fi
