function curCostVec = evaluatePath(priorCostVec,rawCostVec,path_intensity_grad)
%curCostVec : contain the current Cost vector corresponding to the location
%of rawCostVec in the result costCuble
DISP_RANGE = length(priorCostVec);
P1 = 1;
P2 = 4;

curCostVec = zeros(DISP_RANGE,1);

for d=1:DISP_RANGE
    smooth_term = 1e20;
   for d_p = 1:DISP_RANGE
       if (d_p - d == 0)
         smooth_term = min([smooth_term; priorCostVec(d_p)] );
       elseif (abs(d_p - d) == 1)
           smooth_term = min([smooth_term; priorCostVec(d_p) + P1] );
       else
           smooth_term = min([smooth_term;...
                            priorCostVec(d_p)+ max([P1, path_intensity_grad ])...%? P2/path_intensity_grad:P2])] ...
                             ] ) ;%    [smooth_term;priorCostVec(d_p)+max([P1;max([P1,path_intensity_grad ? P2/path_intensity_grad:P2]) ]) );
     
       end
   end
   curCostVec(d) = rawCostVec(d) + smooth_term;
   
end
   curCostVec = curCostVec - min(priorCostVec);% ??  normalized by substractiong the minimum of prior cost

end