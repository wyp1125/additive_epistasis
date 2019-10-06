if($#ARGV<1)
{
print "pop1 pop2\n";
exit;
}
%h=();
open(input,"integrated_call_samples_v3.20130502.ALL.panel");
$line=<input>;
while($line=<input>)
{
@a=split("\t",$line);
if($a[2] eq $ARGV[0])
{
$h{$a[0]}=0;
}
if($a[2] eq $ARGV[1])
{
$h{$a[0]}=1;
}
}
print scalar keys %h,"\n";
$fl="afs/$ARGV[0]_$ARGV[1].2.af";
open(input,"$fl");
%k=();
while($line=<input>)
{
@a=split("\t",$line);
$key="$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]";
$k{$key}=0;
}
print scalar keys %k,"\n";
open(output,">gt/$ARGV[0]_$ARGV[1].gt");
open(input,"ALL.chr20.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf");
while($line=<input>)
{
  if($line=~/^\#CHROM/)
  {
    chomp($line);
    @a=split("\t",$line);
    print output "rs_id";
    for($i=9;$i<=$#a;$i++)
    {
      if(exists $h{$a[$i]})
      {
        $t[$i-9]=$h{$a[$i]};
        print output "\t$h{$a[$i]}";
      }
      else
      {
        $t[$i-9]=-1;
      }
    }
    print output "\n";
  }
  if($line=~/^20/)
  {
    chomp($line);
    @a=split("\t",$line);
    $key="$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]";
    if(exists $k{$key})
    {
      if($a[2] ne "")
      {
        $oline="";
        $good=1;
        for($i=9;$i<=$#a;$i++)
        {
          if($t[$i]!=-1)
          {
            @b=split("\\|",$a[$i]);
            if($b[0] eq "." || $b[1] eq ".")
            {
              $good=0;
              last;
            }
            else
            {
              $x=$b[0]+$b[1];
              $oline=$oline."\t".$x;
            }
          }
        }
        if($good==1)
        {
          print output $a[2],$oline,"\n";
        }
      }
    }
  }
}
