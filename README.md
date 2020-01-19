<<<<<<< HEAD
# Compton

[![Join the chat at https://gitter.im/chjj/compton](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/chjj/compton?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

__Compton__ is a compositor for X, and a fork of __xcompmgr-dana__.

This branch includes a new blur method: The multi-pass **dual kawase blur**!
Use it with the `--blur-method kawase` and `--blur-strength LEVEL` options.
Only works with the `glx` backend!

I was frustrated by the low amount of standalone lightweight compositors.
Compton was forked from Dana Jansens' fork of xcompmgr and refactored.  I fixed
whatever bug I found, and added features I wanted. Things seem stable, but don't
quote me on it. I will most likely be actively working on this until I get the
features I want. This is also a learning experience for me. That is, I'm
partially doing this out of a desire to learn Xlib.

## Changes from xcompmgr:

* OpenGL backend (`--backend glx`), in addition to the old X Render backend.
* Inactive window transparency (`-i`) / dimming (`--inactive-dim`).
* Titlebar/frame transparency (`-e`).
* Menu transparency (`-m`, thanks to Dana).
* shadows are now enabled for argb windows, e.g. terminals with transparency
* removed serverside shadows (and simple compositing) to clean the code,
  the only option that remains is clientside shadows
* configuration files (see the man page for more details)
* colored shadows (`--shadow-[red/green/blue]`)
* a new fade system
* VSync support (not always working)
* Blur of background of transparent windows, window color inversion (bad in performance)
* Some more options...

## Fixes from the original xcompmgr:

* fixed a segfault when opening certain window types
* fixed a memory leak caused by not freeing up shadows (from the freedesktop
  repo)
* fixed the conflict with chromium and similar windows
* [many more](https://github.com/chjj/compton/issues)

## Building

### Dependencies:

__B__ for build-time

__R__ for runtime

* libx11 (B,R)
* libxcomposite (B,R)
* libxdamage (B,R)
* libxfixes (B,R)
* libXext (B,R)
* libxrender (B,R)
* libXrandr (B,R)
* libXinerama (B,R) (Can be disabled with `NO_XINERAMA` at compile time)
* pkg-config (B)
* make (B)
* xproto / x11proto (B)
* sh (R)
* xprop,xwininfo / x11-utils (R)
* libpcre (B,R) (Can be disabled with `NO_REGEX_PCRE` at compile time)
* libconfig (B,R) (Can be disabled with `NO_LIBCONFIG` at compile time)
* libdrm (B) (Can be disabled with `NO_VSYNC_DRM` at compile time)
* libGL (B,R) (Can be disabled with `NO_VSYNC_OPENGL` at compile time)
* libdbus (B,R) (Can be disabled with `NO_DBUS` at compile time)
* asciidoc (B) (and docbook-xml-dtd-4.5, libxml-utils, libxslt, xsltproc, xmlto, etc. if your distro doesn't pull them in)

### How to build

To build, make sure you have the dependencies above:
=======
picom
=======
>>>>>>> f92eb6b05aa6bbe5da53cf27d652db2b6771e02c

**This is a development branch, bugs to be expected**

**[WIP] Merge-branch for the *dual_kawase* blur shader**

This branch includes a new blur method: The fast and good-looking *dual-filter kawase blur*! Use it with `--blur-method dual_kawase` and configure it with `--blur-strength LEVEL`. Only works with `--experimental-backends` and `--backend glx`!

This is forked from the original Compton because it seems to have become unmaintained.

The current battle plan of this fork is to refactor it to make the code _possible_ to maintain, so potential contributors won't be scared away when they take a look at the code.

We also try to fix bugs.

The original README can be found [here](README_orig.md)

## Call for testers

### `--experimental-backends`

This flag enables the refactored/partially rewritten backends.

Currently, new backends feature better vsync with the xrender backend and improved input lag with the glx backend (for non-NVIDIA users). The performance should be on par with the old backends.

New backend features will only be implemented on the new backends from now on, and the old backends will eventually be phased out after the new backends stabilize.

To test the new backends, add the `--experimental-backends` flag to the command you use to run picom. This flag is not available from the configuration file.

To report issues with the new backends, please state explicitly you are using the new backends in your report.

## Rename

### Rationale

Since the inception of this fork, the existence of two compton repositories has caused some number of confusions. Mainly, people will report issues of this fork to the original compton, or report issues of the original compton here. Later, when distros started packaging this fork of compton, some wanted to differentiate the newer compton from the older version. They found themselves having no choice but to invent a name for this fork. This is less than ideal since this has the potential to cause more confusions among users.

Therefore, we decided to move this fork to a new name. Personally, I consider this more than justified since this version of compton has gone through significant changes since it was forked.

### The name

The criteria for a good name were

0. Being short, so it's easy to remember.
1. Pronounceability, again, helps memorability
2. Searchability, so when people search the name, it's easy for them to find this repository.

Of course, choosing a name is never easy, and there is no apparent way to objectively evaluate the names. Yet, we have to solve the aforementioned problems as soon as possible.

In the end, we picked `picom` (a portmanteau of `pico` and `composite`) as our new name. This name might not be perfect, but is what we will move forward with unless there's a compelling reason not to.

### Migration

Following the [deprecation process](https://github.com/yshui/picom/issues/114), migration to the new name will be broken into 3 steps:

1. All mentions of `compton` will be updated to `picom` in the code base. `compton` will still be installed, but only as a symlink to `picom`. When `picom` is launched via the symlink, a warning message is printed, alerting the user to migrate. Similarly, the old configuration file names and dbus interface names will still be accepted but warned.
2. 3 major releases after step 1, the warning messages will be prompted to error messages and `picom` will not start when launched via the symlink.
3. 3 major releases after step 2, the symlink will be removed.

The dbus interface and service names are unchanged, so no migration needed for that.

## Change Log

See [Releases](https://github.com/yshui/picom/releases)

## Build

### Dependencies

Assuming you already have all the usual building tools installed (e.g. gcc, python, meson, ninja, etc.), you still need:

* libx11
* libx11-xcb
* libXext
* xproto
* xcb
* xcb-damage
* xcb-xfixes
* xcb-shape
* xcb-renderutil
* xcb-render
* xcb-randr
* xcb-composite
* xcb-image
* xcb-present
* xcb-xinerama
* pixman
* libdbus (optional, disable with the `-Ddbus=false` meson configure flag)
* libconfig (optional, disable with the `-Dconfig_file=false` meson configure flag)
* libxdg-basedir (optional, disable with the `-Dconfig_file=false` meson configure flag)
* libGL (optional, disable with the `-Dopengl=false` meson configure flag)
* libpcre (optional, disable with the `-Dregex=false` meson configure flag)
* libev
* uthash

On Debian based distributions (e.g. Ubuntu), the list of needed packages are

```
libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libxdg-basedir-dev libgl1-mesa-dev  libpcre2-dev  libevdev-dev uthash-dev libev-dev
```

To build the documents, you need `asciidoc`

### To build

```bash
$ git submodule update --init --recursive
$ meson --buildtype=release . build
$ ninja -C build
```

Built binary can be found in `build/src`

If you have libraries and/or headers installed at non-default location (e.g. under `/usr/local/`), you might need to tell meson about them, since meson doesn't look for dependencies there by default.

You can do that by setting the `CPPFLAGS` and `LDFLAGS` environment variables when running `meson`. Like this:

```bash
$ LDFLAGS="-L/path/to/libraries" CPPFLAGS="-I/path/to/headers" meson --buildtype=release . build

```

As an example, on FreeBSD, you might have to run meson with:
```bash
$ LDFLAGS="-L/usr/local/include" CPPFLAGS="-I/usr/local/include" meson --buildtype=release . build
$ ninja -C build
```

### To install

``` bash
$ ninja -C build install
```

Default install prefix is `/usr/local`, you can change it with `meson configure -Dprefix=<path> build`

## How to Contribute

### Code

You can look at the [Projects](https://github.com/yshui/picom/projects) page, and see if there is anything that interests you. Or you can take a look at the [Issues](https://github.com/yshui/picom/issues).

### Non-code

Even if you don't want to contribute code, you can still contribute by compiling and running this branch, and report any issue you can find.

Contributions to the documents and wiki will also be appreciated.

## Contributors

See [CONTRIBUTORS](CONTRIBUTORS)
