
# Extract the missing package on Lambda runtime with all its dependencies
pip install requests -t .
# bin directory not needed
rm -rf ./bin/
# Package lambda file and its dependencies into ZIP
zip -r telegram_notif.py.zip \
    requests/ \
    requests-2.32.3.dist-info/ \
    certifi/ \
    certifi-2024.8.30.dist-info/ \
    idna/ \
    idna-3.8.dist-info/ \
    charset_normalizer/ \
    charset_normalizer-3.3.2.dist-info/ \
    urllib3/ \
    urllib3-2.2.2.dist-info/ \
    telegram_notif.py