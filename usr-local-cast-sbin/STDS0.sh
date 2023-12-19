#bin
#bash
# Make the root filesystem writable

        #Stop Cron (occasionally remounts root as RO - would be bad if it did this at the wrong time....)
       sudo cron.service stop > /dev/null 2>/dev/null &                   #Cron

        # Stop the DV Services
        sudo mmdvmhost.service stop > /dev/null 2>/dev/null &              # MMDVMHost Radio Service
        sudo systemctl stop castserial.service > /dev/null 2>/dev/null &
	sudo ircddbgateway.service stop > /dev/null 2>/dev/null &
	sudo timeserver.service stop > /dev/null 2>/dev/null &
	sudo pistar-watchdog.service stop > /dev/null 2>/dev/null &
	sudo pistar-remote.service stop > /dev/null 2>/dev/null &
	sudo ysfgateway.service stop > /dev/null 2>/dev/null &
	sudo ysf2dmr.service stop > /dev/null 2>/dev/null &
	sudo ysf2nxdn.service stop > /dev/null 2>/dev/null &
	sudo ysf2p25.service stop > /dev/null 2>/dev/null &
	sudo nxdn2dmr.service stop > /dev/null 2>/dev/null &
	sudo ysfparrot.service stop > /dev/null 2>/dev/null &
	sudo p25gateway.service stop > /dev/null 2>/dev/null &
	sudo p25parrot.service stop > /dev/null 2>/dev/null &
	sudo nxdngateway.service stop > /dev/null 2>/dev/null &
	sudo nxdnparrot.service stop > /dev/null 2>/dev/null &
	sudo dmr2ysf.service stop > /dev/null 2>/dev/null &
	sudo stop dmr2nxdn.service stop > /dev/null 2>/dev/null &
	sudo stop dmrgateway.service stop  > /dev/null 2>/dev/null &
	sudo dapnetgateway.service stop > /dev/null 2>/dev/null &
	sudo systemctl stop castserial.service > /dev/null 2>/dev/null &


sudo sed -i "/\[D-Star\]/,/\[/ s/Enable=.*$/Enable=0/1" /etc/mmdvmhost
sudo sed -i "/\[D-Star Network\]/,/\[/ s/Enable=.*$/Enable=0/1" /etc/mmdvmhost
sudo cast-reset


       sudo cron.service start > /dev/null 2>/dev/null &                   #Cron


        # start the DV Services
        sudo mmdvmhost.service start > /dev/null 2>/dev/null &              # MMDVMHost Ra$
        sudo ircddbgateway.service start > /dev/null 2>/dev/null &
        sudo timeserver.service start > /dev/null 2>/dev/null &
        sudo pistar-watchdog.service start > /dev/null 2>/dev/null &
        sudo pistar-remote.service start > /dev/null 2>/dev/null &
        sudo ysfgateway.service start > /dev/null 2>/dev/null &
        sudo ysf2dmr.service start > /dev/null 2>/dev/null &
        sudo ysf2nxdn.service start > /dev/null 2>/dev/null &
        sudo ysf2p25.service start > /dev/null 2>/dev/null &
        sudo nxdn2dmr.service start > /dev/null 2>/dev/null &
        sudo ysfparrot.service start > /dev/null 2>/dev/null &
        sudo p25gateway.service start > /dev/null 2>/dev/null &
        sudo p25parrot.service start > /dev/null 2>/dev/null &
        sudo nxdngateway.service start > /dev/null 2>/dev/null &
        sudo nxdnparrot.service start > /dev/null 2>/dev/null &
        sudo dmr2ysf.service start > /dev/null 2>/dev/null &
        sudo dmr2nxdn.service start > /dev/null 2>/dev/null &
        sudo dmrgateway.service start > /dev/null 2>/dev/null &
        sudo dapnetgateway.service start > /dev/null 2>/dev/null &
        sudo systemctl start castserial.service > /dev/null 2>/dev/null &
