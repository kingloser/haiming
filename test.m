
fs=1000;%采样频率为1000Hz
N=1024;
n=0:N-1;
t=n/fs;
f1=100;f2=120;
x=sin(2*pi*f1*t);
figure(1);
plot(t,x);title('origenal');
grid;
y=fft(x,N);%傅里叶变换
mag=abs(y);
f=(0:length(y)-1)'*fs/length(y);
figure(2);
plot(f(1:N/2),mag(1:N/2));%绘制频谱图
title('with noise');
grid;
