#!/usr/bin/env bash
set -ex
DEFAULT_PROFILE_HOME=/home/flowcase-default-profile
PROFILE_SYNC_DIR=/kasm_profile_sync


function copy_default_profile_to_home {
    echo "Copying default profile to home directory"
    cp -rp $DEFAULT_PROFILE_HOME/.  $HOME/
    ls -la $HOME
}

function verify_profile_config {
    echo "Verifying Uploads/Downloads Configurations"

    mkdir -p $HOME/Shared
    mkdir -p $HOME/Downloads
    mkdir -p $HOME/Desktop

    # Remove old Desktop symlinks if they exist
    rm -f $HOME/Desktop/Uploads
    rm -f $HOME/Desktop/Downloads

    if [ -d "$HOME/Desktop/Shared Files" ]; then
        echo "Shared Files Desktop Symlink Exists"
    else
        echo "Creating Shared Files Desktop Symlink"
        ln -sf $HOME/Shared "$HOME/Desktop/Shared Files"
    fi

    if [[ "$(readlink -f $KASM_VNC_PATH/www/Downloads/Downloads)" != "$HOME/Shared" ]]; then
        echo "Fixing Downloads RX Symlink"
        rm -f $KASM_VNC_PATH/www/Downloads/Downloads
        ln -sf $HOME/Shared $KASM_VNC_PATH/www/Downloads/Downloads
    else
        echo "Downloads RX Symlink Exists"
    fi

    ls -la $HOME/Desktop
}

if  [ -f "$HOME/.bashrc" ]; then
    echo "Profile already exists. Will not copy default contents"
else
    echo "Profile Sync Directory Does Not Exist. No Sync will occur"
    copy_default_profile_to_home
fi

verify_profile_config

rm -rf $HOME/.config/pulse

# unknown option ==> call command
echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
echo "Executing command: '$@'"
exec "$@"
