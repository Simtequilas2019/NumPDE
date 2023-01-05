function [x,y]=squareg(bs,s)
% Example of a geometry representing a unit square with 4 boundary
% segments.
%
% The numbering is as follows:
% The lower edge, right edge, top edge and left edge have 
% boundary segment number 1, 2, 3 and 4.
% 
% 
% If no arguments are given: only x is assigned and gives the 
% number of boundary segments. 
%
% If the arguments bs and s are given:
%
% The function performs a local-to-global coordinate mapping:
% Function returns a list of x and y-values of points on the
% boundary of the geometry. The input points are specified by their
% boundary segment number and the local coordinate (parameter). 
% The input vectors bs and s are assumed to have the same length.
% bs is assumed to be a vector of boundary segment numbers with
% values between 1 and 4.
% s is assumed to be a vector of local coordinates on the edge
% segment, hence values between 0 and 1, where 0 corresponds to the
% start point, i.e. first node of the edge, 0.5 is the midpoint and
% 1.0 is the end point of the edge.
%
% Example for returning all midpoints of the edges: 
%   [x,y] = squareg([1,2,3,4],[0.5, 0.5, 0.5, 0.5])
% =>  x = 0.5000    1.0000    0.5000         0
%     y = 0         0.5000    1.0000         0.5000

nbs=4;

if nargin==0,
  x=nbs; % number of boundary segments
  return
end

d=[
  0 0 0 0 % start parameter value
  1 1 1 1 % end parameter value
  1 1 1 1 % left hand region
  0 0 0 0 % right hand region
];

bs1=bs(:)';

if find(bs1<1 | bs1>nbs),
  error('squareg:InvalidBs', 'Non existent boundary segment number.')
end

if nargin==1,
  x=d(:,bs1);
  return
end

x=zeros(size(s));
y=zeros(size(s));
[m,n]=size(bs);
if m==1 && n==1,
  bs=bs*ones(size(s)); % expand bs
elseif m~=size(s,1) || n~=size(s,2),
  error('squareg:SizeBs', 'bs must be scalar or of same size as s.');
end

if ~isempty(s),
  % boundary segment 1
  ii=find(bs==1);
  x(ii) = s(ii);
  y(ii) = zeros(size(ii));

  % boundary segment 2
  ii=find(bs==2);
  x(ii) = ones(size(ii));
  y(ii) = s(ii);

  % boundary segment 3
  ii=find(bs==3);
  x(ii) = 1-s(ii);
  y(ii) = ones(size(ii));

  % boundary segment 4
  ii=find(bs==4);
  x(ii) = zeros(size(ii));
  y(ii) = 1-s(ii);
end
