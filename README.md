My really simple default linux setup, in just two commands!

### Step 1) Post setup

Run this after a vanilla debian net install. It will grab all the wanted [packages](https://github.com/mattwind/default/blob/master/apt/packages.list)

```su -c "wget https://raw.github.com/mattwind/default/master/post-setup.sh -O /tmp/s; bash /tmp/s `whoami`"```

### Step 2) Customize it

Configure all the neat stuff

```wget -q -O - https://raw.github.com/mattwind/default/master/customize.sh | bash```

### Screenshot

![alt tag](screenshot.png)

### Todo

* Setup NFO Repository
* Setup dynamic SSH directory
* Add keepass
* Add custom scripts
