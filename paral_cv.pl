@a=("sim.epi.txt","sim.epi.0.25.txt","sim.epi.0.5.txt","sim.epi.1.txt","sim.epi.2.txt","sim.epi.5.txt","sim.epi.10.txt");
for($i=0;$i<7;$i++)
{
  $cmd="python3 make_cv.py noise_epi/$a[$i] noise_epi/sim.out.txt cv/sim.$i 5";
  print $cmd,"\n";
  system("$cmd");
}
