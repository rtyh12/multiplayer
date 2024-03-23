rm -rf ./bin/linux-server/*
/mnt/c/apps/godot/Godot_v4.2.1-stable_win64_console.exe --export-release "Server" --headless --verbose
/mnt/c/apps/godot/Godot_v4.2.1-stable_win64_console.exe --export-release "Server" --headless --verbose
ssh root@fairydust.cc -t "tmux kill-session -t server"
rsync -av --delete bin/linux-server/ root@fairydust.cc:~/server.bin
ssh root@fairydust.cc -t "tmux new-session -d -s server \"~/server.bin/gaem.sh server\""