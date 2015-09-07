cd /usr/local/WowzaStreamingEngine/bin
if [ "$1" != "" ]; then
	./genkey.sh iphone  $1   http://wowza1-vod1.rhcloud.com/Xemphim/PlayerAuthenticationController
fi
mv $1.key /usr/local/WowzaStreamingEngine/keys