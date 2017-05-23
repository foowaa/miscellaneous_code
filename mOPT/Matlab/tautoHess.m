function H = autoHess(funObj,x,varargin)% Numerically compute Hessian of objective function from gradient values% funObj is the objective function, x is initial value% type =%     1 - forward-differencing (p+1 evaluations)%     2 - central-differencing (more accurate, but requires 2p evaluations)%     default type = 1type=1;p = length(x);if type == 2	% Use finite differencing	mu = 2*sqrt(1e-12)*(1+norm(x));	g=autoGrad(funObj,x,varargin{:});	diff = zeros(p);	for j = 1:p		e_j = zeros(p,1);		e_j(j) = 1;		diff(:,j) = autoGrad(funObj,(x + mu*e_j),varargin{:});	end	H = (diff-repmat(g,[1 p]))/mu;else % Use central differencing	mu = 2*sqrt(1e-12)*(1+norm(x));	diff1 = zeros(p);	diff2 = zeros(p);	for j = 1:p		e_j = zeros(p,1);		e_j(j) = 1;		diff1(:,j) = autoGrad(funObj,(x + mu*e_j),varargin{:});		diff2(:,j) = autoGrad(funObj,(x - mu*e_j),varargin{:});    end	H = (diff1-diff2)/(2*mu);end% Make sure H is symmetricH = (H+H')/2;