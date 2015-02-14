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

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} lp_guess (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Fernando <Fernando@PC-ESCRITÓRIO>
## Created: 2015-01-04

function [val] = lp_guess (X, y, data)
  p=0:9;  
  while numel (p) > 1
    l1=p(1);,
    l2=p(2);
    [A,b]=lp_classifier(X, y, l1, l2, 200);
    if (data*A+b)>0
      p=p(find(p!=l2)); printf("Not %d\n",l2); fflush(stdout);
    else
      p=p(find(p!=l1)); printf("Not %d\n",l1); fflush(stdout);
    end   
  endwhile   
  val = p(1); 
endfunction
