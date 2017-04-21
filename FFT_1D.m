clc,clear,close all;
T=1/15;                             %周期
fs=1000;                            %采样频率
dt=1/fs;                            %采样间隔
L=1000/fs;                          %采样长度
t=0:dt:L;                           %采样时间序列
N=length(t);                        %采样点数
df=fs/(N-1);                        %分辨率
f=t*fs*df-max(t*fs*df)/2;           %频率基数
x=2*sin(30*pi*t)+0.5*cos(120*pi*t)+4*sin(240*pi*t);%函数
subplot(231),plot(t(1:ceil(T/dt)),x(1:ceil(T/dt))),title('采样后的图像'),xlabel('t/s'),ylabel('幅度');
fxx=fftshift(fft(x));               %傅里叶变换,并中心化
subplot(232),plot(f(:),abs(fxx)),title('频谱中心化,幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');
subplot(233),plot(f(ceil(length(f)/2):length(f)),abs(fxx(ceil(length(fxx)/2):length(fxx)))),title('有效频率范围,幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');

xx=x+2*randn(size(x));              %加随机噪声
subplot(234),plot(t(1:ceil(T/dt)),xx(1:ceil(T/dt))),title('(加噪声)采样后的图像'),xlabel('t/s'),ylabel('幅度');
noiseFFT=fftshift(fft(xx));         %傅里叶变换,并中心化
subplot(235),plot(f(:),abs(noiseFFT)),title('频谱中心化,(加噪声)幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');
subplot(236),plot(f(ceil(length(f)/2):length(f)),abs(noiseFFT(ceil(length(noiseFFT)/2):length(noiseFFT)))),title('有效频率范围,(加噪声)幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');
set(gcf,'unit','normalized','position',[0,0,1.0,1.0]);
saveas(gcf,strcat(mfilename,'_pic'),'jpg');