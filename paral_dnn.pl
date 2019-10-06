for($i=0;$i<7;$i++)
{
  for($j=0;$j<5;$j++)
  {
    $cmd="python3 run_dnn_cv.py -x1 cv/sim.$i.$j.X.trn -y1 cv/sim.$i.$j.Y.trn -x2 cv/sim.$i.$j.X.tst -y2 cv/sim.$i.$j.Y.tst -l aucs/sim.$i.$j.log";
    print $cmd,"\n";
    system("$cmd");
  }
}
