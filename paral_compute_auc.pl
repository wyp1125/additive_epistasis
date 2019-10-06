@a=("AFR","AMR","EAS","EUR","SAS");
for($i=0;$i<4;$i++)
{
for($j=$i+1;$j<5;$j++)
{
$cmd="python compute_epi_AUC.py epi/$a[$i]_$a[$j].epi.epi.txt epi/$a[$i]_$a[$j].epi.out.txt";
#print $cmd,"\n";
$b=`$cmd`;
chomp($b);
$x=int(1000*$b+0.5)/1000;
print "$a[$i]\t$a[$j]\t$x\n";
}
}

