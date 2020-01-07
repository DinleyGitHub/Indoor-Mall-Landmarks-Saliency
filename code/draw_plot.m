
% 画图函数
function draw_plot(Proportion)
a=sort(Proportion(:,1));
b=sort(Proportion(:,2));
huatu(a);
huatu(b);
% 分布参数拟合
end



function huatu(all_salience)
[mu,sigma]=normfit(all_salience);
if isnormal(sort(all_salience),mu,sigma,0.05) % 判断是否服从正态分布
    gauss_tatal(sort(all_salience), sigma, mu);  % 真实全部显著度的高斯分布[标准差，期望]
else
    disp('不输出图像！');
end
end

% 判断是否服从正态分布
function a =isnormal(x,mu,sigma,alpha)
p = normcdf(x,mu,sigma);
[h1,~]=kstest(x,[x,p],alpha);
if h1==0
    disp('服从正态分布！');
    a=true;
else
    disp('不服从正态分布！');
    a=false;
end

end

% 画出分布图
function gauss_tatal(x, sig, mu)
figure;
y = gaussmf(x,[sig mu]);
[counts,centers] = hist(x, 4);
bar(centers, counts);
% bar(centers, counts / sum(counts));
hold on; %将两幅图画在同一幅图中
plot(x,y);
xlabel(['gaussmf, P=[','sig=',num2str(sig),'  mu=',num2str(mu),']']);

end