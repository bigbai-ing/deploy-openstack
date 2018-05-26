#!/bin/bash
#放开相关安全组

neutron security-group-rule-create --direction egress --ethertype IPv4 --protocol udp --port-range-min 1 --port-range-max 65535 --remote-ip-prefix 0.0.0.0/0 <安全组id>
