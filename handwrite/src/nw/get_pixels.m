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
## @deftypefn {Function File} {@var{retval} =} get_pixels (@var{file})
##
## @seealso{}
## @end deftypefn

## Author: Fernando <Fernando@PC-ESCRITÓRIO>
## Created: 2014-12-20

function images = get_pixels(file)
  fid = fopen(file, "rb");
  if fid > 0
    [h,c]  = fread(fid, 4, "int32", "ieee-be");
    if (2051)  == h(1)
       nRecords = h(2);
       pixRows  = h(3);
       pixCols  = h(4);
       images   = zeros(nRecords, pixRows * pixCols);
       for i=1:nRecords
          P=fread(fid, (pixRows * pixCols), "uint8");
          P(find(P>100))=250; #TODO Ver como melhorar
          images (i,:) = feature_normalize(P);
       endfor
    endif  
    fclose(fid);
  endif
endfunction
