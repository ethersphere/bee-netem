#!/usr/bin/env sh

trap 'echo "catched SIGTERM, exiting"' TERM

if [ -z "${NETEM_CMD}" ]; then
  echo "CMD env variable cannot be empty"
  exit 1
fi

if [ "${NETEM_CMD}" = "wifi" ]; then
  tc qdisc add dev eth0 root handle 1: netem delay 25ms 2ms distribution normal
  tc qdisc add dev eth0 parent 1:1 netem loss 0.2%
  echo "set delay 25ms and 0.2% loss"
elif [ "${NETEM_CMD}" = "4g" ]; then
  tc qdisc add dev eth0 root handle 1: netem delay 50ms 5ms distribution normal
  tc qdisc add dev eth0 parent 1:1 netem loss 0.5%
  echo "set delay 50ms and 0.5% loss"
elif [ "${NETEM_CMD}" = "uk-us" ]; then
  tc qdisc add dev eth0 root handle 1: netem delay 125ms 10ms distribution normal
  tc qdisc add dev eth0 parent 1:1 netem loss 0.2%
  echo "set delay 125ms and 0.2% loss"
elif [ "${NETEM_CMD}" = "uk-aus" ]; then
  tc qdisc add dev eth0 root handle 1: netem delay 275ms 20ms distribution normal
  tc qdisc add dev eth0 parent 1:1 netem loss 0.2%
  echo "set delay 275ms and 0.2% loss"
else
  tc qdisc add dev eth0 root netem ${NETEM_CMD}
  echo "set ${NETEM_CMD}"
fi

bee start --config=.bee.yaml &

wait
