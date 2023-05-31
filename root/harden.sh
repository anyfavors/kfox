#harden alpine
# Remove existing crontabs, if any.
rm -fr /var/spool/cron && rm -fr /etc/crontabs && rm -fr /etc/periodic

# Remove all but a handful of admin commands.
find /sbin /usr/sbin ! -type d -a ! \( -name nologin -o -name chmod -o -name nginx -o -name groupmod -o -name usermod \) -delete

# Remove world-writable permissions.
# This no longer breaks apps that need to write to /tmp,
# such as ssh-agent.
find / -xdev -type d -perm +0002 ! -name tmp -exec chmod o-w {} + && find / -xdev -type f -perm +0002 ! -name tmp -exec chmod o-w {} +


# Remove unnecessary user accounts.
sed -i -r '/^(kasm-user|root|dockremap|messagebus|nginx|abc)/!d' /etc/group
sed -i -r '/^(kasm-user|root|dockremap|messagebus|nginx|abc)/!d' /etc/passwd

# Remove interactive login shell for everybody but user.
sed -i -r '/^abc:/! s#^(.*):[^:]*$#\1:/sbin/nologin#' /etc/passwd

sysdirs="
  /bin
  /etc
  /lib
  /sbin
  /usr
"

# Remove apk configs.
find $sysdirs -xdev -regex '.*apk.*' -exec rm -fr {} +

# Remove crufty...
#   /etc/shadow-
#   /etc/passwd-
#   /etc/group-
find $sysdirs -xdev -type f -regex '.*-$' -exec rm -f {} +

# Ensure system dirs are owned by root and not writable by anybody else.
find $sysdirs -xdev -type d \
  -exec chown root:root {} \; \
  -exec chmod 0755 {} \;

# Remove all suid files.
find $sysdirs -xdev -type f -a -perm +4000 -delete


