if [ -f "already_ran" ]; then
    # pass
    echo "Already ran the Entrypoint once. Holding indefinitely for debugging.";
else
    echo dimage:$PASSWORD | sudo chpasswd;
fi

sudo touch already_ran;
sudo service ssh start;

