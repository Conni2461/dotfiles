#!/bin/python

## Breaking changes:
# - Its a daemon now who keeps track of already sent notifications and only
#   resents a notification if the issue/pr received another update oh github.
# - Run that once and only when you start your PC. So no longer running inside
#   a cronjob.

## TODO:
# - Make sleep and how often the daemon checks upstream configurable
#   - How often
#     - Check every minute
#     - Check every 5 minutes
#     - Check every 10 minutes
#     - Check once per hour
#   - Sleep
#     - 10 seconds
#     - 1 minute
#     - 30 minutes
#     - 1 hour

import sys, os, time, atexit, signal
import requests
from pathlib import Path
import configparser
import notify2
import dbus
import datetime


class Daemon:
    """
    A generic daemon class.
    Usage: subclass the daemon class and override the run() method.
    """
    def __init__(self, pidfile):
        self.pidfile = pidfile

    def daemonize(self):
        """
        Deamonize class. UNIX double fork mechanism.
        """

        try:
            pid = os.fork()
            if pid > 0:
                # exit first parent
                sys.exit(0)
        except OSError as err:
            sys.stderr.write('fork #1 failed: {0}\n'.format(err))
            sys.exit(1)

        # decouple from parent environment
        os.chdir('/')
        os.setsid()
        os.umask(0)

        # do second fork
        try:
            pid = os.fork()
            if pid > 0:

                # exit from second parent
                sys.exit(0)
        except OSError as err:
            sys.stderr.write('fork #2 failed: {0}\n'.format(err))
            sys.exit(1)

        # redirect standard file descriptors
        sys.stdout.flush()
        sys.stderr.flush()
        si = open(os.devnull, 'r')
        so = open(os.devnull, 'a+')
        se = open(os.devnull, 'a+')

        os.dup2(si.fileno(), sys.stdin.fileno())
        os.dup2(so.fileno(), sys.stdout.fileno())
        os.dup2(se.fileno(), sys.stderr.fileno())

        # write pidfile
        atexit.register(self.delpid)

        pid = str(os.getpid())
        with open(self.pidfile, 'w+') as f:
            f.write(pid + '\n')

    def delpid(self):
        os.remove(self.pidfile)

    def start(self):
        """Start the daemon."""

        # Check for a pidfile to see if the daemon already runs
        try:
            with open(self.pidfile, 'r') as pf:

                pid = int(pf.read().strip())
        except IOError:
            pid = None

        if pid:
            message = "pidfile {0} already exist. " + \
              "Daemon already running?\n"
            sys.stderr.write(message.format(self.pidfile))
            sys.exit(1)

        # Start the daemon
        self.daemonize()
        self.run()

    def stop(self):
        """Stop the daemon."""

        # Get the pid from the pidfile
        try:
            with open(self.pidfile, 'r') as pf:
                pid = int(pf.read().strip())
        except IOError:
            pid = None

        if not pid:
            message = "pidfile {0} does not exist. " + \
              "Daemon not running?\n"
            sys.stderr.write(message.format(self.pidfile))
            return  # not an error in a restart

        # Try killing the daemon process
        try:
            while 1:
                os.kill(pid, signal.SIGTERM)
                time.sleep(0.1)
        except OSError as err:
            e = str(err.args)
            if e.find("No such process") > 0:
                if os.path.exists(self.pidfile):
                    os.remove(self.pidfile)
            else:
                print(str(err.args))
                sys.exit(1)

    def restart(self):
        """Restart the daemon."""
        self.stop()
        self.start()

    def run(self):
        """You should override this method when you subclass Daemon.
        It will be called after the process has been daemonized by
        start() or restart()."""


class Notifycation():
    def __init__(self):
        try:
            notify2.init("Github-notify")
            self.notify_off = False
        except dbus.exceptions.DBusException:
            print("Notification do not work")
            self.notify_off = True

    def send(self, gh_type, repo, title, icon=""):
        l_owner = repo.split("/")[0]
        l_repo = repo.split("/")[1]
        content = "{}/<b>{}</b>\n{}".format(l_owner, l_repo, title)
        if not self.notify_off:
            notify2.Notification(gh_type, content, icon).show()


def handle_request(data, cache, n):
    for element in data:
        n_id = element["id"]
        if n_id in cache and cache[n_id] == element["updated_at"]:
            continue
        else:
            cache[n_id] = element["updated_at"]

        gh_type = element["subject"]["type"]
        repo = element["repository"]["full_name"]
        title = element["subject"]["title"]
        n.send(gh_type, repo, title)


def get_val_of_default(config, key, default):
    if key in config['DEFAULT']:
        return config['DEFAULT'][key]
    else:
        return default

URL = "https://api.github.com/notifications"

# Settings
# Read in config file
# Location: ~/.config/github-notify.conf
# Config file structure
#
# [DEFAULT]
# token = <token>
# sleep = 60
# every = 5
#
class Gh_notify_Daemon(Daemon):
    def run(self):
        notify = Notifycation()

        config = configparser.ConfigParser()
        config.read(str(Path.home()) + "/.config/github-notify.conf")

        cache = dict()

        try:
            token = config['DEFAULT']['token']
            sleep_time = int(get_val_of_default(config, 'sleep', 60))
            every = int(get_val_of_default(config, 'every', 10))
            headers = {"Authorization": "token " + token}
        except Exception:
            print("Config file not found")
            sys.exit()

        while True:
            now = datetime.datetime.now()
            if (now.minute % every) == 0:
                handle_request(
                    requests.get(URL, headers=headers).json(), cache, notify)

            time.sleep(sleep_time)


if __name__ == '__main__':
    daemon = Gh_notify_Daemon('/tmp/gh_notify_daemon.pid')
    if len(sys.argv) == 2:
        if 'start' == sys.argv[1]:
            print("starting daemon")
            daemon.start()
        elif 'stop' == sys.argv[1]:
            print("stopping daemon")
            daemon.stop()
        elif 'restart' == sys.argv[1]:
            print("restarting daemon")
            daemon.restart()
        else:
            print("Unknown command")
            sys.exit(2)
        sys.exit(0)
    else:
        print("usage: {} start|stop|restart".format(sys.argv[0]))
        sys.exit(2)
