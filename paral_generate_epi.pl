@a=("AFR","AMR","EAS","EUR","SAS");
for($i=0;$i<4;$i++)
{
for($j=$i+1;$j<5;$j++)
{
$cmd="python generate_epi.py gt/$a[$i]_$a[$j].gt epi/$a[$i]_$a[$j].epi 1";
print $cmd,"\n";
$b=`$cmd`;
}
}

