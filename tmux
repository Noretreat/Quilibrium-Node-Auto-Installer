#!/bin/bash

# Define the tmux session name
SESSION_NAME="node"

# Kill the tmux session if it exists
tmux has-session -t $SESSION_NAME 2>/dev/null
if [ $? == 0 ]; then
  tmux kill-session -t $SESSION_NAME
fi

# Open ports 8337 to 8376
for port in {8337..8376}; do
  sudo ufw allow $port
done

# Navigate to the .config directory
cd /ceremonyclient/node/.config

# Remove the store folder
rm -rf store

# Clean up by removing the old store.zip file if it exists
if [ -f store.zip ]; then
  rm store.zip
fi

# Download the new store.zip file
curl --header "Host: drive.usercontent.google.com" --header "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36" --header "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7" --header "Accept-Language: en-US,en;q=0.9" --header "Cookie: SEARCH_SAMESITE=CgQIgZsB; OGPC=19010599-1:; SID=g.a000jAhdixE9TbNkLbYIHpejnCFOFsGoPuvscrngVVq-h9sBLwVsRIRx2AbLvCjaw126IeB3rAACgYKARMSAQASFQHGX2Mie5uNm7ausBEYwJXAEnmVjhoVAUF8yKpZnNgbdGFsddTJKCNoTdRw0076; __Secure-1PSID=g.a000jAhdixE9TbNkLbYIHpejnCFOFsGoPuvscrngVVq-h9sBLwVsc_Lp2KFxTN8Pv4pHJsFYYwACgYKAagSAQASFQHGX2MiGhnI0lNDha3-mMJA_eLaKxoVAUF8yKriMy0qecYyWQ0lwM3yUkrC0076; __Secure-3PSID=g.a000jAhdixE9TbNkLbYIHpejnCFOFsGoPuvscrngVVq-h9sBLwVsoFdWb1bL08HwQuy9OPuY8wACgYKAbMSAQASFQHGX2MisPCdHUgdj4NXKkSTCajNIhoVAUF8yKovYojJPlEMhg57iMlcRp1-0076; HSID=AbGofwUORyIZSBSpS; SSID=AgM66Qvhuhknbwr37; APISID=epwS-zWPY_e9bUmg/AETt-kteBUjJXDc2e; SAPISID=zGZPr1GFS2MosGCv/Ao4icauVZ1XGa5KIX; __Secure-1PAPISID=zGZPr1GFS2MosGCv/Ao4icauVZ1XGa5KIX; __Secure-3PAPISID=zGZPr1GFS2MosGCv/Ao4icauVZ1XGa5KIX; AEC=AQTF6Hz4rfDu2eC6dKGKhwQM-3-xboaPm15YQcdKOmwKAiK-11TIf3tkEQs; NID=514=mtX1ZsLt9hb8uwDUUoDnuaUSigQSnttlE45oaWQ3kvZLK96McSNjB_BeFN3xNS_XMylD9Z0xwUO1OKjVQvgmF4hqSYDFSjCqiMyPz4JolXvJbFSLXf_3mzPBCkC9ytIgghtAjRh2VJxpXKeepjbT3ve3vS9TtWqqR31fne-ccB9GMBa2IVAPybI4HCQCWWeqMF4Tiqz8oSO-nKOnqUeKj8VnGDSEI6IkgCtbKjxSFdt1T48dmn19limih-58iVHlArxKBOtaZPGTVRzM1Unv-5SDyZYkFlNtL8AsOOF4l_Ji_sPA6qcBCNR6ZRuicg3lDuag82BN3Cg6d2hkNbcN_IYtVB4Y5DIMoSRU556TfiN_ybiqaxlAT5hL5wm-gal3zLVtF8Foncb-xN8a_w9njA44btonxRy42Ve_MNday0ITvRaZK_0N; 1P_JAR=2024-05-23-02; __Secure-1PSIDTS=sidts-CjIBLwcBXD42AE5avxnL4N0_Dahttpp3-kBU3yT3zHagvhPeCw1-7Cmh3YA6ZnkhrI65exAA; __Secure-3PSIDTS=sidts-CjIBLwcBXD42AE5avxnL4N0_Dahttpp3-kBU3yT3zHagvhPeCw1-7Cmh3YA6ZnkhrI65exAA; SIDCC=AKEyXzWCfGGphByY4grw8Cp0QJIrgdNyPIvZJ_0xvHdFmNFLXjcpTr3XqzlsT1aR4hRVfWzqxg; __Secure-1PSIDCC=AKEyXzVymZ6p6Te4gsnzwFSl6UirC6SpA6BGVQcgAHxeJGQyQVFHaj9Atn6r9WAlP_JT1jQGCA; __Secure-3PSIDCC=AKEyXzVCmmCzHoD2MLwm5wZsDQ4HiJk4y0v1yvMu9oWkCb2t9MARa4JdS87ZzeWlVtb1jggZ_mY" --header "Connection: keep-alive" "https://drive.usercontent.google.com/download?id=1Ye7Lh9A0q7oPCJZyLaZzdRfspYWnic2V&export=download&authuser=3&confirm=t&uuid=299f56f4-a6d8-4b95-922b-3faa1805650c&at=APZUnTUkyKlyO0mDsINuhh8o1-sV:1716433048492" -L -o "store.zip"

# Unzip the store.zip file
unzip store.zip

# Clean up by removing the store.zip file
rm store.zip

# Start a new tmux session and run the node command
tmux new-session -d -s $SESSION_NAME

# Send commands to the new tmux session
tmux send-keys -t $SESSION_NAME "cd /ceremonyclient/node/" C-m
tmux send-keys -t $SESSION_NAME "./restart_node.sh" C-m

# Notify when done
echo "Script execution completed."
