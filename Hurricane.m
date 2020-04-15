%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MATLAB program Hurricane.m
%
% Purpose:
%
%    Extract, plot and write data for the dry experiment.
%
%    Edit the "user defined input variables" section to adapt
%    the program for your case.
%
% History:
%
%    20120201 (Lodovica Illari)
%    20130323 (Charles Chemel)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  clc; clear; close all;

  disp(' ');
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  disp('%                                                                               ');
  disp('% MATLAB program Hurricane.m                                                    ');
  disp('%                                                                               ');
  disp('% Purpose:                                                                      ');
  disp('%                                                                               ');
  disp('%    Extract, plot and write data for the dry experiment.                       ');
  disp('%                                                                               ');
  disp('%    Edit the "user defined input variables" section to adapt                   ');
  disp('%    the program for your case.                                                 ');
  disp('%                                                                               ');
  disp('% History:                                                                      ');
  disp('%                                                                               ');
  disp('%    20011201 (Jim Price)                                                       ');
  disp('%    20130317 (Charles Chemel)                                                  ');
  disp('%                                                                               ');
  disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% User defined input variables
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Data source (q = QuickScat, w = WindSat)

% source = 'q';
  source = 'w';

% Data filename

% fname = 'qscat_20060919v4.gz';
  fname = 'wsat_20110905v7.gz';

% Storm name

% storm = 'Helene';
  storm = 'Katia';

% [latitude, longitude] of the storm's centre, longitude from 0 to 360

% cntr = [24.5 -52.0+360];
  cntr = [24.5 -62.5+360];

% Pass (1 = ascending pass, 2 = descending)

  pass = 1;

% Degrees from the storm's centre for which to extract data

  pad = 5;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Do not modify the rest of the program
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Figures

  set(0,'DefaultLineLineWidth',1.4);
  set(0,'DefaultTextFontSize',12);
  set(0,'DefaultAxesLineWidth',1.3);
  set(0,'DefaultAxesFontSize',12);

% Extract the data

  lon = [0.125:.25:359.875];
  lat = [-89.875:.25:89.875];

  if source == 'q'
    [mingmt,windspd,winddir,scatflag,radrain] = ...
    get_scat_daily_v04(fname);
  elseif source == 'w'
    [mingmt,sst,windLF,windMF,vapor,cloud,rain,windspd,winddir] = ...
    read_windsat_daily_v7(fname);
  else
    disp('Unknown data source. Please check variable "source".');
    return;
  end 

% Discard missing values

  elim = find(windspd == -999);
  windspd(elim) = NaN;
  winddir(elim) = NaN;

% Find indexes of the lat/lon box

  lt1 = find(lat <= (cntr(1)-pad),1,'last');
  lt2 = find(lat >= (cntr(1)+pad),1,'first');
  ln1 = find(lon <= (cntr(2)-pad),1,'last');
  ln2 = find(lon >= (cntr(2)+pad),1,'first');

% Calculate (approximate) radius from the strom's centre
% for all points within the lat/lon box

  [latgrid,longrid] = meshgrid(lat(lt1:lt2),lon(ln1:ln2));
  radius = 110000. * distance(latgrid,longrid,cntr(1),cntr(2));

%
% Figures
%

% Figure 1: wind speed within the lat/lon box

  figure(1);
  clf reset;

  [c,h] = contour(lon(ln1:ln2),lat(lt1:lt2),windspd(ln1:ln2,lt1:lt2,pass)');
  clabel(c,h);
  hold on;
  thet = 0:.05:2*pi;
  for r = 1:pad
    rad = r*ones(1,length(thet));
    [xc,yc] = pol2cart(thet,rad);
    x = xc + cntr(2);
    y = yc + cntr(1);
    plot(x,y,'k:');
  end
  plot(cntr(2),cntr(1),'kx');
  axis square;
  hold off;
  title(['Wind speed (m s^-^1) for ',storm]);
  xlabel('Longitude (^oE)');
  ylabel('Latitude (^oN)');

% Figure 2: streamlines within the lat/lon box

  figure(2);
  clf reset;

% Calculate zonal and meridional wind

  u = windspd .* sind(winddir);
  v = windspd .* cosd(winddir);

  h = streamslice(lon(ln1:ln2),lat(lt1:lt2), ...
                  u(ln1:ln2,lt1:lt2,pass)',v(ln1:ln2,lt1:lt2,pass)');
  title(['Streamlines for ',storm]);
  xlabel('Longitude (^oE)');
  ylabel('Latitude (^oN)');
  set(gca,'xlim',lon([ln1 ln2]));
  set(gca,'ylim',lat([lt1 lt2]));
  axis square;

% Figure 3: wind speed as a function of radius

  figure(3);
  clf reset;

% Create subarray of wind speed within the lat/lon box

  wind = windspd(ln1:ln2,lt1:lt2,pass);

% Sort arrays into vectors with increasing radius

  [radsort,I] = sort(radius(:));
  windsort = wind(I);

  plot(radsort/1000,windsort,'+k');
  xlabel('Radius  (km)');
  ylabel('Wind speed (m s^-^1)');
  title(['Wind speed vs. radius for ',storm]);
  set(gca,'xlim',[0 pad*110]);

% Write the wind speed and radius data in the file radius_windspeed.csv

  fid = fopen('radius_windspeed.csv','w');

  d = [radsort/1000.,windsort];

  fprintf(fid,'%s\n','R(km),U(m/s)')
  fclose(fid)

  dlmwrite('radius_windspeed.csv',d,'-append');
