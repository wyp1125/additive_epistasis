open(input,"chr20.info");
$of="$ARGV[0]_$ARGV[1].af";
open(output,">$ARGV[2]/$of");
print output "chr\tpos\trs\tref\talt\t$ARGV[0]\t$ARGV[1]\n";
while($line=<input>)
{
  $good=0;
  if($line=~/$ARGV[0]\_AF\=([\d\.]+)/)
  {
    $af1=$1;
    $good++;
  }
  if($line=~/$ARGV[1]\_AF\=([\d\.]+)/)
  {
    $af2=$1;
    $good++;
  }
  if($good==2 && $af1>=0.01 && $af2>=0.01 && $af1<0.5 && $af2<0.5)
  {
    @a=split("\t",$line);
    print output "$a[0]\t$a[1]\t$a[2]\t$a[3]\t$a[4]\t$af1\t$af2\n";
  }
}
