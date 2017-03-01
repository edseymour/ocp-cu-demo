# ocp-cu-demo
Scripts to automate oc cluster up to build an OpenShift Container Platform demo, with accompanying content.

By running the `ocp-cluster-up` script you will provision a new local copy of OpenShift using the `oc cluster up` command, configured with data persistence, persistent volumes, metrics, logging, Gogs, Nexus, and example projects with example code. 

## Prerequisites
This is designed to run in a Linux environment, although it should be possible to adapt for running on Windows and MacOSX. 
You're going to need a need a few things to get started:

* Your current user in sudoers and able to run docker, and other commands. 
* Docker installed
* OpenShift CLI installed - see https://docs.openshift.org/latest/cli_reference/get_started_cli.html
* Default location for persistence declared, export the environment variable `OCP_BASE` set to the full path of the directory. 
* Internet access

# Getting Started
Make sure you've completed the prerequisites, `git clone --recursive` this repo (the `--recursive` option is required as there are submodules), then to start do the following:

```
$ ./ocp-cluster-up
```
A new cluster will be created using the 'latest' OpenShift images. You can pass two parameters to this script, the first is the OpenShift Container Platform version, the 2nd an option to re-pull all OpenShift container images. For example:
```
$ ./ocp-cluster-up v3.4 --repull
```

Once the cluster is started, you will be logged in at the command line with an 'admin' user. You can switch to the default `oc cluster up` user `developer`, or to the new `demo` user created by the script.

The `demo` user has two projects:
* `monster-dev` - includes a template to automatically build and deploy the example JBoss EAP TicketMonster example application.
* `monster-uat` - includes a template to provision the image from `monster-dev` when tagged for promotion. 

### Clean up
If you would like to clear out the demo, and restart, run the following:
```
$ ./ocp-cluster-clean
```

