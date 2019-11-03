# xpep-kata
This deployment has been tested on CentOs 7.

Configure file setup.cfg, only parameters taken into account at the moment are ALLOCATED_CPU and ALLOCATED_RAM, that describe the resources that you want to allocate for minikube cluster.

Pull file prepare_environment.sh on your host and place it in a working directory.
Execute it as root.
If step /usr/lib/virtualbox/vboxdrv.sh setup fails:
reboot system --> choose update kernel --> rerun the step manually with root permissions.
Execute xpep-kata/minikube_start.sh not root
Execute xpep-kata/deploy_cluster.sh not root
Execute xpep-kata/logging_solution.sh not root
Execute xpep-kata/start_monitor.sh not root

Please note, if you want to delete the working directory, please save files contained in the directory logscript wherever you prefer and then edit you crontab so that it triggers raise_alert.sh in it's new location.
