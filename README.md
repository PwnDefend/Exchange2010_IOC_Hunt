# Exchange2010_IOC_Hunt
a really quick and dirty PSH script to hunt for Havniar IOCs

This does a few things:
Check for all apspx files onthe sytem and hashes them. it's PSH 2.0 friendly.

If checks for aspx files on c:\ that have been created in the last 60 days

it reads paths and ips txt files

it searches every path for any txt or log files, it then searches the log files for occurances of the ip addresses
it will write out "IOC found" and the file name if it finds an IP in the txt or log files.

I will make this nicer but i wrote it on notepad on a vm and I'm hungry and need to eat! :P

use at own risk modify it to suit ur neeeds.

- mRr3b00t
