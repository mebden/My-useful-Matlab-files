% Generates a signal from white noise spectra, or vice versa
% By Mark Ebden
% Note the spectrum of white noise is: constant magnitude uniformly
% for all frequencies, but phase can be anything from 0 to 2 pi 

if 1==1,
    % A. In normalised frequency
	N = 1024;
	if 1==1,
      Xk_amp = ones(N,1);
      Xk_phase = rand(N,1)*2*pi;
      Xk = Xk_amp.*exp(i*Xk_phase);
      xn = ifft(Xk,N);
	else
      xn = rand(N,1)-0.5;
      Xk = fft(xn,N);
	end
	figure; subplot (2,1,1); plot(real(xn));
	subplot (2,1,2); plot(abs(Xk));

else
	% B. This took A to the next level
    % Assume a given sampling frequency; plus, no longer white necessarily
	N = 1024; Fs = 3;
	t = 1/Fs:1/Fs:N/Fs;
	freq = (0:N-1)/N*Fs;
	if 1==1,
      Xk_amp = zeros(N,1);
      Xk_amp(round(0.09/Fs*N):round(0.11/Fs*N)) = 1;
      Xk_phase = rand(N,1)*2*pi;
      Xk = Xk_amp.*exp(i*Xk_phase);
      xn = ifft(Xk,N);
	else
      xn = rand(N,1)-0.5;
      Xk = fft(xn,N);
	end
	figure; subplot (2,1,1); plot(t,real(xn),'.-');
	subplot (2,1,2); plot(freq,abs(Xk),'.-');

end