#harden alpine
# Remove existing crontabs, if any.
rm -fr /var/spool/cron && rm -fr /etc/crontabs && rm -fr /etc/periodic

# Remove all but a handful of admin commands.
find /sbin /usr/sbin ! -type d -a ! -name nologin,chmod, -delete

# Remove world-writable permissions.
# This no longer breaks apps that need to write to /tmp,
# such as ssh-agent.
find / -xdev -type d -perm +0002 ! -name tmp -exec chmod o-w {} + && find / -xdev -type f -perm +0002 ! -name tmp -exec chmod o-w {} +
