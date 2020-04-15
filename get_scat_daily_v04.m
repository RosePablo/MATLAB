function [mingmt,windspd,winddir,scatflag,radrain]=get_scat_daily_v04(data_file)
% [mingmt,windspd,winddir,scatflag,radrain]=get_scat_daily_v04(data_file);
%
%this subroutine will read compressed or uncompressed RSS scatterometer daily bytemaps.
%reads version-3a files released October 2006
%reads version-4 files released April 2011
%
%input argument is the full path file name:
%   get_scat_daily_v04(filename)
%
%output arguments:
%   [mingmt,windspd,winddir,scatflag,radrain]
%   mingmt is gmt time in minutes of day
%   windspd in m/s	(10 meter surface wind)
%   winddir in degrees 	(oceanographic convention, blowing North = 0)
%   scatflag		(0=no rain, 1=rain)
%   radrain   in km*mm/hr  (-999.0 = no collocation available)
%                       (  -1.0 = adjacent cells had rain, but not this cell)
%                       (   0.0 = radiometer data exist and show no rain)
%				(   0.5 - 31.0 = columnar rain rate in km*mm/hr)
%
%  The center of the first cell of the 1440 column and 720 row map is at 0.125 E longitude and -89.875 latitude.
%  The center of the second cell is 0.375 E longitude, -89.875 latitude.
% 		XLAT=0.25*ILAT-90.125
%		XLON=0.25*ILON-0.125
%
%please read the description file on www.remss.com
%for infomation on the various fields, or contact RSS support:
% http://www.remss.com/support
%
%

xscale=[6.,.2,1.5];
xdim=1440;ydim=720;tdim=2;numvar=4;
mapsiz=xdim*ydim*tdim;

if ~exist(data_file,'file'),
    disp(['file not found: ' data_file]);
    mingmt=[];windspd=[];winddir=[];scatflag=[];radrain=[];
    return;
end;

if ~isempty(regexp(data_file,'.gz', 'once'))
    data_file=char(gunzip(data_file));
end

fid=fopen(data_file,'rb');
data=fread(fid,mapsiz*numvar,'uint8');
fclose(fid);
%disp(data_file);
map=reshape(data,[xdim ydim numvar tdim]);

for iasc=1:tdim
    for ivar=1:numvar
        if ivar<4,
            dat=map(:,:,ivar,iasc);
            map(:,:,ivar,iasc) = dat*xscale(ivar);
        else,
            dat=map(:,:,ivar,iasc);
            scatflag(:,:,iasc) = dat-2*fix(dat/2); % bit 1
            rad_flag(:,:,iasc) = fix((dat-4*fix(dat/4))/2); % bit 2
            temp=fix(dat/4); % bits 3-8
            temp2 = -999*ones(size(dat));
            rflag=rad_flag(:,:,iasc);
            for j=1:prod(size(temp2))
                if rflag(j)==1
                    if temp(j)==0
                        temp2(j)=0;
                    elseif temp(j)==1
                        temp2(j)=-1;
                    else
                        temp2(j)=temp(j)/2-0.5;
                    end;
                end;
            end;  % j loop
            radrain(:,:,iasc)=temp2;
        end;   % switch
    end;	  % ivar loop
end;    % iasc loop


mingmt  = squeeze(map(:,:,1,:));
windspd = squeeze(map(:,:,2,:));
winddir = squeeze(map(:,:,3,:));


bad = find(mingmt > 1440);
windspd(bad) = -999.;
winddir(bad) = -999.;
scatflag(bad)= -999.;
radrain (bad)= -999.;

return;

