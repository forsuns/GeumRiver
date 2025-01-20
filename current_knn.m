clear all;
close all;
clc;

xmin=273000;
xmax=310000;
ymin=3980000;
ymax=4003000;
dis=5000;
sort=600;
sortData=1;
csort=200;
scal=2000;
sc=0.30;
barposit = 1; % 0 is left, else is right
northposit = 1; % 0 is left, else is right
island='./islandNames.txt';
%north symbol scale
northLabelSize=15;
xd=0.070; %label position, lager is left
yd=0.077; %label position, smaller is down

xDistance=xmax-xmin;
yDistance=ymax-ymin;
xyRate=yDistance/xDistance;

%north symbol scale and setting
if (northposit==0)
    nsCenterX=xmin+dis*(sc*1.5);
else
    nsCenterX=xmax-dis*(sc*1.5);
end
nsCenterY=ymax-dis*(sc*2.2);

nsWestX=nsCenterX-dis*(sc*0.3);
nsEastX=nsCenterX+dis*(sc*0.3);
nTPouthY=nsCenterY-dis*sc;
nsNorthY=nsCenterY+dis*sc;
nsX1=[nsWestX nsCenterX nsEastX nsWestX];
nsY1=[nsCenterY nsNorthY nsCenterY nsCenterY];
nsX2=[nsWestX nsCenterX nsEastX nsWestX];
nsY2=[nsCenterY nTPouthY nsCenterY nsCenterY];
%north symbol box position
symbolBoxX=[nsWestX-dis*0.2 nsEastX+dis*0.2 nsEastX+dis*0.2 nsWestX-dis*0.2];
symbolBoxY=[nTPouthY-dis*0.1 nTPouthY-dis*0.1 nsNorthY+dis*0.2 nsNorthY+dis*0.2];
%north symbol box
%symbolBoxH=mapshow(symbolBoxX,symbolBoxY,...
%    'DisplayType','polygon','FaceColor',[1 1 1],'FaceAlpha',1);

%scale bar box position
if (barposit == 0)
    sbx=xmin+dis*0.15;
else
    sbx=xmax-dis*1.45;
end
sby=ymin+dis*0.15;
boxXStart=sbx-dis*0.1;
boxYStart=sby-dis*0.1;
boxXEnd=boxXStart+dis*1.50;
boxYEnd=boxYStart+dis*0.47;
boxX=[boxXStart boxXEnd boxXEnd boxXStart];
boxY=[boxYStart boxYStart boxYEnd boxYEnd];
%scale bar set
bar1X=[sbx sbx+dis*0.5 sbx+dis*0.5 sbx];
bar1Y=[sby sby sby+dis*0.1 sby+dis*0.1];
bar2X=[sbx+dis*0.5 sbx+dis sbx+dis sbx+dis*0.5];
bar2Y=[sby sby sby+dis*0.1 sby+dis*0.1];
%legend position and scale
legendx=sbx;
legendy=sby+dis*0.2;
legendu=1.0; %100 centimeter/second
legendv=0;

%island names set
[inX,inY,inames]=textread(island,'%f %f %s');hold on
nIsland=length(inX);
nS=0;
    for i=1:nIsland
        %if (inX(i)>xmin)&&(inY(i)>ymin)&&(inX(i)<xmax)&&(inY(i)<ymax)
            nS=nS+1;
            inXSort(nS)=inX(i);
            inYSort(nS)=inY(i);
            inSort(nS)=inames(i);
        %end
    end   

%figure configuration
figWidth = 10; % inch
figHeight = figWidth*xyRate; % inch
marginUp = 0.7; % inch
marginRight = 0.3; % inch
marginLeft = 1.0; % inch
marginDown = 0.7; % inch

fontName = 'times new roman';
set(0,'defaultaxesfontName',fontName);
set(0,'defaulttextfontName',fontName);
fontsize = 18; % pt
set(0,'defaultaxesfontsize',fontsize);
set(0,'defaulttextfontsize',fontsize);
set(0,'fixedwidthfontName','times');

