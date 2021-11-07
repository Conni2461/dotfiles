#!/usr/bin/python

import subprocess
import time
import datetime
import sys
import notify2
import dbus

warn = int(sys.argv[1])


class Notifycation:
    def __init__(self):
        try:
            notify2.init("Calnotify")
            self.notify_off = False
        except dbus.exceptions.DBusException:
            print("Notification do not work")
            self.notify_off = True

    def send(self, event, icon=""):
        if not self.notify_off:
            notify2.Notification(event.time(), event.title, icon).show()


class Event:
    def __init__(self, start, end, title):
        self.start = start
        self.end = end
        self.title = title

        s = datetime.datetime.strptime(self.start, "%I:%M %p")
        s = s.strftime("%H:%M")

        self.calcstart = convert(s)

    def time(self):
        return self.start + " - " + self.end

    def __eq__(self, other):
        return (
            self.start == other.start
            and self.end == other.end
            and self.title == other.title
        )

    def __hash__(self):
        return hash((self.start, self.end, self.title))


def get(command):
    return subprocess.check_output(command).decode("utf-8")


def convert(t):
    # convert set time into a calculate- able time
    return [int(n) for n in t.split(":")]


def calc_diff(t_curr, t_event):
    # calculate time span
    diff_hr = (t_event[0] - t_curr[0]) * 60
    diff_m = t_event[1] - t_curr[1]
    return diff_hr + diff_m


notify = Notifycation()
done = set()
calformat = "{cancelled}{start-time} - {end-time}; {title}"
while True:
    currtime = convert(time.strftime("%H:%M"))
    events = [
        line.strip()
        for line in get(
            ["khal", "list", "today", "today", "--format", calformat]
        ).splitlines()
    ][1:]
    initial = set()

    # Parse Events
    for e in events:
        # Ignore All Day EVENTS
        if e.startswith("-"):
            continue

        # Ignore Cancelled events
        if "CANCELLED" in e:
            continue

        times = e.split("; ")[0]
        start = times.split(" - ")[0]
        end = times.split(" - ")[1]
        title = e.split("; ")[1]

        initial.add(Event(start, end, title))

    results = initial - done

    # Run notifications
    for e in results:
        if calc_diff(currtime, e.calcstart) <= warn:
            notify.send(e)
            done.add(e)

    time.sleep(30)
