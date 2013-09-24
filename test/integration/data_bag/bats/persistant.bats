#!/usr/bin/env bats

@test "redis should be running" {
  [ "$(ps aux | grep redi[s])" ]
}

@test "redis should start on boot" {
  [ "if 'uname -a | awk {'print $4'} | cut -d "-" -f 2' == Ubuntu; then ls -l /etc/init.d/redis-memory ; elso $(chkconfig --list redis-memory | grep 3:on); fi" ]
}

@test "redis should be listening on port 8000" {
  [ "$(netstat -plant | grep redis | grep 8000)" ]
}

@test "the config file should be in place" {
  [ -f /etc/redis/persistant.conf ]
}

@test "the redis user should be there" {
  [ "$(grep ^redis /etc/passwd)" ]
}

@test "the log directory should be there" {
  [ -d /var/log/redis ]
  [ -f /var/log/redis/persistant.log ]
}
