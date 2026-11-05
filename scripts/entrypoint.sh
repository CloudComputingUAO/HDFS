#!/usr/bin/env bash
set -euo pipefail

role="${1:-}"

case "$role" in
  namenode)
    if [[ ! -f /data/name/current/VERSION ]]; then
      if [[ -n "$(find /data/name -mindepth 1 -maxdepth 1 -print -quit)" ]]; then
        echo "NameNode directory is not empty but has no VERSION file. Refusing to format." >&2
        exit 1
      fi
      hdfs namenode -format -nonInteractive
    fi
    exec hdfs namenode
    ;;
  datanode)
    exec hdfs datanode
    ;;
  client)
    exec tail -f /dev/null
    ;;
  *)
    exec "$@"
    ;;
esac
