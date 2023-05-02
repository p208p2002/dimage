if [ -f "already_ran" ]; then
    # pass
    echo "Already ran the Entrypoint once. Holding indefinitely for debugging.";
else
    echo $USERNAME:$PASSWORD | sudo chpasswd;
fi

sudo touch already_ran;
sudo service ssh start;

