% function x = synsq_cwt_iw(Tx, fs, opt, Cs, freqband)
%
% Inverse Synchrosqueezing transform of Tx with associated
% frequencies in fs and curve bands in time-frequency plane
% specified by Cs and freqband.  This implements Eq. 5 of [1].
%
% 1. G. Thakur, E. Brevdo, N.-S. Fučkar, and H.-T. Wu,
% "The Synchrosqueezing algorithm for time-varying spectral analysis: robustness
%  properties and new paleoclimate applications," Signal Processing, 93:1079-1094, 2013.
%
% Input:
%   Tx, fs: See help synsq_cwt_fw
%   opt: options structure (see help synsq_cwt_fw)
%      opt.type: type of wavelet used in synsq_cwt_fw
%
%      other wavelet options (opt.mu, opt.s) should also match
%      those used in synsq_cwt_fw
%	Cs: (optional) curve centerpoints
%	freqs: (optional) curve bands
%
% Output:
%   x: components of reconstructed signal, and residual error
%
% Example:
%   [Tx,fs] = synsq_cwt_fw(t, x, 32); % Synchrosqueezing
%   Txf = synsq_filter_pass(Tx, fs, -Inf, 1); % Pass band filter
%   xf = synsq_cwt_iw(Txf, fs);  % Filtered signal reconstruction
%
%---------------------------------------------------------------------------------
%    Synchrosqueezing Toolbox
%    Authors: Eugene Brevdo, Gaurav Thakur
%---------------------------------------------------------------------------------
function x = synsq_cwt_iw(Tx, fs, opt, Cs, freqband)
    if nargin<3, opt = struct(); end
    if ~isfield(opt, 'type'), opt.type = 'morlet'; end
	if nargin<4, Cs = ones(size(Tx,2),1); end
	if nargin<5, freqband = size(Tx,1); end

    % Find the admissibility coefficient Cpsi
    Css = synsq_adm(opt.type, opt);
	
	% Invert Tx around curve masks in the time-frequency plane to recover
	% individual components; last one is the remaining signal
    % Integration over all frequencies recovers original signal
	% factor of 2 is because real parts contain half the energy
	x = zeros(size(Cs,1),size(Cs,2)+1);
	TxMask = zeros(size(Tx));
	TxRemainder = Tx;
	for n=[1:size(Cs,2)]
		TxMask = zeros(size(Tx));
		UpperCs=min(max(Cs(:,n)+freqband(:,n),1),length(fs));
		LowerCs=min(max(Cs(:,n)-freqband(:,n),1),length(fs));
		%Cs==0 corresponds to no curve at that time, so this removes such points from the inversion
		UpperCs(find(Cs(:,n)<1))=1;
		LowerCs(find(Cs(:,n)<1))=2;
		for m=[1:size(Tx,2)]
			TxMask(LowerCs(m):UpperCs(m),m) = Tx(LowerCs(m):UpperCs(m), m);
			TxRemainder(LowerCs(m):UpperCs(m),m) = 0;
		end
		% Due to linear discretization of integral in log(fs), this becomes a simple normalized sum.
		x(:,n) = 1/Css*sum(real(TxMask),1).';
	end
	x(:,n+1) = 1/Css*sum(real(TxRemainder),1).';
	x = x.';
    xx=x(1,:);
    clear x
    x=xx;
end
