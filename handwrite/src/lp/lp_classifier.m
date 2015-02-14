## Copyright (C) 2015 Fernando
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

##
## Creates a Linear classifier given X and y to label1 (l1) and label2 (l2)
##

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} lp_classifier (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Fernando <Fernando@PC-ESCRITÓRIO>
## Created: 2015-01-04

function [A, B] = lp_classifier (X, y, l1, l2, N)

Label1 = X(find(y==l1)(1:N),:);
Label2 = X(find(y==l2)(1:N),:);

A=[Label1 ones(N,1) eye(N) zeros(N); Label2 ones(N,1) zeros(N) -eye(N)];
b=[ones(N,1); -ones(N,1)];
c=[sparse(columns(X)+1,1); ones(2*N,1)];

Ct=[repmat("L",1,N) repmat("U",1,N)];
Vt= repmat("C", 1, numel(c));

[x,z,s]=glpk(c,A,b, [], [], Ct, Vt);

#A(1:N,:)*=-1;
#b(1:N)  *=-1;
#n = numel (c);
#fid = fopen("test101.dict", "w+");
#[fm, fn] = size(A);
#dlmwrite (fid, [fm fn], " ");
#dlmwrite (fid, [n+1:n+fm+1], " ");
#dlmwrite (fid, [1:n], " ");
#dlmwrite (fid, b', " ");
#dlmwrite (fid, full(-A), " ");
#dlmwrite (fid, [0 -c'], " ");
#fclose(fid);
# [x,z,s]=simplex(A,b,-c);
 
A=x(1:columns(X));
B=x(columns(X)+1);

endfunction
