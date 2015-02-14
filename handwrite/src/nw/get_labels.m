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
## @deftypefn {Function File} {@var{labels} =} get_labels (@var{file})
##
## @seealso{}
## @end deftypefn

## Author: Fernando <Fernando@PC-ESCRITÓRIO>
## Created: 2014-12-20

function labels = get_labels (file)
  fid = fopen(file, "rb");
  if fid > 0
    [h,c]  = fread(fid, 2, "int32", "ieee-be");
    if (2049) == h(1)
      labels = fread(fid, h(2), "uint8");
    endif
    fclose(fid);
  endif
endfunction
