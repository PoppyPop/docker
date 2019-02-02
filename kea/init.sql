https://kea.isc.org/wiki/HostReservationsHowTo

Test:
INSERT INTO hosts (dhcp_identifier,
                   dhcp_identifier_type,
                   ipv4_address,
                   hostname, dhcp4_subnet_id)
VALUES (UNHEX(REPLACE('00:0C:29:EB:26:60', ':', '')),
	(SELECT type FROM host_identifier_type WHERE name='hw-address'),
        INET_ATON('10.0.0.23'),
        'alpine', 1);


INSERT INTO hosts (dhcp_identifier,
                   dhcp_identifier_type,
                   ipv4_address,
                   hostname, dhcp4_subnet_id)
VALUES (UNHEX(REPLACE('00:22:4d:a3:cb:70', ':', '')),
	(SELECT type FROM host_identifier_type WHERE name='hw-address'),
        INET_ATON('10.0.0.50'),
        'domo1', 1);

		
INSERT INTO hosts (dhcp_identifier,
                   dhcp_identifier_type,
                   ipv4_address,
                   hostname, dhcp4_subnet_id)
VALUES (UNHEX(REPLACE('00:11:32:26:A6:D5', ':', '')),
	(SELECT type FROM host_identifier_type WHERE name='hw-address'),
		(SELECT ('10.0.1.5'::inet - '0.0.0.0'::inet)),
        'esp-wifi', 1);


