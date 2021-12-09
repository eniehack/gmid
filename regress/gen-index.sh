#!/bin/sh

val() {
	awk -F = '{print $2}'
}

fmtdate() {
	year="$(date +%g)"
	month="$(date +%m)"

	printf "%s" $((year+1))
	printf "%s" $month
	awk '
		// { printf("%s:%sZ", $2, $3) }
' | sed 's/://g'
}

date="$(openssl x509 -noout -in valid.crt -enddate | val | fmtdate)"
serial="$(openssl x509 -noout -in valid.crt -serial | val)"

printf "V\t%s\t\t%s\tunknown\t%s\n" "$date" "$serial" "/CN=valid"
