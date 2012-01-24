function [U, T]=lamb_exact(dt)
%% this function plots the exact solution to Lamb's problem
%% for Poisson material ( mu = lambda ) 
%% at a distance r for a pointsource in 0,0 with time dependence
%% F(t) 
%% The solution is obtained by convolution of the 
%% kernel g(t) and f(t)=d/dt F(t).
%
% Input:
%  dt: time step in T and U
% 

tmax=5;

t3 = 0:dt:tmax+0.5*dt;
r=1000;
U=[];
T=[];
for t=t3
  T=[T; t];
  U=[U; mooney(r,t)];
end

function uz=mooney(r,t);
Vp=sqrt(3)*1000;
Vs=1000;
rho=1500;
delta=Vp/Vs;
gamma=0.5*sqrt(3+sqrt(3));
Z=-1e13; %% forcing amplitude minus sign for downward forcec
mu=rho*Vs^2;
A=Z/(pi^2*r*mu)*(Vp/Vs)^2*r/Vs;
tau=t*Vs/r;
uz=A*gp(tau,delta,gamma,r,Vs);

function u=gp(tau,delta,gamma,r,Vs);
% convolve f(r*tau/Vs) with g(tau)
% search for small enough value for tauprim 

tol1=1e-18;
taupmin=-tau;
while ((abs(f(taupmin*r/Vs))>tol1) & (abs(g(taupmin,delta,gamma))>tol1))
  taupmin=2*taupmin;
end

%% works for newer versions
tol=1e-6;
Q=quadl(@(t)convolve(t,tau,delta,gamma,r,Vs),taupmin,tau,tol);
%% works with old Matlab
%Q=quadl(@convolve,taupmin,tau,1e-9,[],tau,delta,gamma,r,Vs);
u=Q;

function y=convolve(t,tau,delta,gamma,r,Vs)
y=g(tau-t,delta,gamma).*f(t*r/Vs);

function u=f(t)
w0=1;
t0=2/w0;
%% Ricker
tmp=pi^2*w0^2*(t-t0).^2;
u=(2*tmp-1).*exp(-tmp);
%% Gauss
%tmp=0.5*w0^2*(t-t0).^2;
%u=w0/sqrt(2*pi)*exp(-tmp);

function gg=g(tt,delta,gamma);
%% The kernal from Mooney BSSA Vol 64 N0 2 pp. 437-491 
gg=0*tt;
gt=0;
for i=1:length(tt)
  t=tt(i);
  if t<(1/delta)
    gt=0;
  end
  if (t<1) & (t>1/delta) 
    gt=-pi/96*(6-sqrt(3*sqrt(3)+5)/sqrt(gamma^2-t^2)...
	       +sqrt(3*sqrt(3)-5)/sqrt(t^2-0.25*(3-sqrt(3)))...
	       -sqrt(3)/sqrt(t^2-0.25));
  end
  if (t<gamma) & (t > 1)
    gt=-pi/48*(6-sqrt(3*sqrt(3)+5)/sqrt(gamma^2-t^2));
  end
  if t>=gamma 
    gt=-pi/8;
  end
  gg(i)=gt;
end
