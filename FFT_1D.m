clc,clear,close all;
T=1/15;                             %周期
fs=1000;                            %采样频率
dt=1/fs;                            %采样间隔
L=1000/fs;                          %采样长度
t=0:dt:L;                           %采样时间序列
N=length(t);                        %采样点数
df=fs/(N-1);                        %频率分辨率
f=t*fs*df-max(t*fs*df)/2;           %频率基数
x=2*sin(30*pi*t)+0.5*cos(120*pi*t)+4*sin(240*pi*t);%函数
subplot(231),plot(t(1:ceil(T/dt)),x(1:ceil(T/dt))),title('采样后的图像'),xlabel('t/s'),ylabel('幅度');
fx=fftshift(fft(x));               %傅里叶变换,并中心化
subplot(232),plot(f(:),abs(fx)),title('频谱中心化,幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');
subplot(233),plot(f(ceil(length(f)/2):length(f)),abs(fx(ceil(length(fx)/2):length(fx)))),title('有效频率范围,幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');

xNoise=x+2*randn(size(x));              %加随机噪声
subplot(234),plot(t(1:ceil(T/dt)),xNoise(1:ceil(T/dt))),title('(加噪声)采样后的图像'),xlabel('t/s'),ylabel('幅度');
fxNoise=fftshift(fft(xNoise));         %傅里叶变换,并中心化
subplot(235),plot(f(:),abs(fxNoise)),title('频谱中心化,(加噪声)幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');
subplot(236),plot(f(ceil(length(f)/2):length(f)),abs(fxNoise(ceil(length(fxNoise)/2):length(fxNoise)))),title('有效频率范围,(加噪声)幅值随频率变化的分布图'),xlabel('f/Hz'),ylabel('频谱分量');
set(gcf,'unit','normalized','position',[0,0,1.0,1.0]);%[0,0,1.0,1.0]表示左下角为原点,长和宽分别占屏幕的100%
saveas(gcf,strcat(mfilename,'_pic'),'jpg');           %以文件名加'_pic'为名保存文件