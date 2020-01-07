function total_test()
runnum=20;   %gp运行的次数

 for i=1:5  %5折
    GP(runnum,i,train_porp,train_rank,test_porp,test_rank,val_porp,val_rank);
 end
end