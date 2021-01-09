clear;
close all;
clc

%====================================
%Initial conditions
%====================================
y1=input('Type initial height(m): ');
r1=[0, y1];
speed=input('Enter initial speed (m/s): ');
theta=input('Enter angle (degrees): ');
v1=[speed*cos(theta*pi/180), speed*sin(theta*pi/180)];
r=r1; v=v1;
%========================================
%Physical parameters
%========================================
Cd=0.35;
area=4.3e-3;
grav=9.81;
mass=0.134;
airFlag=input('Air resistance? (Yes:1, No:0) ');
if(airFlag==0)
    rho=0; 
else
    rho=1.2;
end
air_const=-0.5*Cd*rho*area/mass;
%=========================================
tau=input('Enter timestep, tau(sec): ');
maxstep=1000;
for i=1:maxstep
    xplot(i)=r(1);
    yplot(i)=r(2);
    t=(i-1)*tau;
    xNoAir(i)=r1(1)+v(1)*t;
    yNoAir(i)=r1(2)+v(2)*t-0.5*grav*t^2;
    accel=air_const*norm(v)*v;
    accel(2)=accel(2)-grav;
    r=r+tau*v;
    v=v+tau*accel;
    if (r(2)<0)
        xplot(i+1)=r(1);
        yplot(i+1)=r(2);
        break;
    end
end
%========================================
fprintf('Maximum range is %g(m)', r(1));
fprintf('Time of flight is %g(s) \n',i*tau);
%=============PLOT=======================
clf;
figure(gcf);
xground=[0 max(xNoAir)];
yground=[0 0];
plot(xplot,yplot,'+', xground, yground,'-');
legend('Euler');
xlabel('Range(m)');
ylabel('Height(m)');
title('Projectile motion');