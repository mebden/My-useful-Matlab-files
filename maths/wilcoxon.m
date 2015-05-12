% Student's t test workhorse for slat.m
% March 2003
%
%LILLIETEST Single sample Lilliefors hypothesis test of composite normality.
%RANKSUM Wilcoxon rank sum test that two populations are identical.
%SIGNRANK Wilcoxon signed rank test of equality of medians.
%SIGNTEST Sign test.
%TTEST  Hypothesis test: Compares the sample average to a constant.
%TTEST2 Hypothesis test: Compares the averages of two samples.
%ZTEST  Hypothesis test: Compares the sample average to a constant.

for k = 1:size(ordinates,1), % Six to eight items to test (LF, HF, etc.)
   [H,P,STATS] = ranksum(series1(:,k), series2(:,k),.999);
   if H == 1,
      mean1 = mean(series1); mean2 = mean(series2);
%     P = round(P*1000)/1000;
      if P > 0.05,
          eval (['!echo . . . . ' ordinates(k,:) ' was ' num2str(mean1(k)) ' versus ' num2str(mean2(k)) ', p = ' num2str(P) '.']);
      else
          eval (['!echo o o o o ' ordinates(k,:) ' was ' num2str(mean1(k)) ' versus ' num2str(mean2(k)) ', p = ' num2str(P) '.']);
      end
      CI; STATS;
  end
end
!echo 



