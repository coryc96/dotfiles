
#!/bin/bash
export rdp_file="/home/${USER}/Downloads/Pub-RDPproxy*"
#sed -i 's/audiocapturemode:i:0/audiocapturemode:i:1/' $file
export file="/home/${USER}/.local/share/remmina/*myrdp-publix*"
startup_path=$(awk -F ':' '/shell working directory/ {print $NF}' $rdp_file)
load_balancer=$(awk -F ':' '/loadbalanceinfo/ {print $NF}' $rdp_file)
sed -i "s/execpath=.*/execpath=${startup_path}/" $file
sed -i "s/loadbalanceinfo=.*/loadbalanceinfo=${load_balancer}/" $file
remmina -c $file
#flatpak run org.remmina.Remmina -c $file
rm $rdp_file
