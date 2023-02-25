#!/bin/bash

dashes="----------------------------------------------------------------"
printf '| %-25s | %-25s | %-10s | %-10s | %-20s |\n' "Device" "DevicePart" "Speedgrade" "size" "Clock Period (Freq.)"
printf '|:%.25s |:%.25s |:%.10s:| %.10s:| %.20s:|\n' $dashes $dashes $dashes $dashes $dashes

for x in $( grep -H . tab_*/results.txt )
do
	read _ size device grade _ speed < <( echo "$x" | tr _/: ' ' )
	case "$device" in       
		xc7k) d="Xilinx Kintex-7T"          xl_device="xc7v585t-ffg1761-${grade}"    ;;          
		xc7v) d="Xilinx Virtex-7T"          xl_device="xc7k70t-fbg676-${grade}"      ;;          
		xcku) d="Xilinx Kintex UltraScale"  xl_device="xcku035-fbva676-${grade}-e"    ;;  
		xcvu) d="Xilinx Virtex UltraScale"   xl_device="xcvu065-ffvc1517-${grade}-e"    ;;  
		xckup) d="Xilinx Kintex UltraScale+" xl_device="xcku3p-ffva676-${grade}-e"    ;;
		xcvup) d="Xilinx Virtex UltraScale+" xl_device="xcvu3p-ffvc1517-${grade}-e"    ;;

	esac
	speedtxt=$( printf '%s.%s ns (%d MHz)' "${speed%?}" "${speed#?}" "$((10000 / speed))" )
	printf '| %-25s | %-25s | %-10s | %-10s | %20s |\n' "$d" "$xl_device" "-$grade" "$size" "$speedtxt"
done
