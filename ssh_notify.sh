#!/bin/sh

# Simple script to send notification to mobile number on TELE2 LV network
# Add scipt on host and add following line to
# /etc/pam.d/sshd
# session optional pam_exec.so seteuid /path/to/ssh_notify.sh


# Change these two lines:
#sender="sender-address@example.com"
recepient="00000000000@sms.tele2.lv"

if [ "$PAM_TYPE" != "close_session" ]; then
    host="`hostname`"
    subject="SSH Login to $host"
    # Message to send, e.g. the current environment variables.
    message="`env`"
    echo "[$(date +'%d/%m/%Y %H:%M:%S')]: User $PAM_USER logged to $host from $PAM_RHOST" | mail -s "$subject" "$recepient"
fi