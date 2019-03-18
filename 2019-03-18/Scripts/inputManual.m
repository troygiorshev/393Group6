function [ f ] = inputManual( t )
	% Write your own equation here.
	
	%---------- This is an example of something you could do to create a discontinuous function.
	  
    if (t <= 5)
		f = t^2;
	else
		f = t + 20;
	end

	%-----------
end
