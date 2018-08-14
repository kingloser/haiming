clear all;
wp1=0.35*pi;
wp2=0.45*pi;
ws1=0.3*pi;
ws2=0.5*pi;
As=40;
figure(1)
tr_width=min((wp1-ws1),(ws2-wp2)); 					%过渡带宽度 
 M=ceil(11*pi/tr_width)+1							%滤波器长度
% ap=1;
% as=140;
% dp=1-10^(-ap/20);
% ds=10^(-as/20);
% 
% Numerator=-20*log10(sqrt(dp*ds))-13;
% Denominator =14.6*150/2/pi;
% N=ceil(Numerator/Denominator ); %kaiser法计算所需h（n）长度N0，ceil取大于等于
% 
% 
n=[0:1:M-1];
wc1=(ws1+wp1)/2;									%理想带通滤波器的下截止频率
wc2=(ws2+wp2)/2;									%理想带通滤波器的上截止频率
hd=ideal_lp(wc2,M)-ideal_lp(wc1,M);
w_bla=(hamming(M))';	    %汉明窗
[x,wn,bta,ftype]=kaiserord([0.3,0.35,0.45,0.5],[0 1 0],[0.01 0.1087 0.01]);

w_b=(hamming(x+1));
% hn = fir1(M, [0.325,0.475], 'bandpass', w_b,'scale');
 hn = fir1(x, [0.325,0.475], 'bandpass', w_b,'scale');
h=hd.*w_bla;  						%滤波器
[db,mag,pha,grd,w]=freqz_m(h,[1]);
%计算实际滤波器的幅度响应
delta_w=2*pi/1000;
Rp=-min(db(wp1/delta_w+1:1:wp2/delta_w))
%实际通带纹波
As=-round(max(db(ws2/delta_w+1:1:501)))
As=150

figure(14)
%subplot(2,2,2);
stem(n,w_bla);
title('海明窗w(n)')
subplot(2,2,1);
stem(n,hd);
title('理想单位脉冲响应hd(n)')
axis([0 M-1 -0.4 0.5]);
xlabel('n');
ylabel('hd(n)')
grid on;
figure(14)
%subplot(2,2,2);
stem(n,w_bla);
title('海明窗w(n)')


axis([0 M-1 0 1.1]);
xlabel('n');
ylabel('w(n)')
grid on;
subplot(2,2,3);
stem(n,h);
title('实际单位脉冲响应hd(n)')
axis([0 M-1 -0.4 0.5]);
xlabel('n');
ylabel('h(n)')
grid on;
subplot(2,2,4);
plot(w/pi,db);
axis([0 1 -150 10]);
title('幅度响应(dB)');
grid on;
xlabel('频率单位:pi');
ylabel('分贝数')

b=dfilt.df2(hn,1);
zplane(b)
title('零极点图')					%标注标题


%计算信号频谱，输出频谱图
fs=2000;N=300;%设置抽样点数为1024点
n=0:(N-1);
t=n/fs;
 f1=400,f2=550;
 x1=sin(2*pi*f1*t); 
x2=sin(2*pi*f2*t);
x=x1+x2;
y=filter(hn,1,x);
Y1=fft(x,N);
Y2=fft(y,N)
mag1=abs(Y1);mag2=abs(Y2);
figure(8);
plot(y);
f=n*fs/N;
figure(10);
%figure(5)
%subplot(2,1,1);
plot(f(1:N/2),mag1(1:N/2));
title('输入信号的频谱图');
xlabel('频率/HZ');ylabel('振幅');
grid on;
figure(11);
%subplot(2,1,2);
plot(f(1:N/2),mag2(1:N/2)); 
title('输出信号的频谱图');
xlabel('频率/HZ');ylabel('振幅');
grid on;


