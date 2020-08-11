tic
clc;
close all;
clear all;
walkers=1000;
N=800;
B=10;
p=0.2;
alive1=walkers;
alive2=walkers;
t=0;
tk=0;
esuresi=0;
kesuresi=0;
x=zeros(walkers,N);
y=zeros(walkers,N);
z=zeros(walkers,N);

%Yansima
for i=1:walkers
    for j=1:N
        if(j==N)
            break;
        end
        x(i,j+1)=x(i,j)+randn(1,1);
        if  x(i,j+1)>B
            x(i,j+1)=B-abs(B-x(i,j+1));
        else 
            x(i,j+1)=-B+abs(-B-x(i,j+1));
        end
    end
end
%Emilim
    for i=1:walkers
    for j=1:N
        if(j==N)
        break;
        end

        y(i,j+1)=y(i,j)+randn(1,1);
        if (y(i,j+1)>= B) || (y(i,j+1)<= -B)
        t=t+j+1;     
        break;
        end
    end 
    end
%Kismi Emilim
    for i=1:walkers
    for j=1:N
        if(j==N)
        break;
        end

        z(i,j+1)=z(i,j)+randn(1,1);
        if rand(1,1)<p
        if z(i,j+1)> B
        z(i,j+1)=B-abs(B-z(i,j+1));
        else
        z(i,j+1)=-B+abs(-B-z(i,j+1));
        end
        else
        if z(i,j+1)>= B || z(i,j+1)<= -B
        tk=tk+j+1;   
            break;
        end    
        end      
    end
end

esuresi=t/walkers;
kesuresi=tk/walkers;
fprintf('Ortalama emilme suresi: %f\n',esuresi)
fprintf('Ortalama kismi emilme suresi: %f\n',kesuresi)

figure;
average=sum(x,1)/walkers;
average2=sum(y,1)/walkers;
average3=sum(z)/walkers;
grid on
plot(1:N,average,'-r')
hold on
plot(1:N,average2,'-b')
hold on
plot(1:N,average3,'-g')
xlabel('Zaman')
ylabel('Ortalama Pozisyon')
title('Ortalama Pozisyonun Zamana Bagli Grafigi');
legend('Yansima','Emilim','Kismi Emilim')
axis([ 0 N -B B])
hold off

figure;
st1=std(x);
st2=std(y);
st3=std(z);
plot(1:N,st1,'-r')
hold on
plot(1:N,st2,'-b')
hold on
plot(1:N,st3,'-g')
xlabel ('Zaman/Adim Sayisi')
ylabel('Standart Sapma')
title('Standart Sapmanin Zamana Bagli Grafigi');
legend('Yansima','Emilim','Kismi Emilim')
axis([ 0 N 0 B])

figure;
a=y(:,1:N);
b=z(:,1:N);
alive1=sum(a~=0);
alive2=sum(b~=0);
plot(1:N,alive1,'-b')
hold on
plot(1:N,alive2,'-g')
xlabel ('Zaman/Adim Sayisi')
ylabel('Hayatta Kalan Yuruyuscu')
title('Hayatta Kalan Yuruyusculerin Zamana Bagli Grafigi');
legend('Emilim','Kismi Emilim')
toc