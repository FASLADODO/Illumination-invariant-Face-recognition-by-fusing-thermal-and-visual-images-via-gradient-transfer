clc;
clear;
close all;
warning off;
addpath(genpath(cd));
yy=zeros(40,1);
x=zeros(40,1);
    for i=1:40
      x(i,1)=i;
    end
    for ii=1:40
I=double(imread('197-detect.jpg'))/255; %lake_IR.png'))/255; in '\GTF\GTF\img' directory
V=double(imread('197-visual.jpg'))/255; %lake_VIS.png'))/255;
%I=rgb2gray(I);
%V=rgb2gray(V);
V=imadjust(V);
%figure,imshow(I);
%figure,imshow(V);
%I=im2double(imread('L-48.bmp'));
%I=I(13:219,28:320,:);
%I1=im2double(imread('V-48.bmp'));
%I1=I1(45:240,:,:);

calc_metric = 1; % Calculate the metrices is time consuming, it is used for quantitative evaluation. Set it to 0 if you do not want to do it.

%%
%The proposed GTF
nmpdef;
pars_irn = irntvInputPars('l1tv');

pars_irn.adapt_epsR   = 1;
pars_irn.epsR_cutoff  = 0.01;   % This is the percentage cutoff
pars_irn.adapt_epsF   = 1;
pars_irn.epsF_cutoff  = 0.05;   % This is the percentage cutoff
pars_irn.pcgtol_ini = 1e-4;
pars_irn.loops      = 5;
pars_irn.U0         = I-V;
pars_irn.variant       = NMP_TV_SUBSTITUTION;
pars_irn.weight_scheme = NMP_WEIGHTS_THRESHOLD;
pars_irn.pcgtol_ini    = 1e-2;
pars_irn.adaptPCGtol   = 1;

tic;
U = irntv(I-V, {}, ii, pars_irn);
t0=toc;

X=U+V;
X=im2gray(X);
imshow(X);
%imwrite(X,s3,'jpg');
y=0;
for i=1:355
    for j=1:191        
        y=y+abs(X(i,j)-U(i,j));
    end
end
z=X-V;
[Gmag, Gdir] = imgradient(z);
for i=1:355
    for j=1:191
        y=y+ii*Gmag(i,j);
    end
end
f=y;
yy(ii,1)=f;
    end
    
    plot(x,yy);