%main
load ./basemap.mat
nBase=length(xx);


    % load
  M1 = csvread('./knn_cur.csv',0,0);
  K = M1(:,2) ;
  tim = M1(:,3) ;
  x1 = M1(:,5) ;
  y1 = M1(:,6) ;
  uu1 = M1(:,14)*0.01 ;
  vv1 = M1(:,16)*0.01 ;
  uu2 = M1(:,15)*0.01 ;
  vv2 = M1(:,17)*0.01 ;
  
  tt1=13.5833;  % time
  tt2=13.8333;  % time
  
  A1 = (tim==tt1) ;
  TA = tim(A1);
  K1 = K(A1);
  X1 = x1(A1);
  Y1 = y1(A1);
  U1 = uu1(A1);
  V1 = vv1(A1);
  U2 = uu2(A1);
  V2 = vv2(A1);
  A2 = (tim==tt2) ;
  U3 = uu1(A2);
  V3 = vv1(A2);
  U4 = uu2(A2);
  V4 = vv2(A2);
  
  B1 = (K1==1) ;
  T2 = TA(B1);
  K2 = K1(B1);
  X2 = X1(B1);
  Y2 = Y1(B1);
  U11 = U1(B1);
  V11 = V1(B1);
  U21 = U2(B1);
  V21 = V2(B1);
  U31 = U3(B1);
  V31 = V3(B1);
  U41 = U4(B1);
  V41 = V4(B1);
  B2 = (K1==5) ;
  U15 = U1(B2);
  V15 = V1(B2);
  U25 = U2(B2);
  V25 = V2(B2);
  U35 = U3(B2);
  V35 = V3(B2);
  U45 = U4(B2);
  V45 = V4(B2);
  
  xxx=X2;
  yyy=Y2;
  uo101=U11;
  vo101=V11;
  uc101=U21;
  vc101=V21;
  uo201=U31;
  vo201=V31;
  uc201=U41;
  vc201=V41;
  uo105=U15;
  vo105=V15;
  uc105=U25;
  vc105=V25;
  uo205=U35;
  vo205=V35;
  uc205=U45;
  vc205=V45;
   
  tvel1 = sqrt(uo105.^2+vo105.^2);
  tvel2 = sqrt(uo101.^2+vo101.^2);
  tvel3 = sqrt(uo205.^2+vo205.^2);
  tvel4 = sqrt(uo201.^2+vo201.^2);
  tvel5 = sqrt(uc105.^2+vc105.^2);
  tvel6 = sqrt(uc101.^2+vc101.^2);
  tvel7 = sqrt(uc205.^2+vc205.^2);
  tvel8 = sqrt(uc201.^2+vc201.^2);
  
%   tang1 = atan2(vv,uu);
%   
  R = [T2 xxx yyy K2 uo105 vo105 uo101 vo101 uo205 vo205 uo201 vo201 uc105 vc105 uc101 vc101 uc205 vc205 uc201 vc201]';
name={R}'
[nrows,ncols]= size(name);
filename = 'R1_lin.txt';
fid = fopen(filename, 'w');
for row=1:nrows
    fprintf(fid, '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f\n', name{row,:});
end
fclose(fid);

   fnout1(1,:) ='./current_knn105.png';
   fnout1(2,:) ='./current_knn101.png';
   fnout1(3,:) ='./current_knn205.png';
   fnout1(4,:) ='./current_knn201.png';

   titleN1(1,:)=['Spring Flood Current at : ' num2str(tt1) ' day(s),  Surface Layer'];
   titleN1(2,:)=['Spring Flood Current at : ' num2str(tt1) ' day(s),  Bottom  Layer'];
   titleN1(3,:)=['Spring Ebb Current at   : ' num2str(tt2) ' day(s),  Surface Layer'];
   titleN1(4,:)=['Spring Ebb Current at   : ' num2str(tt2) ' day(s),  Bottom  Layer'];

