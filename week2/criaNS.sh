#!/bin/bash

brctl addbr v-net-0
ip link set dev v-net-0 up
ip addr add 192.168.15.5/24 dev v-net-0
ip link set v-net-0 up

cont=10

for i in `echo "green yellow red blue black white"`; do
	echo "[$i] Criando Namespace..."
	ip netns add $i
	echo "[$i] Criando interface pair..."
	ip link add veth-$i type veth peer name veth-$i-br
	echo "[$i] Colocando a VETH no Namespace correspondente..."
	ip link set veth-$i netns $i
	echo "[$i] Conectando a interface na bridge..."
	ip link set veth-$i-br master v-net-0
	echo "[$i] Subindo a interface da bridge..."
	ip link set veth-$i-br up
	echo "[$i] Adicionando IP na interface..."
	ip -n $i addr add 192.168.15.$cont/24 dev veth-$i
	echo "[$i] Subindo a interface..."
	ip -n $i link set veth-$i up
	echo "[$i] Adicionando rota default..."
	ip netns exec $i ip route add default via 192.168.15.5 dev veth-$i
	cont=$(($cont+1))
done
