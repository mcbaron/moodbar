function [Dc, d] = selfsim(S)
% selfsim takes S, which is the matrix produced by the STFT, and creates Dc
% which is the self similarity matrix of the signal, which is the
% similarity of the signal to itself at varying intervals. The similarity
% between the two signals is the cosine between the two spectra when
% expressed as vectors.
%
% Dc -  Self-similarity matrix
% d  -  sum of superdiagonals
%
% 20131225 -mcbaron

% Self-similar if autocorrelation remains constant
% Self-similar processes are invariant to scale, where as stochastic
% processes are invariant to time.

Dc = S'*S;
N  = sqrt(diag(Dc));
Dc = Dc./(N*N');
% Effecient means to calculate self-similarity matrix. Thanks to Rodger
% Stafford on the Mathworks forums.

d = zeros(1, size(S,2)-1);
for l = 2:size(S,2)
    d(l) = sum(diag(Dc,l));
end


end