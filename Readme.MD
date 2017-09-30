Dictionary Files: Using random basis: dictionary(Spartsity)-(dictionarysize)-(number_of_iterations)iter.text
                  Using DCT basis : dictionary(Spartsity)-(dictionarysize)-(number_of_iterations)dctiter.text

Sparsity Files: Same as above


Sequence of operations:
1) Calculate fft using the calculatefft.m file
2) Find dictionary using K-SVD algorithm: ksvd.m
3) Remove redundant vectors from dictionary: redundant.m
4) Calculate Bhattacharya Co-efficient: scalar.m
5) Calculate Kullback-Leibler dissimilarity: correlation.m followed by KLDiv.m Note: Enter transpose of rf and lf in KLDiv.m
6) Find distribution of dot product using ditri.m

