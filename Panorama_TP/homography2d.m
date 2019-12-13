% HOMOGRAPHY2D - computes 2D homography
%
% Usage:   H = homography2d(x1, x2)
%          H = homography2d(x)
%
% Arguments:
%          x1  - 3xN set of homogeneous points
%          x2  - 3xN set of homogeneous points such that x1<->x2
%         
%           x  - If a single argument is supplied it is assumed that it
%                is in the form x = [x1; x2]
% Returns:
%          H - the 3x3 homography such that x2 = H*x1
%
% This code follows the normalised direct linear transformation 
% algorithm given by Hartley and Zisserman "Multiple View Geometry in
% Computer Vision" p92.
%

% Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
% pk at csse uwa edu au
% http://www.csse.uwa.edu.au/~pk
%
% May 2003  - Original version.
% Feb 2004  - Single argument allowed for to enable use with RANSAC.
% Feb 2005  - SVD changed to 'Economy' decomposition (thanks to Paul O'Leary)

function H = homography2d(varargin)
    
    [x1, x2] = checkargs(varargin(:));

    % Attempt to normalise each set of points so that the origin 
    % is at centroid and mean distance from origin is sqrt(2).
    [x1, T1] = normalise2dpts(x1);
    [x2, T2] = normalise2dpts(x2);
    
    % Note that it may have not been possible to normalise
    % the points if one was at infinity so the following does not
    % assume that scale parameter w = 1.
    
    
    % TODO : Create matrix A
    A = [];
    N = size(x1, 2);
    for i = 1:N;
       A_i = [];
       A11 = transpose(zeros(3, 1));
       A12 = (-1)*(x2(3, i))*transpose(x1(:, i)); 
       A13 = x2(2, i)*transpose(x1(:, i));
       
       A21 = (-1)*A12;
       A22 = A11;
       A23 = (-1)*x2(1, i)*transpose(x1(:, i));
       
       A_i = [A11 A12 A13; A21 A22 A23];
       
       A   = [A; A_i];
    end   
    % TODO : perform SVD
    [U, Segma, V] = svd(A);
    
    % TODO : Extract homography from SVD result
    H = V(:, end);
    H = reshape(H, [3,3]);
    
    % Denormalise
    H = T2\H*T1;
end

%--------------------------------------------------------------------------
% Function to check argument values and set defaults

function [x1, x2] = checkargs(arg);
    
    if length(arg) == 2
	    x1 = arg{1};
	    x2 = arg{2};
	if ~all(size(x1)==size(x2))
	    error('x1 and x2 must have the same size');
	elseif size(x1,1) ~= 3
	    error('x1 and x2 must be 3xN');
	end
	
    elseif length(arg) == 1
	if size(arg{1}, 1) ~= 6
	    error('Single argument x must be 6xN');
	else
	    x1 = arg{1}(1:3, :);
	    x2 = arg{1}(4:6, :);
	end
    else
	error('Wrong number of arguments supplied');
  end
end
    