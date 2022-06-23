# Sync global pull secret on the cluster

:warning: The daemonset will execute a script which updates the Docker config on each worker nodes for the global pull secret to take effect without restarting the worker nodes.  When updating a global pull secret on the OpenShift cluster, the nodes will be restarted automatically and the proper path.