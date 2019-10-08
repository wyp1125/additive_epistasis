@a=("AFR","AMR","EAS","EUR","SAS");
for($i=0;$i<4;$i++)
{
for($j=$i+1;$j<5;$j++)
{
$cmd="python3 generate_epi.py gt/$a[$i]_$a[$j].gt epi/$a[$i]_$a[$j].epi 0";
print $cmd,"\n";
$b=`$cmd`;
$cmd="python3 generate_epi.py gt/$a[$i]_$a[$j].gt epi/$a[$j]_$a[$i].epi 1";
print $cmd,"\n";
$b=`$cmd`;
}
}

