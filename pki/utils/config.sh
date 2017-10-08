#!/bin/sh
#
# Assumptions: easyrsa3 available in current dir, and functional openssl.
# This basic example puts the "offline" and "sub" PKI dirs on the same system.
# A real-world setup would use different systems and transport the public components.

# Build root CA:
EASYRSA_PKI=pki/offline ./easyrsa init-pki
EASYRSA_PKI=pki/offline ./easyrsa build-ca nopass

# Build sub-CA request:
EASYRSA_PKI=pki/sign ./easyrsa init-pki
EASYRSA_PKI=pki/sign ./easyrsa build-ca nopass subca

# Import the sub-CA request under the short-name "sub" on the offline PKI:
EASYRSA_PKI=pki/offline ./easyrsa import-req pki/sign/reqs/ca.req sub
# Then sign it as a CA:
EASYRSA_PKI=pki/offline ./easyrsa sign-req ca sub
# Transport sub-CA cert to sub PKI:
cp pki/offline/issued/sub.crt pki/sign/ca.crt

mkdir -p pki/publish/
cp pki/sign/ca.crt pki/publish/ca.crt