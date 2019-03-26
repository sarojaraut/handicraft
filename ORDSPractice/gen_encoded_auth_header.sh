#!/bin/bash

## DEV & TST
	username='ws_275020@Company.RiverIsland'

	password='Z72khzY4IgzN)EaRqC{[z?HvM'

	credentials="$(echo -n "$username:$password" | base64)"

	header="Authorization: Basic $credentials"

	## Echo Dev Encoded String
	echo "Dev Encoded String is :" $credentials
## DEV & TST

## PRD
	username='ws_970504@Company.RiverIsland'

	password='cs8c98sdvcds9vosdccsd'

	credentials="$(echo -n "$username:$password" | base64)"

	header="Authorization: Basic $credentials"

	## Echo PRD  Encoded String
	echo "PRD Encoded String is :" $credentials
## PRD


#echo d3NAQ29tcGFueS5SaXZlcklzbGFuZDpaNzJraHpZNElnek4pRWFScUN7W3o/SHZN | base64 --decode


ws@Company.RiverIsland
Z72khzY4IgzN)EaRqC{[z?HvM

ws_275020@Company.RiverIsland	Z72khzY4IgzN)EaRqC{[z?HvM



cms_oms_export_product.p_ins_upcs
cms_oms_export_product.p_ins_web_descr_change
cms_oms_export_product.p_ins_attr_change

cms_oms_export_product.p_ins_new_sku
cms_oms_export_product.p_enrich_attribute
cms_oms_export_product.p_export