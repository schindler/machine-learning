## Copyright (C) 2014 Fernando
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
## @deftypefn {Function File} {@var{retval} =} guess (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Fernando <Fernando@PC-ESCRITÓRIO>
## Created: 2014-12-25

function guess ()
   load('handw45hh10lambda.data');
   t     = get_data();
   p = mod(predict(input, output, t),10);
   printf ("%d\n", p);
endfunction