%map sorting
ng=0;
nVector=length(xxx);

    if sort>sortData
        xxVelocity=xxx-(mod(xxx,sort));
        yyVelocity=yyy-(mod(yyy,sort));
        for i=1:nVector
            for j=i:nVector
            if ((xxVelocity(i)==xxVelocity(j))&&...
                    (yyVelocity(i)==yyVelocity(j)))
                if (i~=j)
                xxVelocity(j)=0;
                yyVelocity(j)=0;
                end
            end
            end
        end
    end

    if sort<=sortData
        xxVelocity=xxx;
        yyVelocity=yyy;
    end
    
    nS=0;
    xxSort=0;
    yySort=0;

        for i=1:nVector
            if (xxVelocity(i)>xmin)&&(yyVelocity(i)>ymin)&&...
                (xxVelocity(i)<xmax)&&(yyVelocity(i)<ymax)
                nS=nS+1;
                xxSort(nS)=xxVelocity(i);
                yySort(nS)=yyVelocity(i);
                uuSort1(nS,1)=uo105(i);
                vvSort1(nS,1)=vo105(i);
                uuSort1(nS,2)=uo101(i);
                vvSort1(nS,2)=vo101(i);
                uuSort1(nS,3)=uo205(i);
                vvSort1(nS,3)=vo205(i);
                uuSort1(nS,4)=uo201(i);
                vvSort1(nS,4)=vo201(i);
                uuSort2(nS,1)=uc105(i);
                vvSort2(nS,1)=vc105(i);
                uuSort2(nS,2)=uc101(i);
                vvSort2(nS,2)=vc101(i);
                uuSort2(nS,3)=uc205(i);
                vvSort2(nS,3)=vc205(i);
                uuSort2(nS,4)=uc201(i);
                vvSort2(nS,4)=vc201(i);
            end
        end
    xxSort=xxSort';
    yySort=yySort';
  
    %contour map
    gx=xmin:csort:xmax;
    gy=ymin:csort:ymax;
    [gx gy]=meshgrid(gx,gy);
    [xi yi zi1(:,:,1)]=griddata(xxx,yyy,tvel1,gx,gy);
    [xi yi zi1(:,:,2)]=griddata(xxx,yyy,tvel2,gx,gy);
    [xi yi zi1(:,:,3)]=griddata(xxx,yyy,tvel3,gx,gy);
    [xi yi zi1(:,:,4)]=griddata(xxx,yyy,tvel4,gx,gy);
    [xi yi zi1(:,:,5)]=griddata(xxx,yyy,tvel5,gx,gy);
    [xi yi zi1(:,:,6)]=griddata(xxx,yyy,tvel6,gx,gy);
    [xi yi zi1(:,:,7)]=griddata(xxx,yyy,tvel7,gx,gy);
    [xi yi zi1(:,:,8)]=griddata(xxx,yyy,tvel8,gx,gy);
            
     close all
            
     for i=1:4
            figure(i)
            uuSort=uuSort1(:,i);
            vvSort=vvSort1(:,i);
            ucSort=uuSort2(:,i);
            vcSort=vvSort2(:,i);
            fnout = fnout1(i,:);
            hFig = figure(i);
            titleN =titleN1(i,:);
            zi = zi1(:,:,i);
            set(hFig,'renderer','opengl');
            set(hFig,'units','inches');
            set(hFig,'position',[3 6 figWidth figHeight]);
            set(hFig,'PaperUnits','inches');
            set(hFig,'PaperSize', [figWidth figHeight]);
            set(hFig,'PaperPositionMode', 'manual');
            set(hFig,'PaperPosition',[0 0 figWidth figHeight]);
            set(hFig,'Color','w');
            hAxe = axes;
            set(hAxe,'activepositionproperty','outerposition');
            set(hAxe,'units','inches');
            ax_pos = get(hAxe,'position');
            ax_pos(4) = figHeight-marginUp-marginDown;
            ax_pos(2) = figHeight-(marginUp+ax_pos(4));
            ax_pos(3) = figWidth-marginLeft-marginRight;
            ax_pos(1) = marginLeft;
            set(hAxe,'position',ax_pos);
          
            %Vector map
             mapH(1)=quiver(xxSort,yySort,uuSort*scal,vvSort*scal,'AutoScale','off','color','k','LineWidth',1.5);hold on
             mapH(2)=quiver(xxSort,yySort,ucSort*scal,vcSort*scal,'AutoScale','off','color','r');hold on
            %title1
             title(titleN,'fontsize',18); hold on
            %base map
             h=mapshow(xx,yy,'DisplayType','polygon','FaceColor',[1 0.88 0.21],'FaceAlpha',1); hold on
             axis([xmin xmax ymin ymax])
            %north symbol
             mapshow(nsX1,nsY1,'DisplayType','polygon','FaceColor',[0 0 0],'FaceAlpha',1);hold on
             mapshow(nsX2,nsY2,'DisplayType','polygon','FaceColor',[1 1 1],'FaceAlpha',1);hold on
             text(nsCenterX-(dis*xd),nsNorthY+(dis*yd),'N','Color','k','FontSize',northLabelSize); 
            %island names
             textIslandH=text(inXSort,inYSort,inSort,'Color',[0 0 0],'FontSize',12); hold on
             uistack(textIslandH,'top');
            %scale bar box
             boxH=mapshow(boxX,boxY,'DisplayType','polygon','FaceColor',[1 1 1],'FaceAlpha',1);
             bar1H=mapshow(bar1X,bar1Y,'DisplayType','polygon','FaceColor',[0 0 0],'FaceAlpha',1);
             bar2H=mapshow(bar2X,bar2Y,'DisplayType','polygon','FaceColor',[1 1 1],'FaceAlpha',1);
            %scale label
             text(sbx+dis+dis*0.05,sby+dis*0.05,num2str(dis*0.001,'%3.0f'),'Color','k','FontSize',10);
             hold on
             text(sbx+dis+dis*0.18,sby+dis*0.05,'km','Color','k','FontSize',10); % km
             
             %legend vector
             qx = [0;legendx;0];
             qy = [0;legendy;0];
             qu = [0;legendu;max(abs(uuSort))];
             qv = [0;legendv;max(abs(vvSort))];
             apH=quiver(qx,qy+dis*0.05,qu*scal*1,qv*scal*2,'AutoScale','off','color','k');
             text(legendx+legendu*scal*1,legendy+dis*0.05+legendv*scal*2,[num2str(legendu) ' m/s, East'],'Color','k','FontSize',12);
             lh=legend(mapH,'EFDC Model','Trained Model','Location','North');      
             xlabel('UTM, Easting(m)');
             ylabel('Northing(m)');
             %print1
             print(hFig,fnout,'-dpng','-r200');
     end