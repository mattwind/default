My really simple default linux setup, in just two commands!

### Step 1) Post setup

Run this after a vanilla debian net install. It will grab all the wanted [packages](https://github.com/mattwind/default/blob/master/apt/packages.list)

```su -c "wget https://raw.github.com/mattwind/default/master/post.sh -O /tmp/s; bash /tmp/s `whoami`"```

Once this is done setting up the packages and updates it will reboot.

### Step 2) Customize it

Configure all the custom stuff!

```wget -q -O - https://raw.github.com/mattwind/default/master/customize.sh | bash```

### Screenshot

![alt tag](screenshot.png)

### Todo

* Setup NFO repository
* Setup dynamic SSH directory
* Add keepass
* Add custom scripts
