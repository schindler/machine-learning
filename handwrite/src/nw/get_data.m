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
## @deftypefn {Function File} {@var{retval} =} get_data (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Fernando <Fernando@PC-ESCRITÓRIO>
## Created: 2014-12-21

function [image] = get_data()
  fid = fopen ("test.data", "rb");
  image = feature_normalize(fread(fid, 28*28, "uint8")');
  fclose(fid);
endfunction
