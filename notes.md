# quick howto notes

 * `accessories` directory shall have `packer` install scripts for a Debian/Ubuntu system
 * `ubuntu`, `centos8-stream`, `rocky8`, `rhel8` and may be a few more directories will have one or more of the following files:
   * `*.hcl.new` - edited `.hcl` files (maintained like that to make it easier to merge with upstream)
   * `build.bash` - a script to build the appropriate image: `bash ./build.bash`
   * `prerequisites.sh` - a script to install build prerequisites on a Debian / Ubuntu system

 * to troubleshoot a redhat-alike image build :
   1. check the latest `packer.build.*.log` file - for example, make sure that the qemu process starts successfully and e.g. does not die due to lack of memory on the host system
   2. to verify that `boot_command` is passed correctly: 
      * uncomment `vnc_port_...` settings and adjust the port number if needed (for example, if the given port is already in use)
      * increase  `boot_wait` time to e.g. `1m`
      * when the build is started, open a vnc session to `localhost:vnc_port_...` after the console message ` Waiting ${boot_wait} for boot...` ;
      * when the console displays messages ` Connecting to VM via VNC (127.0.0.1:${vnc_port_...})` and ` Typing the boot commands over VNC...`, confirm that the typed characters appear and make an effect on the screen
   3. when packer displays the message ` Waiting for shutdown...`, start a telnet session to port 4321 - `telnet localhost 4321` to monitor the automated build
   4. if the build process is hang for too long and the serial port monitor at port `4321` shows no activity, connect to `qemu` `hmi` session at port `4322` and shut it down:
      * `telnet localhost 4322`
      * `(qemu) quit`
