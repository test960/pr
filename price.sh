mkdir -p termekAr
cd termekAr
echo "Termék paramétereinek letöltése és feldolgozása"
wget -O Price.txt https://www.arukereso.hu/mitas/100-90-19-c16-57m-p472500843/
grep -o "itemprop=\"price\" content=\"[[:digit:]]*\"" Price.txt > Temp.txt
grep -o "[[:digit:]]*" Temp.txt > toSell.txt
rm -r Price.txt
rm -r Temp.txt

input="./toSell.txt"
max=0
while IFS= read -r line
do
    (( line > max )) && max=$line
done < "$input"

min=max
osszeg=0
db=0
while IFS= read -r line
do
    osszeg=$((osszeg+line))
    ((line < min )) && min=$line
    db=$((db+1))
done < "$input"
echo "
Legdrágább: $max Ft
Legolcsóbb: $min Ft
Az ideális ár: $((osszeg/db)) Ft" >> toSell.txt

echo "Az adatok a \"toSell.txt\" fájlban találhatóak!
Fájl megnyitása!"
xdg-open toSell.txt
rm -r max