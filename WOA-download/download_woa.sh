#! /bin/sh

# Download all data products (from 00-16)
for i in $(seq -f '%02g' 00 16)
do
   # Download data (adjust URL for other products - note the use of ${i}) 
   wget -N -nH -nd -r -e robots=off --no-parent --force-html -A.nc https://www.ncei.noaa.gov/thredds-ocean/fileServer/ncei/woa/oxygen/all/1.00/woa18_all_o${i}_01.nc
done
