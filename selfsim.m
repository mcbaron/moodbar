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
% 20131218 -mcbaron

Dc = zeros(size(S,2));
% Self-similar if autocorrelation remains constant
% Self-similar processes are invariant to scale, where as stochastic
% processes are invariant to time.

for i = 1:length(S)
    for j = 1:length(S)
        Dc(i,j) = (S(:,i)' * S(:,j))/(norm(S(:,i))*norm(S(:,j)));
    end
end

d = zeros(1, length(S));
for l = 1:length(S)
    d(l) = sum(diag(Dc,l-1));
end 
    

end