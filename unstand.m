clear all;
wp1=0.35*pi;
wp2=0.45*pi;
ws1=0.3*pi;
ws2=0.5*pi;
As=40;
figure(1);						%滤波器长度 还要确定滤波器阶数的方法
wc1=(ws1+wp1)/2;									%理想带通滤波器的下截止频率
wc2=(ws2+wp2)/2;									%理想带通滤波器的上截止频率
[x,wn,bta,ftype]=kaiserord([0.3,0.35,0.45,0.5],[0 1 0],[0.01 0.1087 0.01]);
w_b=(hamming(x+1));
 hn = fir1(x, [wc1/pi,wc2/pi], 'bandpass', w_b,'scale');% 创建滤波器
 figure(1);
 freqz(hn,1,200); %;
 figure(2)
zplane(hn);
title('零极点图')					%标注标题


%计算信号频谱，输出频谱图
fs=2000;N=100;%设置抽样点数为1024点
n=0:(N-1);
t=n/fs;
 f1=400,f2=550;
 x1=sin(2*pi*f1*t); 
x2=sin(2*pi*f2*t);
x=x1+x2;
Y1=fft(x,N);
%f=(0:length(abs(Y1)-1)'*fs/length(Y1)); %无用操作  
y3=fft(hn,N);
y=filter(hn,1,x);
Y2=fft(y,N);
mag1=abs(Y1);mag2=abs(Y2);
figure(3);
subplot(2,2,1);
title('输入函数x1');
plot(x1);
subplot(2,2,2);
title('输入函数x2');
plot(t/100,x2);

subplot(2,2,3);
title('输入函数x');
plot(x);
subplot(2,2,4);
title('输出信号');
grid on;
plot(y);


f=n*fs/N;
figure(4);
%figure(5)
subplot(2,1,1);
plot(f(1:N/2),mag1(1:N/2));
title('输入信号的频谱图');
xlabel('频率/HZ');ylabel('振幅');
grid on;
subplot(2,1,2);
plot(f(1:N/2),mag2(1:N/2)); 
title('输出信号的频谱图');
xlabel('频率/HZ');ylabel('振幅');
grid on;

