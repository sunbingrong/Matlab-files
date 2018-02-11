function [T,PXX,TPXX]=cal_fft(data_in)
% cal_fft   calculate fft of time series
%================================================================
% cal_fft  Date: 2010/12/5 14:00
%           Copyright (C) zhchen
%
% USAGE:  [T,Pxx,Tpxx]=cal_fft(data_in)
%---------------------------------------------------------------
%-----     data_in should be a Nx1 array
%-----     T: period
%-----     Pxx: power
%-----     Tpxx: Mx3 array, 95%, 99%, 90% confidence level


%----------------1. prepare the data

%---detrend
data_in=xxhg(data_in);

N=length(data_in);M=floor(N/3);

SGAMA=(2*N-M/2)/M;       % sgama=7.5   卡帕分布(x2)分布 (p443)
FF(1) =14.787/SGAMA;     %a=0.05   95 % 根据自由度的值查卡帕分布得14.787
FF(2) =19.2825/SGAMA;    %a=0.01   99 % 根据自由度的值查卡帕分布得19.2825
FF(3) =12.689/SGAMA;     %a=0.1    90 % 根据自由度的值查卡帕分布得12.689

XX=data_in;  % input time serial
X=XX(1:N,1);

TAL=mean(X);
Y=X-TAL;

%------ Drelation  求自相关,协方差
%---Rxx
A=X;B=X;
A=A-mean(A);B=B-mean(B);
SN=N;
for K=0:M
    SK=K;
    SY=0;
    SX=0;
    U=0;
    for I=1:N-K
        U=U+A(I)*B(I+K);
    end
    for I=1:N
        SX=SX+A(I)^2;
        SY=SY+B(I)^2;
    end
    RXX(K+1)=U/(sqrt(SX/SN)*sqrt(SY/SN)*(SN-SK));
end
%---Ryy
A=Y;B=Y;
A=A-mean(A);B=B-mean(B);
SN=N;
for K=0:M
    SK=K;
    SY=0;
    SX=0;
    U=0;
    for I=1:N-K
        U=U+A(I)*B(I+K);
    end
    for I=1:N
        SX=SX+A(I)^2;
        SY=SY+B(I)^2;
    end
    RYY(K+1)=U/(sqrt(SX/SN)*sqrt(SY/SN)*(SN-SK));
end
%---Rxy
A=X;B=Y;
A=A-mean(A);B=B-mean(B);
SN=N;
for K=0:M
    SK=K;
    SY=0;
    SX=0;
    U=0;
    for I=1:N-K
        U=U+A(I)*B(I+K);
    end
    for I=1:N
        SX=SX+A(I)^2;
        SY=SY+B(I)^2;
    end
    RXY(K+1)=U/(sqrt(SX/SN)*sqrt(SY/SN)*(SN-SK));
end
%---Ryx
A=Y;B=X;
A=A-mean(A);B=B-mean(B);
SN=N;
for K=0:M
    SK=K;
    SY=0;
    SX=0;
    U=0;
    for I=1:N-K
        U=U+A(I)*B(I+K);
    end
    for I=1:N
        SX=SX+A(I)^2;
        SY=SY+B(I)^2;
    end
    RYX(K+1)=U/(sqrt(SX/SN)*sqrt(SY/SN)*(SN-SK));
end
display(['RXY=',num2str(RXY(1))]);
display(['RYX=',num2str(RYX(1))]);

%-------------
for I=0:M
    TUM = 0.0;
    TOM = 0.0;
    TUM1 = 0.0;
    TOM1 = 0.0;
    for K=1:M-1
        TU=(1.0+cos(K*pi/M))*cos(K*pi*I/M); %书311页9.32式
        T1=(1.0+cos(K*pi/M))*sin(K*pi*I/M);
        TUM =TUM + (RXY(K+1) + RYX(K+1)) * TU;
        TOM =TOM + (RXY(K+1) - RYX(K+1)) * T1;
        TUM1 = TUM1 + RXX(K+1) * TU;
        TOM1 = TOM1 + RYY(K+1) * TU;
    end
    PXY(I+1) = (RXY(1) + TUM / 2.) / M;
    PXX(I+1) = (RXX(1) + TUM1) /M;  %功率谱密度
    PYY(I+1) = (RYY(1) + TOM1) /M;
    OXY(I+1) = TOM / (2.0 * M);
end
PXY(1) = PXY(1) / 2.0;
PXY(M+1) = PXY(M+1) / 2.0;
OXY(1) = OXY(1) / 2.0;
OXY(M+1) = OXY(M+1) / 2.0;
PXX(1) = PXX(1) / 2.0;
PXX(M+1) = PXX(M+1) / 2.0;
PYY(1) = PYY(1) / 2.0;
PYY(M+1) = PYY(M+1) / 2.0;

for I = 0:M
    if( abs(PXX(I+1) * PYY(I+1)) > 1e-10)
        CXY(I+1) = abs((PXY(I+1)^2 + OXY(I+1)^2) / (PXX(I+1) * PYY(I+1)));
    else
        CXY(I+1) = abs(PXY(I+1)^2+OXY(I+1)^2)/1e-10;
    end
    if(PXY(I+1)>0.0 & PXY(I+1)<1e-30)
        PXY(I+1) = 1e-40;
    end
    if(PXY(I+1)<0 & abs(PXY(I+1))<1e-30)
        PXY(I+1) = -1e-30; % change from -10.0e-40 to -10.0e-30 due to compile errors 2005-04-17
    end
    O(I+1) = atan(OXY(I+1) / PXY(I+1));
end

for I = 1:M
    T(I+1) = 2. * M /I;
    TL(I+1) = M* O(I+1) / (pi*I);
end

T(1) = 0.0;
TL(1) = 0.0;
UO = 0.0;
T1 = 0.0;
TUO = 0.0;
TTO = 0.0;

for I = 0:M
    UO = UO + PXX(I+1);
    T1 = T1 + PYY(I+1);
end
TUO = UO / (M + 1);
TTO = T1 / (M + 1);
CC =(-1.0 + 1.645 * sqrt( N - 2.0)) / ( N -1.0 );

for I = 0:M
    for JJ = 1:3
        if( RXX(2) < CC)
            TPXX(I+1, JJ) = FF(JJ) * TUO;
        else
            TPXX(I+1, JJ) = FF(JJ) * TUO * ((1. - RXX(2) * RXX(2)) /(1. + RXX(2) * RXX(2) - 2 * RXX(2) *cos(pi * I / M)));
        end
        if( RYY(2)<CC)
            TPYY(I+1, JJ) = FF(JJ) * TTO;
        else
            TPYY(I+1, JJ) = FF(JJ) * TTO * ((1. - RYY(2) * RYY(2)) /(1. + RYY(2) * RYY(2) - 2. * RYY(2) *cos(pi* I / M)));
        end
    end
end

%---------- clean up output data
T=T(1,2:M+1)';
PXX=PXX(1,2:M+1)';
TPXX=TPXX(2:M+1,:);