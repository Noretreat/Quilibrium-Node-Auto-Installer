#!/bin/bash
#Step 0: Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || { echo "Failed to install Homebrew! Exiting..."; exit 1; }
(echo; echo 'eval "$(/opt/homebrew/bin/brew shellenv)"') >> /Users/m1/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
#Step 1: Update package lists
echo "Updating package lists..."
brew update || { echo "Failed to update package lists! Exiting..."; exit 1; }
#Step 2: Install required packages
echo "Installing required packages..."
brew install curl wget git tmux nano unzip || { echo "Failed to install required packages! Exiting..."; exit 1; }
#Step 3: Install Rust
echo "Installing Rust..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y || { echo "Failed to install Rust! Exiting..."; exit 1; }
echo 'source $HOME/.cargo/env' >> $HOME/.zshrc
source $HOME/.zshrc
#Step 4: Download and install Go
echo "Installing Go..."
wget https://go.dev/dl/go1.20.14.darwin-amd64.tar.gz || { echo "Failed to download Go! Exiting..."; exit 1; }
sudo tar -C /usr/local -xzf go1.20.14.darwin-amd64.tar.gz || { echo "Failed to extract Go! Exiting..."; exit 1; }
echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.zshrc
source $HOME/.zshrc
#Step 4.1: Configure the firewall
echo "Configuring the firewall..."
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on || { echo "Failed to enable firewall! Exiting..."; exit 1; }
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/bin/ssh || { echo "Failed to allow SSH! Exiting..."; exit 1; }
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/local/go/bin || { echo "Failed to allow Go! Exiting..."; exit 1; }
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --add /usr/bin/git || { echo "Failed to allow Git! Exiting..."; exit 1; }
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --getglobalstate || { echo "Failed to get firewall status! Exiting..."; exit 1; }
#Step 5: Clone ceremonyclient repository
echo "Cloning ceremonyclient repository..."
git clone https://source.quilibrium.com/quilibrium/ceremonyclient $HOME/ceremonyclient || { echo "Failed to clone repository! Exiting..."; exit 1; }
cd $HOME/ceremonyclient/ || { echo "Failed to change directory! Exiting..."; exit 1; }
git checkout release || { echo "Failed to checkout release branch! Exiting..."; exit 1; }
