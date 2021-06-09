figure; ax = usamap('conus');
set(ax, 'Visible', 'off')
states = shaperead('usastatelo', 'UseGeoCoords', true);
names = {states.Name};
indexConus = 1:numel(states);
stateColor = [0.5 1 0.5];
geoshow(ax, states(indexConus),  'FaceColor', stateColor)
setm(ax, 'Frame', 'off', 'Grid', 'off',...
     'ParallelLabel', 'off', 'MeridianLabel', 'off')