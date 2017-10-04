%AW:  see comments blow. 0.9/1.

% am132
% Akash Mitra

%Inclass assignment 8

%Using the swalign function
% A. Create a random DNA sequence of length 100. 

Nuc = ["A","C","T","G"];
NucPos =randi(numel(Nuc),[1 100]);
randomSeq = strjoin(Nuc(NucPos), "");
randomSeq = char(randomSeq);

% B. Create a second sequence from the first one by changing the middle 20 basepairs (at positions 41-60)
RepNucPos =randi(numel(Nuc),[1 20]);
midSeq = strjoin(Nuc(RepNucPos), "");
midSeq = char(midSeq);
newSeq = strcat(randomSeq(1:40), midSeq, randomSeq(61:100));

% C. run swalign on the two sequences with the default parameters
Score_default = swalign(randomSeq, newSeq);

% D. run swalign with much higher and lower values of the GapOpen parameter
% and explain the results. 

%AW: by default swalign uses the amino acid alphabet. Set 'alphabet' to 'nt'. -0.05. 

Score_higherpenalty = swalign(randomSeq, newSeq, 'GapOpen', 100);
Score_lowerpenalty = swalign(randomSeq, newSeq, 'GapOpen', .0001);

% We observe that with a higher gap penalty, the score is lower than the
% score we observed with the default parameter (of 8) due to the fact that 
% a gap in the sequence is penalized far higher than in the default setting.
% With a lower gap penalty we observe a higher score than under the deafult
% parameters since the penalty for opening a gap is far lower. This allows
% for sequences to have multiple gaps and only actually matching for the
% cases where there is alignment. In this situation, it is likely that the
% first and last 40 bases are perfectly aligned, with non perfect matches
% in the middle sequence recieving gaps.

%AW: Ok. note also that raising the gap penalty will cause mismatches rather than gaps. -0.05.

% E. run swalign with a low value of GapOpen but a high value of ExtendGap,
% explain the result

Score_loweropen_higherextension = swalign(randomSeq, newSeq, 'GapOpen', .0001, 'ExtendGap', 100);

% The score is based on an affine gap penalty scheme. The first opening
% gap is scored with a low penalization and the penalty for keeping the gap
% open is assigned at a value of 100. This results in a score very similar
% to the score of the low gap opening penalty. The score obtained under
% these circumstances is marginally lower than the score with just a low
% gap opening penalty. Likely, the first 40 and last 40 bases have been
% algined perfecetly with the middle 20 new bases having been assigned as
% gaps. The difference being that since the gap extension penalty is
% higher, the optimal alignment will favor having multiple smaller gaps
% than one large gap.


% F. run swalign align with the default value of GapOpen and a low value
% of ExtendGap and explain the result. 

Score_defaultopen_lowerextension = swalign(randomSeq, newSeq, 'ExtendGap', 0.00001);

% With the default gap opening penalty and a low extension penalty, a
% longer gap would be favored over the past alignment. The score itself is
% marginally higher than the score run under initial default parameters.
% The optimal alignment in this circumstance will favor having one large
% gap in the middle 20 sequences since the opening of the gap is high, but
% the cost to keep the gap open is low.
