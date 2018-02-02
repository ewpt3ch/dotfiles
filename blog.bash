#!/bin/bash
#script to make blogging easier

#activate nikola
source ~/nikola/bin/activate

#create a new post
cd ~/myblog
nikola new_post -e

#build the new site
nikola build

#deploy
rsync -av --delete output/ ewpt3ch.com:/srv/http/ewpt3ch.com/blog/

#deactivate nikola
deactivate
