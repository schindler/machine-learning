clear all
close all
clc
tic();
load_train;
toc();

tic();
printf("Settings...\n");fflush(stdout);

N=2000;
Nines = X(find(y==9)(1:N),:);
Zeros = X(find(y==0)(1:N),:);
 
A=[Nines ones(N,1) eye(N) zeros(N); Zeros ones(N,1) zeros(N) -eye(N)];
   
b=[ones(N,1); -ones(N,1)];
c=[sparse(columns(X)+1,1); ones(2*N,1)];

Ct=[repmat("L",1,N) repmat("U",1,N)];
Vt= repmat("C", 1, numel(c));
toc();

tic();
printf("Training...\n");fflush(stdout);
[x,z,s]=glpk(c,A,b, [], [], Ct, Vt);
toc();





