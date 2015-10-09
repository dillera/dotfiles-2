#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade --all

# Handle dependencies
brew install caskroom/cask/brew-cask
brew tap caskroom/versions

# dependencies for Formulas and Casks
dependencies=(
  java
  java6
  virtualbox
  xquartz
)

# Install dependencies to /Applications - default is: /Users/$user/Applications
echo "installing dependencies..."
brew cask install --appdir="/Applications" ${dependencies[@]}

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
# Note: don’t forget to add `/usr/local/bin/bash` to `/etc/shells` before
# running `chsh`.
brew install bash
brew install bash-completion

# Install `wget` with IRI support.
brew install wget --with-iri

# Install more recent versions of some OS X tools.
brew install vim --override-system-vi
brew install homebrew/dupes/grep
brew install homebrew/dupes/openssh
brew install homebrew/dupes/screen

#better php tap
brew tap homebrew/dupes
brew tap homebrew/versions
brew tap homebrew/homebrew-php

#tap services - see: https://github.com/Homebrew/homebrew-services
brew tap homebrew/services

#install current dev/vm version of php
brew install php56

#install php mods / composer
brew install composer
brew install phpmd
brew install php-code-sniffer
brew install php-cs-fixer

#install some benchmarking tools
brew install wrk
brew install siege

# Install font tools.
brew tap bramstein/webfonttools
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Install some CTF tools; see https://github.com/ctfs/write-ups.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install cifer
brew install dex2jar
brew install dnsmasq
brew install dns2tcp
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install knock
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install tcpdump
brew install ucspi-tcp # `tcpserver` etc.
brew install wireshark
brew install homebrew/x11/xpdf
brew install xz

# Install other useful binaries.
brew install ack
brew install ngrep
brew install dark-mode
brew install exiv2
brew install git
brew install git-lfs
brew install hub
brew install htop
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rhino
brew install speedtest_cli
brew install ssh-copy-id
brew install tree
brew install trash
brew install webkit2png
brew install zopfli

# Install Node.js. Note: this installs `npm` too, using the recommended
# installation method.
brew install node
# install phantomjs for el capitan
npm install phantom phantomjs -g
# yosemite | brew install phantomjs

#install rbenv and ruby build
brew install rbenv
brew install ruby-build
brew install rbenv-default-gems

#install git
brew install git

#config git
curl -s -O \
https://github-media-downloads.s3.amazonaws.com/osx/git-credential-osxkeychain

chmod u+x git-credential-osxkeychain

sudo mv git-credential-osxkeychain \
"$(dirname $(which git))/git-credential-osxkeychain"

git config --global credential.helper osxkeychain

#dat private repo access
pub=$HOME/.ssh/id_rsa.pub
echo 'Checking for SSH key, generating one if it does not exist...'
if
  [ ! -f $pub ] ; then
  ssh-keygen -t rsa
  echo 'Copying public key to clipboard. Paste it into your Github account...'
  cat $pub | pbcopy
  open 'https://github.com/account/ssh'
fi

#import anti-gravity
brew install python
brew linkapps python

#Install thefuck: https://github.com/nvbn/thefuck
brew install thefuck

# Apps for caskroom
apps=(
  adobe-creative-cloud
  adium
  alfred
  appcleaner
  arq
  atom
  brackets
  caffeine
  charles
  cloudup
  dropbox
  firefox
  flash
  flux
  geektool
  google-chrome
  hazel
  iterm2
  lastpass
  little-snitch
  mailbox
  qlcolorcode
  qlmarkdown
  qlprettypatch
  qlstephen
  quicklook-json
  rdio
  screenflick
  sequel-pro
  shiori
  shuttle
  sketch
  skype
  slack
  spotify
  sublime-text
  telegram
  tower
  transmission
  transmit
  vagrant
  vlc
  wireshark
)

# Install apps to /Applications - default is: /Users/$user/Applications
echo "installing cask apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# Remove outdated versions from the cellar.
brew cleanup

brew cask cleanup
