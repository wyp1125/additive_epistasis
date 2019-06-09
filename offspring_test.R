generate_gt<-function(gt1,gt2)
{
  gtn=gt1
  nn=length(gt1)
  for(ii in 1:nn)
  {
    sum_gt=gt1[ii]+gt2[ii]
    if(sum_gt==0)
    {
      gtn[ii]=0
    }
    else if(sum_gt==4)
    {
      gtn[ii]=2
    }
    else if(sum_gt==1)
    {
      gtn[ii]=floor(runif(1,0,2))
    }
    else if(sum_gt==3)
    {
      gtn[ii]=floor(runif(1,0,2)+1)
    }
    else
    {
      prd_gt=gt1[ii]*gt2[ii]
      if(prd_gt==0)
      {
        gtn[ii]=1
      }
      else
      {
        tmp=runif(1)
        val=0
        if(tmp>=0.25)
        {
          val=1
        }
        if(tmp>=0.75)
        {
          val=2
        }
        gtn[ii]=val
      }
    }
  }
  return(gtn)
}
n_indv=1000
n_loci=2000
n_samp=n_indv/2
n_epis=2
n_rept=2000
maf_high=0.5
maf_low=0.01
gt_cntl=array(0,dim=c(n_samp,n_loci))
for(i in 1:(n_loci/n_epis))
{ 
  maf=runif(n_epis,maf_low,maf_high)   
  tmp_gt=array(0,dim=c(n_samp,n_epis))
  for(j in 1:n_epis)
  {
    prob_nt1=runif(n_samp)
    prob_nt2=runif(n_samp)
    for(k in 1:n_samp)
    {
      tmp_nt1=0
      tmp_nt2=0
      if(prob_nt1[k]<=maf[j])
      {
        tmp_nt1=1
      }
      if(prob_nt2[k]<=maf[j])
      {
        tmp_nt2=1
      }
      tmp_gt[k,j]=tmp_nt1+tmp_nt2
    }
  }
  saved_cntl_gt=tmp_gt
  gt_cntl[,(((i-1)*n_epis+1):(i*n_epis))]=saved_cntl_gt 
}
gt_ofs2=array(0,dim=c(n_samp,n_loci))
for(i in 1:n_samp)
{
  sel=floor(runif(2)*n_samp)+1
  gt_ofs2[i,]=generate_gt(gt_cntl[sel[1],],gt_cntl[sel[2],])
}

epi_cntl=array(0,dim=c(n_samp,(n_loci/n_epis)))
epi_ofs2=array(0,dim=c(n_samp,(n_loci/n_epis)))

for(i in 1:n_samp)
{
  for(j in 1:(n_loci/n_epis))
  {
    inc_cntl=1
    inc_ofs2=1
    for(k in 1:n_epis)
    {
      fac_cntl=0
      fac_ofs2=0
      if(gt_cntl[i,(j-1)*n_epis+k]==2)
      {
        fac_cntl=1
      }
      inc_cntl=inc_cntl*fac_cntl
      if(gt_ofs2[i,(j-1)*n_epis+k]==2)
      {
        fac_ofs2=1
      }
      inc_ofs2=inc_ofs2*fac_ofs2
    }
    epi_cntl[i,j]=inc_cntl
    epi_ofs2[i,j]=inc_ofs2
  }
}
yy1=apply(epi_cntl,1,sum)
yy2=apply(epi_ofs2,1,sum)