## Copyright (C) 2014 Fernando Schindler
## @example
##   simplex (A,b,c)
## @end example 

## -*- texinfo -*-
## @deftypefn {Function File} {} simplex (@var{A}, @var{b}, @var{c})
## Solves: MAX c'* x
##         st: A * x <= b
##                 x >= 0
## @var{A} A matrix containing the constraints coefficients.   
## @var{b} A column array containing the right-hand side value for each constraint in the constraint matrix.
## @var{c} A column array containing the objective function coefficients.
## @end deftypefn

## Author: SCH <fernando.schindler@gmail.com>
## Created: 03 November 2014

function [x,z,e,s] = simplex(A, b, c)
  [m,n] = size(A);

  steps = 0;
  x     = [];
  z     = NaN;
  e     = "FEASIBLE";
  s     = [];
  zd    = 0;

  if m != size(b)(1)
    e = "INCOMPATIBLE b";
    return
  end

  if n != size(c)(1)
    e = "INCOMPATIBLE c";
    return
  end

  if any (b < 0)
    [xd,zd,ed,sd] = simplex(-A', ones(size(c)), -b);
    if strcmp(ed, "UNBOUNDED") == 1
      e = "UNFEASIBLE";
      return
    end
    steps = sd.ST;
    XII   = complement(sd.DB, n, m);
    XBI   = complement(sd.DI, n, m);
  else
    XII   = 1:n;
    XBI   = n+1:n+m;
  end

  A  = [A  speye(m)];
  c  = [c; sparse(m,1)];

  while 1
    AB  = A(:,XBI);
    CBt = c(XBI,:)'; 
    CI  = c(XII,:);
    N   = AB \ b;
    z   = CBt * N;
 
    et = getEntering(CI' - CBt * (AB \ A(:,XII)), XII);
    if et > 0
      l = getLeaving(AB \ (-A(:,XII(et))), N, XBI);
      if l > 0 
         t = XBI(l);
         XBI(l)  = XII(et);
         XII(et) = t;
         steps  += 1;
         continue
      end     
      e = "UNBOUNDED";
      break
    end
 
    x = zeros (n,1);
    i = find (XBI <= n); 
    x (XBI(i)) = N(i);
 
    if nargout() == (4)
      s.ST=steps;
      s.DI=XII;
      s.DB=XBI;
    end
    
    break
  end;
end

function l = getLeaving(Aj, N, XBI)
  s = Inf;
  l = 0;
  for i = 1: numel(N)
    if Aj(i) < -10e-6
      d = N(i) / -Aj(i);
      if (l > 0) && (abs(s-d) < 10e-6)
          if XBI(l) > XBI(i)
             s = d;
             l = i;
          end
      else
        if d < s
          s = d;
          l = i;
        end
      end
    end
  end
end

function e = getEntering(ZC, XII)
  e = 0;
  for i=1:numel(ZC)
    if ZC(i) > 10e-6
      if e == 0
        e = i;
      else
        if ZC(i) > ZC(e)
          e = i;
        end
      end
    end
  end
end 

function Xc = complement(X, b, n)
  Xc = zeros(size(X));
  for e = 1:numel(X)
     Xc(e) = mod((X(e)+b-1), (b + n)) + 1;
  end
end