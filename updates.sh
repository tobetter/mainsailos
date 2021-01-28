#!/bin/sh

export DEBNAME="Dongjin Kim"
export DEBEMAIL="tobetter@gmail.com"

PACKAGE_FILE="package.zip"

version=$(curl -sL https://api.github.com/repos/meteyou/mainsail/releases/latest \
		| jq -r .tag_name)
package=$(curl -sL https://api.github.com/repos/meteyou/mainsail/releases/latest \
		| jq -r .assets[0].browser_download_url)

wget ${package} -O ${PACKAGE_FILE}
rm -rf var/www/mainsail && mkdir -p var/www/mainsail
unzip ${PACKAGE_FILE} -d var/www/mainsail
rm -f ${PACKAGE_FILE}

dch -v $(echo ${version} |  sed "s/[^0-9]*//") "Package version bump to ${version}"

git add var
git add debian/changelog
git commit -s -m "Package version bump to ${version}"
